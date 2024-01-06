library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.NAND_2;

entity XOR_gate is
 port(p, q : in std_logic;
         r : out std_logic);
end entity XOR_gate;

architecture struct of XOR_gate is
 signal s1, s2, s3, s4, s5 : std_logic;
begin 
 NAND1 : NAND_2 port map(A => p, B => p, Y => s1);
 NAND2 : NAND_2 port map(A => q, B => q, Y => s2);
 NAND3 : NAND_2 port map(A => s1, B => s2, Y => s3);
 NAND4 : NAND_2 port map(A => p, B => q, Y => s4);
 NAND5 : NAND_2 port map(A => s3, B => s4, Y => s5);
 NAND6 : NAND_2 port map(A => s5, B => s5, Y => r);
end architecture struct;