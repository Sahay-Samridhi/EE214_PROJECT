library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_MUX is
   port(a,b: in std_logic_vector(7 downto 0);
        s:in std_logic;
        y:out std_logic_vector(7 downto 0));
end entity;

architecture behav of eight_bit_MUX is

component two_MUX is
 port(I0,I1,S: in std_logic;
      Y: out std_logic);
end component two_MUX;

begin
    Muxing: for i in 0 to 7 generate
        M: two_MUX port map(a(i),b(i),s,y(i));
    end generate;

end behav;