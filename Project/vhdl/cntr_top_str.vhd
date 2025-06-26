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
--     Filename: cntr_top_str.vhd                                  --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The cntr_top It integrates the IO
--               controller and the counter unit, providing a
--               complete solution for the counter functionality.
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture Structural  of cntr_top is
	signal s_1khzclk : std_logic;									-- scaled 1kHz clock signal
	signal s_clkcount : integer := 0;								-- counter for scaling clock signal
	signal swsync : std_logic_vector (0 to 15);
	signal cntr0  :  std_logic_vector (0 to 3);
	signal cntr1  :  std_logic_vector (0 to 3);
	signal cntr2  :  std_logic_vector (0 to 3);
	signal cntr3  :  std_logic_vector (0 to 3);
	signal leds_i  :  std_logic_vector (0 to 15);
	signal leds_o  :  std_logic_vector (0 to 15);
	signal sw  :  std_logic_vector (0 to 15);
	signal ss_sel : std_logic_vector (0 to 3);
	signal ss : std_logic_vector (0 to 7);
	signal pbsync : std_logic_vector (0 to 3);
	signal BTNC : std_logic; -- Button for reset
begin


	
----- MAIN COUNTER PROCESS -----
io_ctrl: entity work.io_ctrl 
port map (
	clk_i      => clk_i,
    reset_i    => BTNC,
    BTNL_i     => '0',  -- Not used in this design
	BTNR_i     => '0',  -- Not used in this design
	BTNU_i     => '0',  -- Not used in this design
	BTND_i     => '0',  -- Not used in this design
	SW_i       => sw_i,	--statt sw
	LED_o      => LED_o, --statt leds_o
	ss_sel_o   => ss_sel_o,
    ss_o       => ss_o,
    pbsync_o   => pbsync_o,--statt pbsync
    swsync_o   => swsync,
    LED_i	   => leds_i,
	cntr0_i    => cntr0,
    cntr1_i    => cntr1,
    cntr2_i    => cntr2,
    cntr3_i    => cntr3 	
);

cntr: entity work.counter 
	port map (
	clk_i		 => clk_i,
    reset_i		 => BTNC,
    cntrhold_i   => swsync(0),
    cntrclear_i  => swsync(1),
    cntrup_i     => swsync(2),
    cntrdown_i   => swsync(3),
    cntr0_o      => cntr0,
    cntr1_o      => cntr1,
    cntr2_o      => cntr2,
    cntr3_o      => cntr3
);

signal_sync: process(clk_i)
	begin
		if clk_i'event and clk_i = '1' then
		--sw        <= sw_i;
		BTNC      <= reset_i;		---asyncron also noch fixen
		leds_i    <= (others => '0');
		leds_i(0) <= swsync(0); 
		leds_i(1) <= swsync(1); 
		leds_i(2) <= swsync(2); 
		leds_i(3) <= swsync(3); 
		cntr0_o   <= cntr0;
		cntr1_o   <= cntr1;
		cntr2_o   <= cntr2;
		cntr3_o   <= cntr3;
		pbsync_o  <= pbsync;
		swsync_o  <= swsync;
		--LED_o     <= leds_o;
		else
		end if;
end process signal_sync;

-- 7-Segment Display Control

end Structural;
