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
  signal sel_vector : std_uloigc_vector(WIDTH - 1 downto 0);
begin
  
  sel_vector <= (others <= sel_i); -- Fill every bit of selection vector with value of sel_i

  data_o <= (a_i AND NOT sel_i) OR (b_i AND sel_i);
  
  
end architecture rtl;
