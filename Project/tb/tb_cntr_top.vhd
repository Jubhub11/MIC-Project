-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: cntr_top (Testbench)                            --
--                                                               --
--     Filename: tb_cntr_top.vhd                                 --
--                                                               --
--      Version: 1.1                                             --
--                                                               --
--  Description: The tb_cntr_top entity is the testbench for the --
--               cntr_top unit. It simulates the behavior of the --
--               counter top-level design, providing inputs and  --
--               checking the outputs to ensure functionality.   --
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.counter_constants_pkg.all;

entity tb_cntr_top is
end tb_cntr_top;

architecture sim of tb_cntr_top is
  component cntr_top
    port (
    clk_i        : in  std_logic;                  -- system clock 100MHz
    reset_i      : in  std_logic;                  -- reset
    LED_o       : out std_logic_vector (0 to 15); -- LEDs output
    ss_sel_o    : out std_logic_vector (0 to 3);  -- 7-Segment Selects output
    ss_o        : out std_logic_vector (0 to 7);   -- 7-Segment LEDs output
    sw_i         : in   std_logic_vector(0 to 15);  -- Switches (16)
    pb_i         : in   std_logic_vector(0 to 3)   -- Push Buttons (4)
    );
     end component;
  ----- Declare the signals used stimulating the design's inputs/outputs -----
    signal clk_i       : std_logic;                  -- system clock 100MHz
    signal reset_i     : std_logic;                  -- reset --BTNC
    signal LED_o       : std_logic_vector (0 to 15); -- LEDs output
    signal ss_sel_o    : std_logic_vector (0 to 3);  -- 7-Segment Selects output
    signal ss_o        : std_logic_vector (0 to 7);   -- 7-Segment LEDs output
    signal sw_i        : std_logic_vector(0 to 15);  -- Switches (16)
    signal pb_i        : std_logic_vector(0 to 3);   -- Push Buttons (4)
begin

  ----- Instantiate the counter design for testing -----
  i_cntrl_top : cntr_top
    port map (
      clk_i        => clk_i,
      reset_i      => reset_i,
      LED_o        => LED_o,
      ss_sel_o     => ss_sel_o,
      ss_o         => ss_o,
      sw_i         => sw_i,
      pb_i         => pb_i
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
    wait for 1000 ms;  	-- Allow time for counting
    
    -- Test counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    sw_i(1) <= '1';  	-- Enable switch for counting up
    wait for 1000 ms;  	-- Counter should go up
	sw_i(2) <= '1';		-- Enable switch for counting down, should be overwritten
	wait for 2000 ms;	-- Counter should go up
    
	-- Test other variations -> expecting hold
	sw_i(1) <= '0';  	-- Disable switch for counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    wait for 200 ms;  	-- Counter should hold
	sw_i(0) <= '0';  	-- Disable counter
	sw_i(1) <= '0';  	-- Disable switch for counting up
	sw_i(2) <= '1';  	-- Enable switch for counting down
    wait for 200 ms;  	-- Counter should hold
	sw_i(0) <= '0';  	-- Disable counter
	sw_i(1) <= '1';  	-- Enable switch for counting up
	sw_i(2) <= '0';  	-- Disable switch for counting down
    wait for 200 ms;  	-- Counter should hold
	
    -- Test clear
    sw_i(3) <= '1';  	-- Enable switch for clearing counter
    wait for 100 ms;  	-- Allow time for clearing
    sw_i(3) <= '0';  	-- Release clear switch
    
    -- End simulation
    wait;
  end process;

end sim;
