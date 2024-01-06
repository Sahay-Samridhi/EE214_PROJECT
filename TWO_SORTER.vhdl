library ieee;
use ieee.std_logic_1164.all;

entity TWO_SORTER is 
       port(inp1,inp2: in std_logic_vector(7 downto 0);
             --clock: in std_logic;
             min,max: out std_logic_vector(7 downto 0));
end TWO_SORTER;

architecture behav of two_sorter is

component subtractor is
port(a,b: in std_logic_vector(7 downto 0);
     s: out std_logic_vector(7 downto 0);
     c: out std_logic);
end component subtractor;

component eight_bit_MUX is
   port(a,b: in std_logic_vector(7 downto 0);
        s:in std_logic;
        y:out std_logic_vector(7 downto 0));
end component;

signal y: std_logic_vector(7 downto 0);
signal s: std_logic;
signal nots: std_logic;

begin
nots<=not(s);
   CL: subtractor port map (inp1,inp2,y,s);
   H_MUX: eight_bit_MUX port map (inp2,inp1,s,max);
   L_MUX: eight_bit_MUX port map (inp2,inp1,nots,min);

end behav;