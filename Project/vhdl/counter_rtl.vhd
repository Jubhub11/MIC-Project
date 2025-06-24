------------------------------------
-- Class 3 Example 1: D/JK-FlipFlop
------------------------------------
-- Version: 1.0
-- Author: Max Gundacker
-- Date: 05 May 2025
-- Filename: FlipFlop_rtl.vhd
------------------------------------
-- Description: architecture declaration 
-- of FlipFlop for example 1
------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	--contains + operator

architecture rtl of counter is
	signal s_cntr : std_logic_vector(0 to 11) := "000000000000";	-- combined counter for all digits 4x3=12bit
	signal s_100hzclk : std_logic;									-- scaled 100Hz clock signal
	signal s_clkcount : integer := 0;								-- counter for scaling clock signal
begin	--rtl

----- SCALE CLOCK TO 100Hz -----
	p_slowclk : process (clk_i, reset_i)
	begin
		if reset_i = '1' then
			s_100hzclk <= '0';
			s_clkcount <= 0;
		elsif (clk_i'event and clk_i = '1') then
			if s_clkcount = 499999 then				-- scale is 1/1000000, so toggle every 500000 cycles
				s_clkcount <= 0;
				s_100hzclk <= not s_100hzclk;
			else
				s_clkcount <= s_clkcount + 1;
			end if;
		else
		end if;
	end process p_slowclk;

----- MAIN COUNTER PROCESS -----
	p_OctalCounter : process(s_100hzclk, reset_i)
	begin
		if reset_i = '1' then
			s_cntr <= "000000000000";
		elsif (s_100hzclk'event and s_100hzclk = '1') then
			if cntrclear_i = '1' then
				s_cntr <= "000000000000";
			elsif cntrup_i = '1' then
				s_cntr <= s_cntr + '1';	-- if at max, automatically wraps around to 0
			elsif cntrdown_i = '1' then
				s_cntr <= s_cntr - '1';	-- if at 0, automatically wraps around to max
			elsif cntrhold_i = '1' then
				s_cntr <= s_cntr;
			else
				s_cntr <= s_cntr;	-- hold value as fallback
			end if;
		else
		end if;
	end process p_OctalCounter;
cntr0_o <= s_cntr(0 to 2);
cntr1_o <= s_cntr(3 to 5);
cntr2_o <= s_cntr(6 to 8);
cntr3_o <= s_cntr(9 to 11);

end rtl;
