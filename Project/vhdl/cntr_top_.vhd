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
--  Description: The cntr_top entity is the top-level design unit--
--               for the counter project. It integrates the IO   --
--               controller and the counter unit, providing a    --
--               complete solution for the counter functionality.--
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.counter_constants_pkg.all;

entity cntr_top is
  port (
    clk_i        : in  std_logic;                  -- system clock 100MHz
    reset_i      : in  std_logic;                  -- reset
    LED_o        : out std_logic_vector (0 to 15); -- LEDs output
    ss_sel_o     : out std_logic_vector (0 to 3);  -- 7-Segment Selects output
    ss_o         : out std_logic_vector (0 to 7);   -- 7-Segment LEDs output
    sw_i         : in   std_logic_vector(0 to 15);  -- Switches (16)  
    pb_i         : in   std_logic_vector(0 to 3)   -- Push Buttons (4)
  );
end cntr_top;
