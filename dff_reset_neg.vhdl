--D flip flop with reset
library ieee;
use ieee.std_logic_1164.all;

entity dff_reset_neg is 
    port(D,clock,reset:in std_logic;
        Q:out std_logic);
end entity dff_reset_neg;

architecture behav of dff_reset_neg is

begin
dff_reset_proc: process (clock,reset)
begin

if(reset='1')then -- reset implies flip flip output logic low
Q <= '0'; -- write the flip flop output when reset
elsif (clock'event and (clock='0')) then --detects falling edge
Q <= D; -- write flip flop output when not reset
end if ;
end process dff_reset_proc;
end behav;