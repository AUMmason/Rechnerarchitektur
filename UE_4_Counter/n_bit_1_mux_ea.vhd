library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity n_bit_1_mux_ea is
  generic(
    WIDTH : integer
  );
  port (
    signal a_i, b_i : in std_ulogic_vector(WIDTH - 1 downto 0);
    signal sel_i : in std_ulogic;
    signal data_o : out std_ulogic_vector(WIDTH - 1 downto 0)
  );
end entity n_bit_1_mux_ea;

architecture rtl of n_bit_1_mux_ea is
  type std_ulogic_vector_array is array (natural range <>) of std_ulogic_vector(WIDTH - 1 downto 0);
  signal options : std_ulogic_vector_array(1 downto 0);
  signal sel_vec : std_ulogic_vector(3 downto 0);
begin

  options(0) <= a_i;
  options(1) <= b_i;

  sel_vec <= (0 => sel_i, others => '0');
  data_o <= options(to_integer(unsigned(sel_vec)));
  
end architecture rtl;
