library ieee;
use ieee.std_logic_1164.all;
use work.alu_package.all;

entity m_bit_n_mux_ea is
  generic(
    SEL_BIT_WIDTH : integer := 3;
    INPUT_BIT_WIDTH : integer := 32
    );
  port (
    signal sel_i : input std_ulogic_vector(SEL_BIT_WIDTH - 1 downto 0);
    signal data_i : input std_ulogic_vector_array(2**SEL_BIT_WIDTH);
    signal data_o : output std_ulogic_vector(INPUT_BIT_WIDTH - 1 downto 0);
  );
end entity;

architecture rtl of m_bit_n_mux_ea is
  
begin
  
  data_o <= data_i(to_integer(unsigned(sel_i)));
  
end architecture;