library ieee;
use ieee.std_logic_1164.all;

entity MEDIANFILTER is
      port(A0,A1,A2,A3,A4,A5,A6,A7,A8: IN STD_LOGIC_VECTOR(7 downto 0); clk,reset:in std_logic; MED: out std_logic_vector(7 downto 0));
		
		end MEDIANFILTER;
		
ARCHITECTURE BEHV OF MEDIANFILTER IS

COMPONENT three_sorter is 
       port(inp1,inp2,inp3: in std_logic_vector(7 downto 0);
             --clock: in std_logic;
             min,median,max: out std_logic_vector(7 downto 0));
end COMPONENT three_sorter;

COMPONENT dff_reset_neg is 
    port(D,clock,reset:in std_logic;
        Q:out std_logic);
end COMPONENT dff_reset_neg;

COMPONENT PIPO_pos is 
    port(D: in std_logic_vector(7 downto 0);
        clock,reset:in std_logic;
        Q:out std_logic_vector(7 downto 0));
end COMPONENT PIPO_pos;

COMPONENT dff_reset_pos is 
    port(D,clock,reset:in std_logic;
        Q:out std_logic);
end COMPONENT dff_reset_pos;

COMPONENT PIPO_neg is 
    port(D: in std_logic_vector(7 downto 0);
        clock,reset:in std_logic;
        Q:out std_logic_vector(7 downto 0));
end COMPONENT PIPO_neg;
     
type state is (rst,s1,s2,s3,s4); -- Fill other states here
---------------Define signals of state type-----------------------
signal y_present,y_next: state:=rst;
	  
type TEMP_ARRAY is array(2 downto 0) of std_logic_vector(7 downto 0);  

	signal LMH1: TEMP_ARRAY := (others => "00000000");
	signal LMH2: TEMP_ARRAY := (others => "00000000");
	signal LMH3: TEMP_ARRAY := (others => "00000000");
	signal LMH4: TEMP_ARRAY := (others => "00000000");
	
	signal min1,med1,max1: std_logic_vector(7 downto 0);
	signal R1,R2,R3,R4,R5,R6: std_logic_vector(7 downto 0); 
	signal store1,store2,store3,store4,store5,store6: std_logic_vector(7 downto 0);
   signal p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12: std_logic_vector (7 downto 0);	
BEGIN

SORTER1: three_sorter  port map (inp1=>p1,inp2=>p2,inp3=>p3,min=>LMH1(0),median=>LMH1(1),max=>LMH1(2));

SORTER2: three_sorter  port map (inp1=>p4,inp2=>p5,inp3=>p6,min=>LMH2(0),median=>LMH2(1),max=>LMH2(2));
SORTER3: three_sorter  port map (inp1=>p7,inp2=>p8,inp3=>p9,min=>LMH3(0),median=>LMH3(1),max=>LMH3(2));
SORTER4: three_sorter  port map (inp1=>p10,inp2=>p11,inp3=>p12,min=>LMH4(0),median=>LMH4(1),max=>LMH4(2));

 REG1: PIPO_neg port map(D=>LMH1(0),clock=>clk,reset=>reset,Q=>R1);
 REG2: PIPO_neg port map(D=>LMH1(1),clock=>clk,reset=>reset,Q=>R2);
 REG3: PIPO_neg port map(D=>LMH1(2),clock=>clk,reset=>reset,Q=>R3);
 

