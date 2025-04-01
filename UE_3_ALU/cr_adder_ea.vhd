library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity cr_adder_ea is
  generic (
    BIT_WIDTH : integer := 32
  );
  port (
    signal a_i, b_i : input std_ulogic_vector(BIT_WIDTH - 1 downto 0);
    signal c_i : input std_ulogic;
    signal c_o : output std_ulogic; 
    signal r_o : output std_ulogic_vector(BIT_WIDTH - 1 downto 0);
  );
end entity cr_adder_ea;

architecture rtl of cr_adder_ea is
  signal carry : input std_ulogic_vector(BIT_WIDTH - 1 downto 0);
begin
  
  carry(0) <= c_i;
  
  full_adder_ea_0: entity work.full_adder_ea
    port map(
      a_i => a_i(0),
      b_i => b_i(0),
      r0_o => r_o(0),
      c_i => c_i,
      r1_o => carry(0)
    );
  
  -- Generate full adders for 1 to n - 1 bits
  full_adder_ea_1: for i in 1 to (BIT_WIDTH - 1) - 1 generate
    full_adder_ea_N: entity work.full_adder_ea
    port map(
      a_i => a_i(i),
      b_i => b_i(i),
      r0_o => r_o(i),
      c_i => carry(i - 1),
      r1_o => carry(i)
    );
  end generate;
  
  full_adder_ea_last: entity work.full_adder_ea
    port map (
      a_i => a_i(BIT_WIDTH - 1),
      b_i => b_i(BIT_WIDTH - 1),
      r0_o => r_o(BIT_WIDTH - 1),
      c_i => carry((BIT_WIDTH - 1) - 1),
      r1_o => c_o
    );

end architecture;