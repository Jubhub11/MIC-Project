-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: Counter Unit (Entity)                           --
--                                                               --
--     Filename: counter_.vhd                                    --
--                                                               --
--      Version: 1.0                                             --
--                                                               --
--  Description: The counter unit implements a 4 digit octal     --
--               counter running at a frequency of 100Hz.        --
--               It is a part of the counter project. This file  --
--               contains the entity declaration of the counter. --
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
  generic (c_clk : natural := 1000);				-- constant to easily adjust external clock. Useful for simulation
  port (clk_i		   : in  std_logic;					-- system clock 100MHz
        reset_i		 : in  std_logic;					-- reset
        cntrhold_i	: in  std_logic;					-- when 1 -> counter holds value
        cntrclear_i	: in  std_logic;					-- when 1 -> counter set to 0000
        cntrup_i	: in  std_logic;					-- when 1 -> counts up
        cntrdown_i	: in  std_logic;					-- when 1 -> counts down
        cntr0_o		: out std_logic_vector (0 to 3);	-- Digit 0
        cntr1_o		: out std_logic_vector (0 to 3);	-- Digit 1
        cntr2_o		: out std_logic_vector (0 to 3);	-- Digit 2
        cntr3_o		: out std_logic_vector (0 to 3));	-- Digit 3
end counter;