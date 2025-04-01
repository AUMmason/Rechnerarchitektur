library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity full_adder_ea is
  port (
    signal a_i, b_i, c_i : input std_ulogic;
    signal r0_o, r1_o : output std_ulogic;
  );
end entity full_adder_ea;

architecture rtl of full_adder_ea is
  signal HA1_r1, HA2_r1, HA1_r0 : std_ulogic;
begin
  
  HA1: entity work.half_adder_ea(rtl)
    port map(
      a_i => a_i,
      b_i => b_i,
      r1_o => HA1_r1,
      r0_o => HA1_r0
    );
  
  HA2: entity work.half_adder_ea(rtl)
  port map(
    a_i => HA1_r1,
    b_i => c_i,
    r0_o => r0_o,
    r1_o => HA2_r1
  );

  r1_o <= HA1_r1 OR HA2_r1;
  
end architecture;