library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity LINEBUFFER is
  port( clk,clk_128,reset: in std_logic;
        input_data: in std_logic_vector(7 downto 0);
		  A0,A1,A2,A3,A4,A5,A6,A7,A8: out std_logic_vector(7 downto 0));
end entity;

architecture bhv of LINEBUFFER is 
    type LineBuffer is array(0 downto 129) of std_logic_vector( 0 downto 7);
	 signal lb1,lb2,lb3,lb4: LineBuffer:= (others=>"000000000");
	 
	 type state is (rst,s0_1,s0_2,s0_3,s1,s2,s3,s4); -- Fill other states here
---------------Define signals of state type-----------------------
    signal y_present,y_next: state:=rst;
	 
variable i,j,k,l: integer := 0;

	 
begin

clock_proc:process(clk,reset)

begin
if(clk_128='1' and clk_128' event) then
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
  y_next<=s0_1;
when s0_1=>
  y_next<=s0_2;
when s0_2=>
  y_next<=s0_3;
when s0_3=>
  y_next<=s1;
when s1=>
  y_next<=s2;
when s2=>
  y_next<=s3;
when s3=>
  y_next<=s4;
when s4=>
  y_next<=s1;

end case;
end process;


fill_process: process(clk,input_data)
begin
case y_present is
    when rst=>
	   lb1 <= (others=>"000000000");
		lb2 <= (others=>"000000000");
		lb3 <= (others=>"000000000");
		lb4 <= (others=>"000000000");
	 
	 
	  when s0_1=>
	     if rising_edge(clk) then
		     for i in 1 to 128 loop
			      lb1(i)<=input_data;
				end loop;
			end if;
	 when s0_2=>
	     if rising_edge(clk) then
		     for j in 1 to 128 loop
			      lb2(j)<=input_data;
				end loop;
			end if;
	 when s0_3=>
	     if rising_edge(clk) then
		     for k in 1 to 128 loop
			      lb3(k)<=input_data;
				end loop;
			end if;
	 
	 when s1=>
	      if rising_edge(clk) then
			   for l in 1 to 128 loop
				    lb4(l)<=input_data;
					 A0<=lb1(l-1);        A1<=lb1(l);      A2<=lb1(l+1);
					 A3<=lb2(l-1);       A4<=lb2(l);      A5<=lb2(l+1);
					 A6<=lb3(l-1);        A7<=lb3(l);      A8<=lb3(l+1); 
				end loop;
			end if;
			
	 when s2=>
	      if rising_edge(clk) then
			   for l in 1 to 128 loop
				    lb1(l)<=input_data;
					 A0<=lb2(l-1);        A1<=lb2(l);      A2<=lb2(l+1);
					 A3<=lb3(l-1);       A4<=lb3(l);      A5<=lb3(l+1);
					 A6<=lb4(l-1);        A7<=lb4(l);      A8<=lb4(l+1); 
				end loop;
			end if;
			
	 when s3=>
	      if rising_edge(clk) then
			   for l in 1 to 128 loop
				    lb2(l)<=input_data;
					 A0<=lb3(l-1);        A1<=lb3(l);      A2<=lb3(l+1);
					 A3<=lb4(l-1);        A4<=lb4(l);      A5<=lb4(l+1);
					 A6<=lb1(l-1);        A7<=lb1(l);      A8<=lb1(l+1); 
				end loop;
			end if;
			
	 when s4=>
	      if rising_edge(clk) then
			   for l in 1 to 128 loop
				    lb3(l)<=input_data;
					 A0<=lb4(l-1);        A1<=lb4(l);      A2<=lb4(l+1);
					 A3<=lb1(l-1);        A4<=lb1(l);      A5<=lb1(l+1);
					 A6<=lb2(l-1);        A7<=lb2(l);      A8<=lb2(l+1); 
				end loop;
			end if;
			
end case;

		end process;	
	 
	     end bhv;