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
--     Filename: cntr_top_.vhd                                  --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The cntr_top entity is the top-level design unit
--               for the counter project. It integrates the IO
--               controller and the counter unit, providing a
--               complete solution for the counter functionality.
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity cntr_top is
  generic (c_clk : natural := 1000); --1.000.000/1.000 = 1kHz clock
  port (
    clk_i        : in  std_logic;                  -- system clock 100MHz
    reset_i      : in  std_logic;                  -- reset
    cntrhold_i   : in  std_logic;                  -- when '1' -> counter holds value
    cntrclear_i  : in  std_logic;                  -- when '1' -> counter set to 0000
    cntrup_i     : in  std_logic;                  -- when '1' -> counts up
    cntrdown_i   : in  std_logic;                  -- when '1' -> counts down
    cntr0_o      : out std_logic_vector (0 to 3);  -- Digit 0
    cntr1_o      : out std_logic_vector (0 to 3);  -- Digit 1
    cntr2_o      : out std_logic_vector (0 to 3);  -- Digit 2
    cntr3_o      : out std_logic_vector (0 to 3);   -- Digit 3
    pbsync_o    : out std_logic_vector (0 to 3);   -- Button synchronization output
    swsync_o    : out std_logic_vector (0 to 15); -- Switch synchronization output
    LED_o       : out std_logic_vector (0 to 15); -- LEDs output
    ss_sel_o    : out std_logic_vector (0 to 3);  -- 7-Segment Selects output
    ss_o        : out std_logic_vector (0 to 7);   -- 7-Segment LEDs output
    sw_i         : in   std_logic_vector(0 to 15)  -- Switches (16)  
  );
end cntr_top;
