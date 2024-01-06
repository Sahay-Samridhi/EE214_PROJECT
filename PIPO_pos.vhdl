library ieee;
use ieee.std_logic_1164.all;

entity PIPO_pos is 
    port(D: in std_logic_vector(7 downto 0);
        clock,reset:in std_logic;
        Q:out std_logic_vector(7 downto 0));
end entity PIPO_pos;

architecture struct of PIPO_pos is

    component dff_reset_pos is 
        port(D,clock,reset:in std_logic;
            Q:out std_logic);
    end component dff_reset_pos;

begin
    shift: for i in 0 to 7 generate
        dff:dff_reset_pos port map(D(i),clock,reset,q(i));
    end generate;
end struct;