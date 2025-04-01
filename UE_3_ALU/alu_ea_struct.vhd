library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.alu_package.all;

entity alu is
  generic(
    WIDTH : integer := 32
  );
  port(signal a, b :      in     std_ulogic_vector(WIDTH - 1 downto 0);
       signal mode :      in     std_ulogic_vector(2 downto 0);
       signal result :    buffer std_ulogic_vector(WIDTH - 1 downto 0);
       signal neg :       buffer std_ulogic
      );
end;

architecture rtl of alu is
  constant MODE_BIT_WIDTH : integer := 3;
  signal mux_data : std_ulogic_vector_array(2**MODE_BIT_WIDTH - 1 downto 0);
  signal data_out : std_ulogic_vector(WIDTH - 1 downto 0);
  signal cr_adder_out : std_ulogic_vector(WIDTH - 1 downto 0);
  signal c_in : std_ulogic;
  signal b_calc : std_ulogic_vector(WIDTH - 1 downto 0);
  signal b_mux : std_ulogic_vector_array(1 downto 0);
begin

  -- Addition / Subtraction

  b_mux(0) <= b;
  b_mux(1) <= NOT b;

  -- Invert b for performing subtraction
  MUX_INV_B : entity work.m_bit_n_mux_ea
    generic map(
      INPUT_BIT_WIDTH => WIDTH,
      SEL_BIT_WIDTH => 1
    )
    port map(
      sel_i(0) => mode(2),
      data_i => b_mux,
      data_o => b_calc
    );

  -- Sets c_in for cr_adder depending on addition (= 0) or subtraction (= 1)
  MUX_SET_c_in : entity work.mux_1_ea
    port map(
      sel_i => mode(2),
      a_i => '0',
      b_i => '1',
      data_o => c_in
    );
  
  cr_adder : entity work.cr_adder_ea
    generic map(
      BIT_WIDTH => WIDTH
    )
    port map(
      a_i => a,
      b_i => b_calc,
      c_i => c_in,
      c_o => open,
      r_o => cr_adder_out
    );

  -- Operation Selection

  MUX_OUTPUT : entity work.m_bit_n_mux_ea
    generic map(
      INPUT_BIT_WIDTH => WIDTH,
      SEL_BIT_WIDTH => MODE_BIT_WIDTH   
    )
    port map(
      sel_i => mode,
      data_i => mux_data,
      data_o => data_out
    );

  mux_data(0) <= a OR b;                -- 000 
  mux_data(1) <= a AND b;               -- 001
  mux_data(2) <= cr_adder_out;          -- 010 (a + b)
  mux_data(3) <= (others => '0');       -- 011 (don't care)
  mux_data(4) <= a OR (NOT b);          -- 100
  mux_data(5) <= a AND (NOT b);         -- 101
  mux_data(6) <= cr_adder_out;          -- 110 (a - b)
  mux_data(7) <=                        -- 111 (SLT)
    (0 => cr_adder_out(WIDTH - 1), others => '0');  
  -- Note: Simple SLT Operation implemented, as it does not consider overflow

  -- Output
  
  neg <= data_out(WIDTH - 1); -- Extracts sign bit
  result <= data_out;

end architecture;