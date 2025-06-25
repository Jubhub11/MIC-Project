--------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien            --
--                        IO PROJECT                         --
--------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)       --
--               Gundacker Max (el23b074@technikum-wien.at)       --
--                                                                --
--         Date: 24 Jun 2025                                      --
--                                                                --
--  Design Unit: IO ctrl Unit (Entity)                            --
--                                                                --
--     Filename: io_ctrl_.vhd                                     --
--                                                                --
--      Version: 1.0                                              --
--                                                                --
--  Description: The IO ctrl unit implements the control logic for--
--               the IOs of the counter project. It handles the   --
--               synchronization of the switches and buttons,     --
--               controls the LEDs, and manages the 7-segment     --
--               display. It is a part of the counter project.    --
--               This file contains the entity declaration of the --
--               IO ctrl unit.                                    --
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity io_ctrl is 
 generic (c_clk : natural := 50000);	--50000 1khz			-- constant to easily adjust external clock. Useful for simulation
  port (
    	--general inputs
        clk_i  : in   std_logic;    --system clock 100MHz
        reset_i  : in   std_logic;   --global asyncronreset BTNC
        --BUTTONS
        BTNL_i  : in   std_logic;
        BTNR_i  : in   std_logic;
        BTNU_i  : in   std_logic;
        BTND_i  : in   std_logic;
        --SWITCHES
        SW_i   : in   std_logic_vector (0 to 15); --16 switches
        --synchronization signal for switches
        swsync_o : out   std_logic_vector (0 to 15); --16 switches
        --LEDs state
        LED_i   : in  std_logic_vector (0 to 15); --16 LEDs
        --LEDS outputs
        LED_o   : out  std_logic_vector (0 to 15); --16 LEDs
        --7-Segment Selects --inverted logic
        ss_sel_o   : out   std_logic_vector (0 to 3); --4 digits
        --7-Segment LEDs --inverted logic
        ss_o  : out   std_logic_vector (0 to 7); --7 segments + dt
        --synchronization signal for Buttons
        pbsync_o : out   std_logic_vector (0 to 3); --4 buttons
        --control signals
        cntr0_i : in std_logic_vector (0 to 2); -- Digit 1
        cntr1_i : in std_logic_vector (0 to 2); -- Digit 2
        cntr2_i : in std_logic_vector (0 to 2); -- Digit 3
        cntr3_i : in std_logic_vector (0 to 2) -- Digit 4
  );
end io_ctrl;
