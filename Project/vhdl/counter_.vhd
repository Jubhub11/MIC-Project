library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
  port (clk_i		: in  std_logic;					-- system clock 100MHz
        reset_i		: in  std_logic;					-- reset
        cntrhold_i	: in  std_logic;					-- when 1 -> counter holds value
        cntrclear_i	: in  std_logic;					-- when 1 -> counter set to 0000
        cntrup_i	: in  std_logic;					-- when 1 -> counts up
        cntrdown_i	: in  std_logic;					-- when 1 -> counts down
        cntr0_o		: out std_logic_vector (0 to 2);	-- Digit 0
        cntr1_o		: out std_logic_vector (0 to 2);	-- Digit 1
        cntr2_o		: out std_logic_vector (0 to 2);	-- Digit 2
        cntr3_o		: out std_logic_vector (0 to 2));	-- Digit 3
end counter;