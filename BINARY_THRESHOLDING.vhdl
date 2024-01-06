library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity THRESHOLD_FREQUENCY_1 is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        input_data : in std_logic_vector(7 downto 0);
        output_data : out std_logic
    );
end THRESHOLD_FREQUENCY_1;

architecture Behavioral of THRESHOLD_FREQUENCY_1 is
    signal threshold : std_logic_vector(7 downto 0) := "01111000";
begin
    process(clk, reset)
    begin
        if rising_edge(clk) then
                if input_data >= threshold then
--                    
                      output_data <= '1';
                else
--                   
                      output_data<= '0';
                end if;

        end if;
    end process;

end Behavioral;
