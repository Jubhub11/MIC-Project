-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: cntr_top (Testbench)                             --
--                                                               --
--     Filename: tb_cntr_top.vhd                                  --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The tb_cntr_top entity is the testbench for the
--               cntr_top unit. It simulates the behavior of the
--               counter top-level design, providing inputs and
--               checking the outputs to ensure correct functionality.
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_cntr_top is
end tb_cntr_top;

architecture sim of tb_cntr_top is
  component cntr_top
    generic (c_clk : natural := 50000);  -- 50000 for 1kHz clock in simulation
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
     end component;
  ----- Declare the signals used stimulating the design's inputs/outputs -----
    signal clk_i       : std_logic;                  -- system clock 100MHz
    signal reset_i     : std_logic;                  -- reset --BTNC
    signal cntrhold_i  : std_logic;                  -- when '1' -> counter holds value
    signal cntrclear_i : std_logic;                  -- when '1' -> counter set to 0000
    signal cntrup_i    : std_logic;                  -- when '1' -> counts up
    signal cntrdown_i  : std_logic;                  -- when '1' -> counts down
    signal cntr0_o     : std_logic_vector (0 to 3);  -- Digit 0
    signal cntr1_o     : std_logic_vector (0 to 3);  -- Digit 1
    signal cntr2_o     : std_logic_vector (0 to 3);  -- Digit 2
    signal cntr3_o     : std_logic_vector (0 to 3);   -- Digit 3
    signal pbsync_o    : std_logic_vector (0 to 3);   -- Button synchronization output
    signal swsync_o    : std_logic_vector (0 to 15); -- Switch synchronization output
    signal LED_o       : std_logic_vector (0 to 15); -- LEDs output
    signal ss_sel_o    : std_logic_vector (0 to 3);  -- 7-Segment Selects output
    signal ss_o        : std_logic_vector (0 to 7);   -- 7-Segment LEDs output
    signal sw_i        : std_logic_vector(0 to 15);  -- Switches (16)
    constant c_Tclk : time := 1 us; -- external clock period for simulation
begin

  ----- Instantiate the counter design for testing -----
  i_cntrl_top : cntr_top
    port map (
      clk_i        => clk_i,
      reset_i      => reset_i,
      cntrhold_i   => cntrhold_i,
      cntrclear_i  => cntrclear_i,
      cntrup_i     => cntrup_i,
      cntrdown_i   => cntrdown_i,
      cntr0_o      => cntr0_o,
      cntr1_o      => cntr1_o,
      cntr2_o      => cntr2_o,
      cntr3_o      => cntr3_o,
      pbsync_o     => pbsync_o,
      swsync_o     => swsync_o,
      LED_o        => LED_o,
      ss_sel_o     => ss_sel_o,
      ss_o         => ss_o,
      sw_i         => sw_i
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
    -- Initialize signals
    reset_i <= '1';
    sw_i <= (others => '0');  -- Initialize switches to '0'
    
    -- Wait for a clock cycle
    wait for 100 ms;
    
    -- Release reset
    reset_i <= '0';
    
    -- Test only switch 1 -> expecting hold
    sw_i(1) <= '1';  	-- Switch for counting up
    wait for 100 ms;  	
	
	-- Test only switch 2 -> expecting hold
    sw_i(2) <= '1';  	-- Switch for counting down
    wait for 100 ms;  	
    
    -- Test counting down 
    sw_i(0) <= '1';  	-- Enable counter
    sw_i(1) <= '0';  	-- Disable switch for counting up
	sw_i(2) <= '1';  	-- Enable switch for counting down
    wait for 100 ms;  	-- Allow time for counting
    
    -- Test counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    sw_i(1) <= '1';  	-- Enable switch for counting up
    wait for 100 ms;  	-- Counter should go up
	sw_i(2) <= '1';		-- Enable switch for counting down, should be overwritten
	wait for 100 ms;	-- Counter should go up
    
	-- Test other variations -> expecting hold
	sw_i(1) <= '0';  	-- Disable switch for counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    wait for 100 ms;  	-- Counter should hold
	sw_i(0) <= '0';  	-- Disable counter
	sw_i(1) <= '0';  	-- Disable switch for counting up
	sw_i(2) <= '1';  	-- Enable switch for counting down
    wait for 100 ms;  	-- Counter should hold
	sw_i(0) <= '0';  	-- Disable counter
	sw_i(1) <= '1';  	-- Enable switch for counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    wait for 100 ms;  	-- Counter should hold
	
    -- Test clear
    sw_i(3) <= '1';  	-- Enable switch for clearing counter
    wait for 200 ms;  	-- Allow time for clearing
    sw_i(3) <= '0';  	-- Release clear switch
    
    -- End simulation
    wait;
  end process;

end sim;
