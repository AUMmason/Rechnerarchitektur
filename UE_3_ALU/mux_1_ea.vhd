library ieee;
use ieee.std_logic_1164.all;
use work.alu_package.all;

entity mux_1_ea is
  port (
    signal sel_i : in std_ulogic;
    signal a_i, b_i : in std_ulogic;
    signal data_o : out std_ulogic
  );
end entity;

architecture rtl of mux_1_ea is
begin

  data_o <= (a_i AND NOT sel_i) OR (b_i AND sel_i);

end architecture;