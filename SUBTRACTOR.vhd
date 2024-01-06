library ieee;
use ieee.std_logic_1164.all;

entity SUBTRACTOR is
   port(a, b: in std_logic_vector(7 downto 0);
        s: out std_logic_vector(7 downto 0);
        c: out std_logic);
end entity SUBTRACTOR;

architecture struct of SUBTRACTOR is

  signal x: std_logic_vector(7 downto 0);
  signal c_temp: std_logic_vector(7 downto 0);
  signal k: std_logic_vector(7 downto 0); -- Missing semicolon here

  component fulladder is
    port (
      a, b, cin: in std_logic;
      s, cout: out std_logic
    );
  end component fulladder;

  component XOR_gate is
    port (
      p, q: in std_logic;
      r: out std_logic
    );
  end component XOR_gate;

begin
  k(0) <= '1';

  k_assignment: for i in 1 to 7 generate
    k(i) <= c_temp(i-1);
  end generate;

  carry_logic: for i in 0 to 7 generate
    XOR0: XOR_gate port map (b(i), k(0), x(i));

    FA0: fulladder port map (a => x(i), b => a(i), cin => k(i), s => s(i), cout => c_temp(i));
  end generate;

  c <= c_temp(7);

end architecture struct;
