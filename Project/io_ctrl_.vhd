library IEEE;
use IEEE.std_logic_1164.all;

entity io_ctrl is
  port (--general inputs
        clk_i  : in   std_logic;    --system clock 100MHz
        BTNC_i  : in   std_logic;   --global asyncronreset
        --BUTTONS
        BTNL_i  : in   std_logic;
        BTNR_i  : in   std_logic;
        BTNU_i  : in   std_logic;
        BTND_i  : in   std_logic;
        --SWITCHES
        SW_0_i   : in   std_logic;
        SW_1_i   : in   std_logic;
        SW_2_i   : in   std_logic;
        SW_3_i   : in   std_logic;
        SW_4_i   : in   std_logic;
        SW_5_i   : in   std_logic;
        SW_6_i   : in   std_logic;
        SW_7_i   : in   std_logic;
        SW_8_i   : in   std_logic;
        SW_9_i   : in   std_logic;
        SW_10_i  : in   std_logic;
        SW_11_i  : in   std_logic;
        SW_12_i  : in   std_logic;
        SW_13_i  : in   std_logic;
        SW_14_i  : in   std_logic;
        SW_15_i  : in   std_logic;
        --LEDs state
        LED_0_i   : in  std_logic;
        LED_1_i   : in  std_logic;
        LED_2_i   : in  std_logic;
        LED_3_i   : in  std_logic;
        LED_4_i   : in  std_logic;
        LED_5_i   : in  std_logic;
        LED_6_i   : in  std_logic;
        LED_7_i   : in  std_logic;
        LED_8_i   : in  std_logic;
        LED_9_i   : in  std_logic;
        LED_10_i  : in  std_logic;
        LED_11_i  : in  std_logic;
        LED_12_i  : in  std_logic;
        LED_13_i  : in  std_logic;
        LED_14_i  : in  std_logic;
        LED_15_i  : in  std_logic;
        --LEDS outputs
        LED_0_o   : out  std_logic;
        LED_1_o   : out  std_logic;
        LED_2_o   : out  std_logic;
        LED_3_o   : out  std_logic;
        LED_4_o   : out  std_logic;
        LED_5_o   : out  std_logic;
        LED_6_o   : out  std_logic;
        LED_7_o   : out  std_logic;
        LED_8_o   : out  std_logic;
        LED_9_o   : out  std_logic;
        LED_10_o  : out  std_logic;
        LED_11_o  : out  std_logic;
        LED_12_o  : out  std_logic;
        LED_13_o  : out  std_logic;
        LED_14_o  : out  std_logic;
        LED_15_o  : out  std_logic;
        --7-Segment Selects --inverted logic
        ss_sel_0_o   : out   std_logic;
        ss_sel_1_o   : out   std_logic;
        ss_sel_2_o   : out   std_logic;
        ss_sel_3_o   : out   std_logic;
        --7-Segment LEDs --inverted logic
        CA_o  : out  std_logic;
        CB_o  : out  std_logic;
        CC_o  : out  std_logic;
        CD_o  : out  std_logic;
        CE_o  : out  std_logic;
        CF_o  : out  std_logic;
        CG_o  : out  std_logic;
        DP_o  : out  std_logic;
        --synchronization signal for switches
        swsync_0_o : out   std_logic;  
        swsync_1_o : out   std_logic;
        swsync_2_o : out   std_logic;
        swsync_3_o : out   std_logic;
        swsync_4_o : out   std_logic;
        swsync_5_o : out   std_logic;
        swsync_6_o : out   std_logic;
        swsync_7_o : out   std_logic;
        swsync_8_o : out   std_logic;
        swsync_9_o : out   std_logic;
        swsync_10_o : out   std_logic;
        swsync_11_o : out   std_logic;
        swsync_12_o : out   std_logic;
        swsync_13_o : out   std_logic;
        swsync_14_o : out   std_logic;
        swsync_15_o : out   std_logic;
        --synchronization signal for Buttons
        BTNL_sync_o : out   std_logic;
        BTNR_sync_o : out   std_logic;
        BTNU_sync_o : out   std_logic;
        BTND_sync_o : out   std_logic;
        --control signals
        cntr_0_i : in std_logic_vector (0 to 7); -- Digit 1
        cntr_1_i : in std_logic_vector (0 to 7); -- Digit 2
        cntr_2_i : in std_logic_vector (0 to 7); -- Digit 3
        cntr_3_i : in std_logic_vector (0 to 7)); -- Digit 4
        end io_ctrl;
