library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity counter is
  generic (width: integer);
  port(clk, reset: in  std_ulogic;
       up:         in  std_ulogic;
       y:          out std_ulogic_vector(width-1 downto 0));
end;    

architecture struct of counter is
  signal count : std_ulogic_vector(width - 1 downto 0);
  signal increment : std_ulogic_vector(width - 1 downto 0) := std_ulogic_vector(to_unsigned(1, width));
  signal not_increment, increment_adder : std_ulogic_vector(width - 1 downto 0);
  signal adder_out, adder_in : std_ulogic_vector(width -1 downto 0);
  signal not_up : std_ulogic; 
begin

  y <= count;

  not_increment <= NOT increment;
  not_up <= NOT up;

  inv_b: entity work.n_bit_1_mux_ea 
  generic map (
    WIDTH => WIDTH
  )
  port map (
    a_i => increment,
    b_i => not_increment,
    sel_i => not_up,
    data_o => increment_adder
  );

  -- Handles over-/underflow automatically
  adder: entity work.cr_adder_ea
  generic map(
    BIT_WIDTH => WIDTH
  )
  port map(
    a_i => adder_in,
    b_i => increment_adder,
    c_i => not_up,
    c_o => open,
    r_o => adder_out
  );

  FF: entity work.ff(bhv)
    generic map(
      WIDTH => WIDTH
    )
    port map(
      clk => clk,
      reset => reset,
      d => adder_out,
      q => count
    );
  

  reset_mux: entity work.n_bit_1_mux_ea
  generic map (
    WIDTH => WIDTH
  )
  port map(
    a_i => count,
    b_i => (others => '0'),
    sel_i => reset,
    data_o => adder_in
  );

end;
