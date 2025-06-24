library IEEE;
use IEEE.std_logic_1164.all;

entity tb_counter is
end tb_counter;

architecture sim of tb_counter is

  component counter
    port (clk_i			: in  std_logic;					-- system clock 100MHz
          reset_i		: in  std_logic;					-- reset
          cntrhold_i	: in  std_logic;					-- when 1 -> counter holds value
          cntrclear_i	: in  std_logic;					-- when 1 -> counter set to 0000
          cntrup_i		: in  std_logic;					-- when 1 -> counts up
          cntrdown_i	: in  std_logic;					-- when 1 -> counts down
          cntr0_o		: out std_logic_vector (0 to 2);	-- Digit 0
          cntr1_o		: out std_logic_vector (0 to 2);	-- Digit 1
          cntr2_o		: out std_logic_vector (0 to 2);	-- Digit 2
          cntr3_o		: out std_logic_vector (0 to 2)); 	-- Digit 3
  end component;
  
  ----- Declare the signals used stimulating the design's inputs/outputs -----
  signal clk_i			: std_logic;
  signal reset_i		: std_logic;
  signal cntrhold_i		: std_logic;
  signal cntrclear_i	: std_logic;
  signal cntrup_i		: std_logic;
  signal cntrdown_i		: std_logic;
  signal cntr0_o		: std_logic_vector (0 to 2);
  signal cntr1_o		: std_logic_vector (0 to 2);
  signal cntr2_o		: std_logic_vector (0 to 2);
  signal cntr3_o		: std_logic_vector (0 to 2);

begin

  ----- Instantiate the counter design for testing -----
  i_counter : counter
    port map (clk_i			=> clk_i,
              reset_i		=> reset_i,
              cntrhold_i	=> cntrhold_i,
              cntrclear_i	=> cntrclear_i,
              cntrup_i		=> cntrup_i,
              cntrdown_i	=> cntrdown_i,
              cntr0_o		=> cntr0_o,
              cntr1_o		=> cntr1_o,
              cntr2_o		=> cntr2_o,
              cntr3_o		=> cntr3_o);

  ----- 100MHz clock signal generator -----
  p_clk : process
  begin
	clk_i <= '0';
	wait for 5 ns;
	clk_i <= '1';
	wait for 5 ns;
  end process p_clk;
  
  ----- Test scenarios -----
  p_test : process
  begin
    -- ZERO
    reset_i <= '1';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '0';
    cntrdown_i <= '0';
    wait for 1 sec;
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '1';
    cntrdown_i <= '0';
    wait for 1 sec;
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '0';
    cntrdown_i <= '1';
    wait for 2 sec;
    reset_i <= '0';
    cntrhold_i <= '1';
    cntrclear_i <= '0';
    cntrup_i <= '0';
    cntrdown_i <= '0';
    wait for 1 sec;
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '1';
    cntrup_i <= '0';
    cntrdown_i <= '0';
    wait for 1 sec;
    reset_i <= '1';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '1';
    cntrdown_i <= '0';
	wait for 1 sec;

  end process;

end sim;

configuration tb_counter_sim of tb_counter is
  for sim
    for i_counter : counter
      use configuration work.counter_rtl_cfg;
    end for;
  end for;
end tb_counter_sim;
