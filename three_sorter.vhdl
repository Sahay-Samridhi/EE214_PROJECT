library ieee;
use ieee.std_logic_1164.all;

entity three_sorter is 
       port(inp1,inp2,inp3: in std_logic_vector(7 downto 0);
             --clock: in std_logic;
             min,median,max: out std_logic_vector(7 downto 0));
end three_sorter;

architecture behav of three_sorter is
    component two_sorter is 
       port(inp1,inp2: in std_logic_vector(7 downto 0);
             --clock: in std_logic;
             min,max: out std_logic_vector(7 downto 0));
    end component two_sorter;

    signal l1,l2,h1: std_logic_vector(7 downto 0);

    begin
        sorter1: two_sorter port map(inp1,inp2,l1,h1);
        sorter2: two_sorter port map(inp3,h1,l2,max);
        sorter3: two_sorter port map(l1,l2,min,median);

end behav;