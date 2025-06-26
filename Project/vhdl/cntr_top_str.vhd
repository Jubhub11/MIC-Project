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

	component io_ctrl is
		generic (c_clk : natural := 1000);	--1.000.000/1.000 = 1kHz clock
		port (
			clk_i      : in   std_logic;    --system clock 100MHz
			reset_i    : in   std_logic;   --global asyncronreset BTNC
			BTNL_i     : in   std_logic;   -- Not used in this design
			BTNR_i     : in   std_logic;   -- Not used in this design
			BTNU_i     : in   std_logic;   -- Not used in this design
			BTND_i     : in   std_logic;   -- Not used in this design
			SW_i       : in   std_logic_vector (0 to 15); --16 switches
			LED_o      : out  std_logic_vector (0 to 15); --16 LEDs
			ss_sel_o   : out  std_logic_vector (0 to 3); --4 digits
			ss_o       : out  std_logic_vector (0 to 7); --7 segments + dt
			pbsync_o   : out  std_logic_vector (0 to 3); --4 buttons
			swsync_o   : out  std_logic_vector (0 to 15); --16 switches
			LED_i      : in   std_logic_vector (0 to 15); --16 LEDs
			cntr0_i    : in   std_logic_vector (0 to 3); -- Digit 1
			cntr1_i    : in   std_logic_vector (0 to 3); -- Digit 2
			cntr2_i    : in   std_logic_vector (0 to 3); -- Digit 3
			cntr3_i    : in   std_logic_vector (0 to 3)  -- Digit 4
		);
	end component;

	component counter is
		generic (c_clk : natural := 1000);
		port (
			clk_i		 : in  std_logic;					-- system clock 100MHz
			reset_i		 : in  std_logic;					-- reset
			cntrhold_i   : in  std_logic;					-- when '1' -> counter holds value
			cntrclear_i  : in  std_logic;					-- when '1' -> counter set to 0000
			cntrup_i     : in  std_logic;					-- when '1' -> counts up
			cntrdown_i   : in  std_logic;					-- when '1' -> counts down
			cntr0_o      : out std_logic_vector (0 to 3);	-- Digit 0
			cntr1_o      : out std_logic_vector (0 to 3);	-- Digit 1
			cntr2_o      : out std_logic_vector (0 to 3);	-- Digit 2
			cntr3_o      : out std_logic_vector (0 to 3)    -- Digit 3
		);
	end component;

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
	i_io_ctrl: io_ctrl
	port map (
		clk_i      => clk_i,
	    reset_i    => BTNC,
	    BTNL_i     => '0',  -- Not used in this design
		BTNR_i     => '0',  -- Not used in this design
		BTNU_i     => '0',  -- Not used in this design
		BTND_i     => '0',  -- Not used in this design
		SW_i       => sw_i,	
		LED_o      => LED_o, 
		ss_sel_o   => ss_sel_o,
	    ss_o       => ss_o,
	    pbsync_o   => pbsync_o,
	    swsync_o   => swsync,
	    LED_i	   => leds_i,
		cntr0_i    => cntr0,
	    cntr1_i    => cntr1,
	    cntr2_i    => cntr2,
	    cntr3_i    => cntr3 	
	);
	
	i_counter: counter 
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

	BTNC      <= reset_i;
	leds_i(0) <= swsync(0); 
	leds_i(1) <= swsync(1); 
	leds_i(2) <= swsync(2);  
	leds_i(3) <= swsync(3);
	leds_i(4 to 15)  <= (others =>'0'); 
	cntr0_o   <= cntr0;
	cntr1_o   <= cntr1;
	cntr2_o   <= cntr2;
	cntr3_o   <= cntr3;
	pbsync_o  <= pbsync;
	swsync_o  <= swsync;

	end Structural;
			