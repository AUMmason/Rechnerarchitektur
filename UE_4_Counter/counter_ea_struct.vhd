library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity counter is
  generic (width: integer);
  port(clk, reset: in  std_ulogic;
       up:         in  std_ulogic;
       y:          out std_ulogic_vector(width-1 downto 0));
end;    

architecture struct of counter is
  signal count : std_ulogic_vector(width - 1 downto 0);
  signal increment : std_ulogic_vector(width - 1 downto 0) := to_unsigned(0, width);
  signal increment_adder : std_ulogic_vector(width - 1 downto 0);
  signal overflow : std_ulogic;
  signal result_adder : std_ulogic;
  signal enable : std_ulogic;
begin

  enable <= clk AND NOT reset;

  y <= result_adder;

  inv_b: entity work.n_bit_1_mux_ea 
  generic map (
    WIDTH => WIDTH
  )
  port map (
    a_i => increment,
    b_i => NOT increment,
    sel_i => NOT up,
    data_o => increment_adder
  );

  -- Handles over-/underflow automatically
  adder: entity work.cr_adder_ea
  port map(
    a_i => count,
    b_i => increment_adder,
    c_i => NOT up,
    c_o => overflow,
    r_o => result_adder
  );

  reset: entity work.n_bit_1_mux
  generic map (
    WIDTH => WIDTH
  )
  port map(
    a_i => count,
    b_i => (others => '0'),
    sel_i => reset,
    data_o => count
  );

  update_count: entity work.n_bit_1_mux
  generic map (
    WIDTH => WIDTH
  )
  port map (
    a_i => count,
    b_i => result_adder,
    sel_i => enable,
    data_o => count
  );

end;
