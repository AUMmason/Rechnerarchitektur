library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity half_adder_ea is
  port (
    signal a_i : in std_ulogic;
    signal b_i : in std_ulogic;
    signal r0_o : out std_ulogic;
    signal r1_o : out std_ulogic
  );
end entity half_adder_ea;

architecture rtl of half_adder_ea is
  
begin
  r1_o <= a_i AND b_i; -- a ∧ b  (Carry)
  r0_o <= a_i XOR b_i; -- a ⊕ b (1 bit sum)
end architecture;