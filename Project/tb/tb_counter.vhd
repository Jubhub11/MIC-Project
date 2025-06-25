-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: Counter Unit (Testbench)                        --
--                                                               --
--     Filename: tb_counter.vhd                                  --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The counter unit implements a 4 digit octal     --
--               counter running at a frequency of 100Hz.        --
--               It is a part of the counter project. This file  --
--               contains the testbench for the counter unit.    --
-------------------------------------------------------------------

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
          cntr0_o		: out std_logic_vector (0 to 3);	-- Digit 0
          cntr1_o		: out std_logic_vector (0 to 3);	-- Digit 1
          cntr2_o		: out std_logic_vector (0 to 3);	-- Digit 2
          cntr3_o		: out std_logic_vector (0 to 3)); 	-- Digit 3
  end component;
  
  ----- Declare the signals used stimulating the design's inputs/outputs -----
  signal clk_i			: std_logic;
  signal reset_i		: std_logic;
  signal cntrhold_i		: std_logic;
  signal cntrclear_i	: std_logic;
  signal cntrup_i		: std_logic;
  signal cntrdown_i		: std_logic;
  signal cntr0_o		: std_logic_vector (0 to 3);
  signal cntr1_o		: std_logic_vector (0 to 3);
  signal cntr2_o		: std_logic_vector (0 to 3);
  signal cntr3_o		: std_logic_vector (0 to 3);
  
  constant c_Tclk : time := 1 ms; -- external clock period for simulation


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

  ----- clock signal generator -----
  p_clk : process
  begin
	clk_i <= '0';
	wait for (c_Tclk/2);
	clk_i <= '1';
	wait for (c_Tclk/2);
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
	-- counting up
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '1';
    cntrdown_i <= '0';
    wait for 1 sec;
	-- counting down
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '0';
    cntrup_i <= '0';
    cntrdown_i <= '1';
    wait for 2 sec;
	-- hold counter
    reset_i <= '0';
    cntrhold_i <= '1';
    cntrclear_i <= '0';
    cntrup_i <= '0';
    cntrdown_i <= '0';
    wait for 1 sec;
	-- clear counter
    reset_i <= '0';
    cntrhold_i <= '0';
    cntrclear_i <= '1';
    cntrup_i <= '0';
    cntrdown_i <= '0';
    wait for 1 sec;
	-- reset
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
