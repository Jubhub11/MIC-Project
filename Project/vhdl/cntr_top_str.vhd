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
--     Filename: cntr_top_str.vhd                                --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The cntr_top It integrates the IO               --
--               controller and the counter unit, providing a    --
--               complete solution for the counter functionality.--
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.counter_constants_pkg.all;

architecture Structural  of cntr_top is

	component io_ctrl is
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
	signal s_swsync : std_logic_vector (0 to 15);
	signal s_cntr0  :  std_logic_vector (0 to 3);
	signal s_cntr1  :  std_logic_vector (0 to 3);
	signal s_cntr2  :  std_logic_vector (0 to 3);
	signal s_cntr3  :  std_logic_vector (0 to 3);
	signal s_leds_i  :  std_logic_vector (0 to 15);
	signal s_pbsync_o : std_logic_vector (0 to 3);
	signal BTNC : std_logic; -- Button for reset
	signal cntrhold : std_logic; 
	signal cntrclear : std_logic;
	signal cntrup   : std_logic;
	signal cntrdown : std_logic;
begin
	
	----- MAIN COUNTER PROCESS -----
	i_io_ctrl: io_ctrl
	port map (
		clk_i      => clk_i,
	    reset_i    => BTNC,
	    BTNL_i     => pb_i(0),  -- Not used in this design
		BTNR_i     => pb_i(1),  -- Not used in this design
		BTNU_i     => pb_i(2),  -- Not used in this design
		BTND_i     => pb_i(3),  -- Not used in this design
		SW_i       => sw_i,	
		LED_o      => LED_o, 
		ss_sel_o   => ss_sel_o,
	    ss_o       => ss_o,
	    pbsync_o   => s_pbsync_o,
	    swsync_o   => s_swsync,
	    LED_i	   => s_leds_i,
		cntr0_i    => s_cntr0,
	    cntr1_i    => s_cntr1,
	    cntr2_i    => s_cntr2,
	    cntr3_i    => s_cntr3 	
	);
	
	i_counter: counter 
		port map (
		clk_i		 => clk_i,
	    reset_i		 => BTNC,
	    cntrhold_i   => cntrhold,
	    cntrclear_i  => cntrclear,
	    cntrup_i     => cntrup ,
	    cntrdown_i   => cntrdown,
	    cntr0_o      => s_cntr0,
	    cntr1_o      => s_cntr1,
	    cntr2_o      => s_cntr2,
	    cntr3_o      => s_cntr3
	);

	BTNC      <= reset_i;
	s_leds_i(0) <= s_swsync(0); 
	s_leds_i(1) <= s_swsync(1); 
	s_leds_i(2) <= s_swsync(2);  
	s_leds_i(3) <= s_swsync(3);
	s_leds_i(4 to 15)  <= (others =>'0'); 

	--counter switch logic
	sw2cntr : process(clk_i, BTNC)
	begin
		if BTNC = '1' then	-- reset
			cntrclear 	<= '0';
			cntrhold 	<= '0';
			cntrup 		<= '0';
			cntrdown 	<= '0';
		elsif clk_i'event and clk_i = '1' then
			-- default
			cntrclear 	<= '0';
			cntrhold 	<= '0';
			cntrup 		<= '0';
			cntrdown 	<= '0';
			-- clear
			if s_swsync(3) = '1' then
				cntrclear <= '1';
			-- counter on
			elsif s_swsync(0) = '1' then
				-- count up
				if s_swsync(1) = '1' then
					cntrup <= '1';
				-- count down
				elsif s_swsync(2) = '1'then
					cntrdown <= '1';
				else
					cntrhold <= '1';	-- hold is fallback
				end if;
			else
				cntrhold <= '1';	-- hold is fallback
			end if;
		end if;
	end process sw2cntr;
	
end Structural;
