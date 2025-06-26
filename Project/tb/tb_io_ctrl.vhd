-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: IO ctrl (Testbench)                             --
--                                                               --
--     Filename: tb_io_ctrl.vhd                                  --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description:                                                  --
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_io_ctrl is
end tb_io_ctrl;

architecture sim of tb_io_ctrl is
  component io_ctrl
    generic (c_clk : natural := 50000);  -- 50000 for 1kHz clock in simulation
    port (
      clk_i        : in   std_logic;  -- system clock
      reset_i      : in   std_logic;  -- global asynchronous reset
      BTNL_i       : in   std_logic;  -- Button Left
      BTNR_i       : in   std_logic;  -- Button Right
      BTNU_i       : in   std_logic;  -- Button Up
      BTND_i       : in   std_logic;  -- Button Down
      SW_i         : in   std_logic_vector(0 to 15);  -- Switches (16)
      swsync_o     : out  std_logic_vector(0 to 15);  -- Switch synchronization output
      LED_i        : in   std_logic_vector(0 to 15);  -- LEDs (16)
      LED_o        : out  std_logic_vector(0 to 15);  -- LEDs output
      ss_sel_o     : out  std_logic_vector(0 to 3);   -- 7-Segment Selects output
      ss_o         : out  std_logic_vector(0 to 7);   -- 7-Segment LEDs output
      pbsync_o    : out  std_logic_vector (0 to 3);                   -- Button synchronization output
      cntr0_i     : in   std_logic_vector(0 to 3);   -- Counter Digit 1 input
      cntr1_i     : in   std_logic_vector(0 to 3);   -- Counter Digit 2 input
      cntr2_i     : in   std_logic_vector(0 to 3);   -- Counter Digit 3 input
      cntr3_i     : in   std_logic_vector(0 to 3)    -- Counter Digit 4 input
    );
     end component;
  ----- Declare the signals used stimulating the design's inputs/outputs -----
  signal clk_i        : std_logic := '0';
  signal reset_i      : std_logic := '1';  -- Reset signal
  constant c_Tclk     : time := 1 ms; -- external clock period for simulation
  -- constant for the clock period, can be adjusted for simulation speed
  signal BTNL_i       : std_logic;  -- Button Left
  signal BTNR_i       : std_logic;  -- Button Right
  signal BTNU_i       : std_logic;  -- Button Up
  signal BTND_i       : std_logic;  -- Button Down
  signal SW_i         : std_logic_vector(0 to 15);  -- Switches (16)
  signal swsync_o     : std_logic_vector(0 to 15);  -- Switch synchronization output
  signal LED_i        : std_logic_vector(0 to 15);  -- LEDs (16)
  signal LED_o        : std_logic_vector(0 to 15);  -- LEDs output
  signal ss_sel_o     : std_logic_vector(0 to 3);  -- 7-Segment Selects output
  signal ss_o         : std_logic_vector(0 to 7);  -- 7-Segment LEDs output
  signal pbsync_o    : std_logic_vector(0 to 3);  -- Button synchronization output
  signal cntr0_i     : std_logic_vector(0 to 3);  -- Counter Digit 1 input
  signal cntr1_i     : std_logic_vector(0 to 3);  -- Counter Digit 2 input
  signal cntr2_i     : std_logic_vector(0 to 3);  -- Counter Digit 3 input
  signal cntr3_i     : std_logic_vector(0 to 3);  -- Counter Digit 4 input
  constant c_clk      : natural := 50000;  -- 50000 for 1kHz clock in simulation
begin

  ----- Instantiate the counter design for testing -----
  i_io_ctrl : io_ctrl
    port map (
      clk_i        => clk_i,
      reset_i      => reset_i,
      BTNL_i       => '0',  -- Button Left
      BTNR_i       => '0',  -- Button Right
      BTNU_i       => '0',  -- Button Up
      BTND_i       => '0',  -- Button Down
      SW_i         => SW_i,  -- Switches (16)
      swsync_o     => swsync_o,  -- Switch synchronization output
      LED_i        => LED_i,  -- LEDs (16)
      LED_o        => LED_o,  -- LEDs output
      ss_sel_o     => ss_sel_o,  -- 7-Segment Selects output
      ss_o         => ss_o,  -- 7-Segment LEDs output
      pbsync_o    => pbsync_o,  -- Button synchronization output
      cntr0_i     => cntr0_i,  -- Counter Digit 1 input
      cntr1_i     => cntr1_i,  -- Counter Digit 2 input
      cntr2_i     => cntr2_i,  -- Counter Digit 3 input
      cntr3_i     => cntr3_i   -- Counter Digit 4 input

    );

  ----- clock signal generator -----
  p_clk : process
  begin
	clk_i <= '0';
	wait for (c_Tclk/2);
	clk_i <= '1';
	wait for (c_Tclk/2);
  end process;
  
  ----- Test scenarios -----
  p_test : process
  begin
    wait for 100 ms;
    reset_i <= '1';
    SW_i <= "0000000000000000";
    BTNL_i <= '0';
    BTNR_i <= '0';
    BTNU_i <= '0';
    BTND_i <= '0';
    LED_i <= "0000000000000000";
    cntr0_i <= "0000";  -- Initialize counter digit 1
    cntr1_i <= "0000";  -- Initialize counter digit 2
    cntr2_i <= "0000";  -- Initialize counter digit 3
    cntr3_i <= "0000";  -- Initialize counter digit 4
    wait for 1 sec;
    -- Release reset
    reset_i <= '0';
    SW_i <= "0000000000000001";  -- Activate switch 0
    cntr0_i <= "0001";
        LED_i <= "0000011110000000";
    wait for 1 sec;

    SW_i <= "0000000000000010";  -- Activate switch 1
    cntr0_i <= "0010";
    wait for 1 sec;

    -- Test button synchronization
    BTNL_i <= '1';  -- Press Button Left
    wait for 1 sec;

    BTNL_i <= '0';  -- Release Button Left
    wait for 1 sec;

    wait for 1 sec;

  end process;

end sim;
