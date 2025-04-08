library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity n_bit_shift_register_ea is
  generic (
    WIDTH : integer
  );
  port (
    signal clk_i, reset_i : in std_ulogic;
    signal first_i : in std_ulogic;
    signal last_o : out std_ulogic 
  );
end entity;

architecture rtl of n_bit_shift_register_ea is
  signal data : std_ulogic_vector(WIDTH - 1 downto 0);
begin
  
  FF0: entity work.ff(bhv)
  generic map (
    WIDTH => WIDTH
  )
  port map (
    clk => clk_i,
    reset => reset_i,
    d => first_i,
    q => data(0)
  );
  
  -- Generate FFs for 1 to n - 1 bits
  FF_generate: for i in 1 to WIDTH - 1 generate
    FF_N: entity work.ff(bhv)
    port map(
      clk => clk_i,
      reset => reset_i,
      d => data(i - 1),
      q => data(i)
    );
  end generate;

FF_last: entity work.ff(bhv)
  generic map (
    WIDTH => WIDTH
  )
  port map (
    clk => clk_i,
    reset => reset_i,
    d => data(WIDTH - 1),
    q => last_o
  );
  
end architecture;