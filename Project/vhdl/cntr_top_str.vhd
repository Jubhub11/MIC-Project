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
--  Description:    --
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture Structural  of cntr_top is
	signal s_1khzclk : std_logic;									-- scaled 1kHz clock signal
	signal s_clkcount : integer := 0;								-- counter for scaling clock signal
	signal swsync : std_logic_vector (0 to 15);
	signal cntr0  :  std_logic_vector (0 to 2);
	signal cntr1  :  std_logic_vector (0 to 2);
	signal cntr2  :  std_logic_vector (0 to 2);
	signal cntr3  :  std_logic_vector (0 to 2);
	signal leds  :  std_logic_vector (0 to 15);
begin

----- MAIN COUNTER PROCESS -----
io_ctrl: entity work.io_ctrl 
port map (
	clk_i      => clk_i,
    reset_i    => reset_i,
    BTNL_i     => '0',  -- Button Left
    BTNR_i     => '0',  -- Button Right
    BTNU_i     => '0',  -- Button Up
    BTND_i     => '0',  -- Button Down
    SW_i       => (others => '0'),
	LED_o      => open,
	ss_sel_o   => open,
    ss_o       => open,
    pbsync_o   => open,
    swsync_o   => swsync,
    LED_i	   => leds,
	cntr0_i    => cntr0,
    cntr1_i    => cntr1,
    cntr2_i    => cntr2,
    cntr3_i    => cntr3 	
);

cntr: entity work.counter 
	port map (
	clk_i		 => clk_i,
    reset_i		 => reset_i,
    cntrhold_i   => swsync(0),
    cntrclear_i  => swsync(1),
    cntrup_i     => swsync(2),
    cntrdown_i   => swsync(3),
    cntr0_o      => cntr0,
    cntr1_o      => cntr1,
    cntr2_o      => cntr2,
    cntr3_o      => cntr3
);


end Structural;
