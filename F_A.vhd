library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;


entity fulladder is 
 port(a, b, cin: in std_logic;
         s, cout: out std_logic);
end entity fulladder;

architecture struct of fulladder is
 signal s1, s2, s3, s4, s5, s7, s8, s9, s10, s11, s12, a1, a2, a3, a4,a5,a6,a2bar,a4bar,o1,o1bar,a6bar : std_logic;
  begin
   --A XOR B - output s7
  NAND1: NAND_2 port map(A => a, B => a, Y => s1);
  NAND2: NAND_2 port map(A => b, B => b, Y => s2);   
  NAND3: NAND_2 port map(A => s1, B => s2, Y => s3);
  NAND4: NAND_2 port map(A => a, B => b, Y => s4);
  NAND5: NAND_2 port map(A => s3, B => s4, Y => s5);
  NAND6: NAND_2 port map(A => s5, B => s5, Y => s7);
  --s7 XOR Cin - output s
  NAND11: NAND_2 port map(A => s7, B => s7, Y => s8);
  NAND12: NAND_2 port map(A => cin, B => cin, Y => s9);   
  NAND13: NAND_2 port map(A => s8, B => s9, Y => s10);
  NAND14: NAND_2 port map(A => s7, B => cin, Y => s11);
  NAND15: NAND_2 port map(A => s10, B => s11, Y => s12);
  NAND16: NAND_2 port map(A => s12, B => s12, Y => s);
  --A AND B - out a2
  NAND17: NAND_2 port map(A=> a, B=> b, Y => a1);
  NAND18: NAND_2 port map(A=> a1, B=> a1, Y => a2);
  --A AND Cin - out a4
  NAND19: NAND_2 port map(A=> a, B=> cin, Y => a3);
  NAND20: NAND_2 port map(A=> a3, B=> a3, Y => a4);
  --B AND Cin - out a6
  NAND21: NAND_2 port map(A=> b, B=> cin, Y => a5);
  NAND22: NAND_2 port map(A=> a5, B=> a5, Y => a6);
  --a2 or a4 - out o1
   NAND23 : NAND_2 port map(A => a2, B => a2, Y => a2bar);
   NAND24 : NAND_2 port map(A => a4, B => a4, Y => a4bar);
   NAND25 : NAND_2 port map(A => a2bar, B=> a4bar, Y => o1);
	--o1 or a6 - out cout
   NAND26 : NAND_2 port map(A => o1, B => o1, Y => o1bar);
   NAND27 : NAND_2 port map(A => a6, B => a6, Y => a6bar);
   NAND28 : NAND_2 port map(A => o1bar, B=> a6bar, Y => cout);
end architecture struct;
	