--GEN1:if (clk='1' and clk'event) generate
--  SORTER1: three_sorter  port map (inp1=>A0,inp2=>A1,inp3=>A2,min=>LMH1(0),median=>LMH1(1),max=>LMH1(2));
--  REG1: PIPO_neg port map(D=>LMH1(0),clock=>clk,reset=>rst,Q=>R1);
--    REG2: PIPO_neg port map(D=>LMH1(1),clock=>clk,reset=>rst,Q=>R2);
--	   REG3: PIPO_neg port map(D=>LMH1(2),clock=>clk,reset=>rst,Q=>R3);
--  end generate GEN1;
--  
--	  
--GEN2:	  if (clk='1' and clk'event) generate
--  SORTER2: three_sorter  port map (inp1=>A3,inp2=>A4,inp3=>A5,min=>LMH1(0),median=>LMH1(1),max=>LMH1(2));
--  REG4: PIPO_neg port map(D=>LMH1(0),clock=>clk,reset=>rst,Q=>R4);
--    REG5: PIPO_neg port map(D=>LMH1(1),clock=>clk,reset=>rst,Q=>R5);
--	   REG6: PIPO_neg port map(D=>LMH1(2),clock=>clk,reset=>rst,Q=>R6);
--  end generate GEN2;
--  
--  
--GEN3:  if (clk='1' and clk'event) generate
--  SORTER3: three_sorter  port map (inp1=>A6,inp2=>A7,inp3=>A8,min=>LMH1(0),median=>LMH1(1),max=>LMH1(2));
--  
--  SORTER4: three_sorter  port map (inp1=>R1,inp2=>R4,inp3=>LMH1(0),min=>LMH2(0),median=>LMH2(1),max=>LMH2(2));
--  SORTER5: three_sorter  port map (inp1=>R2,inp2=>R5,inp3=>LMH1(1),min=>LMH3(0),median=>LMH3(1),max=>LMH3(2));
--  SORTER6: three_sorter  port map (inp1=>R3,inp2=>R6,inp3=>LMH1(2),min=>LMH4(0),median=>LMH4(1),max=>LMH4(2));
--  end generate GEN3;
--  
--GEN4:  if (clk='1' and clk'event) generate
--  SORTER7: three_sorter  port map (inp1=>LMH2(2),inp2=>LMH3(1),inp3=>LMH4(0),min=>MIN1,median=>MED,max=>MAX1);
--  END generate GEN4;






-- as it is not possible to perform clocked transition in structural modelling, we have first done the port mapping 
--and then used process with states s1,s2,s3,s4 performing the same tasks as gen1,gen2,gen3,gen4 do.
--state transition occurs on clock 
--tasks are performed accorinding to the reference manual diagram which we used during our discussions.

clock_proc:process(clk,reset)

begin
if(clk='1' and clk' event) then
if(reset='1') then
y_present<= rst;-- Fill the code here
else
y_present<= y_next;

-- Fill the code here
end if;
end if;
end process;

state_transition_proc:process(y_present,y_next)

begin
case y_present is

when rst=>
  y_next<=s1;
when s1=>
  y_next<=s2;
when s2=>
  y_next<=s3;
when s3=>
  y_next<=s4;
when s4=>
  y_next<=rst;

end case;
end process;

output_process: process(A0,A1)

begin
case y_present is 

when rst=>
  null;

when s1=>  
    p1<=A0; p2<=A1; p3<=A2;                 -- AS INPUTS A0,A1,A2 GO INTO P1,P2,P3 THEY ARE GIVEN TO SORTER 1 WHICH GIVES OUTPUT AS LMH1(0),LMH1(1),LMH(2)
	 store1<=R1;store2<=R2;store3<=R3;       -- THIS HAS BEEEN PORT MAPPED TO R1,R2,R3 (STORING MIN,MED,MAX) VALUES ABOVE USING REGISTERS WHICH WE ARE STORING IN VARIABLES STORE1,STORE2,STORE3 
	 
when s2=>
    p1<=A3; p2<=A4; p3<=A5;                  
	 store4<=R1;store5<=R2;store6<=R3;        

when s3=>
    p1<=A6; p2<=A7; p3<=A8;  
-- min med max of these inputs is stored in LMH1(0),LMH1(1),LMH1(2)
--min med max of previous two sorters are already stored in store1...store6.

p4<=store1; p5<=store4; p6<=LMH1(0);
p7<=store2; p8<=store5; p9<=LMH1(1);
p10<=store3; p11<=store6; p12<=LMH1(2);

--performing the sorting in SORTER2,SORTER3,SORTER4 
--storing the required values in min1,med1,max1

min1<=LMH4(0);
med1<=LMH3(1);
max1<=LMH2(2);

when s4=>

p1<=max1;p2<=med1;p3<=min1;
MED<=LMH1(1);

end case;
end process;
end BEHV;