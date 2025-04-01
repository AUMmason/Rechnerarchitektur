library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package alu_package is
  constant INPUT_BIT_WIDTH : integer := 32;
  type std_ulogic_vector_array is array (natural range <>) of std_ulogic_vector(INPUT_BIT_WIDTH - 1 downto 0);
  -- Custom datatype for allowing multiple inputs having individual bit vectors
end package alu_package;
