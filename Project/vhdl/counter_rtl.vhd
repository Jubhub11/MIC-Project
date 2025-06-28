-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: Counter Unit (RTL Architecture)                 --
--                                                               --
--     Filename: counter_rtl.vhd                                 --
--                                                               --
--      Version: 1.2                                             --
--                                                               --
--  Description: The counter unit implements a 4 digit decimal   --
--               counter running at a frequency of 10Hz.         --
--               It is a part of the counter project. This file  --
--               contains the rtl architecture of the counter.   --
-------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	--contains + operator
use work.counter_constants_pkg.all;

architecture rtl of counter is
	type std_logic_vector_array is array (natural range <>) of std_logic_vector(3 downto 0);	-- type declaration for counter array
	signal s_cntr : std_logic_vector_array(0 to 3) := (others => (others => '0'));				-- all counters combined into array
	signal s_10hzclk : std_logic;																-- scaled 10hz clock signal
	signal s_clkcount : integer := 0;															-- counter for scaling clock signal
begin	--rtl

----- SCALE CLOCK TO 10Hz -----
	p_slowclk : process (clk_i, reset_i)
	begin
		if reset_i = '1' then
			s_10hzclk <= '0';
			s_clkcount <= 0;
		elsif (clk_i'event and clk_i = '1') then
			if s_clkcount = (((c_clk/10)/2)-1) then				-- scale based on configured external clock. 10 -> Desired Clock speed
				s_clkcount <= 0;
				s_10hzclk <= not s_10hzclk;
			else
				s_clkcount <= s_clkcount + 1;
			end if;
		else
		end if;
	end process p_slowclk;

----- MAIN COUNTER PROCESS -----
	p_decimalCounter : process(s_10hzclk, reset_i)
	variable v_cntr : std_logic_vector_array(0 to 3);		-- variable to allow logic without delay
	begin
		if reset_i = '1' then
			v_cntr := (others => (others => '0'));
		elsif (s_10hzclk'event and s_10hzclk = '1') then
			
			-- CLEAR
			if cntrclear_i = '1' then
				v_cntr := (others => (others => '0'));
			
			-- COUNT UP
			elsif cntrup_i = '1' then
			v_cntr := s_cntr;	-- variable assigned signal value because value is lost between cycles
			v_cntr(3) := v_cntr(3) + '1';
				for i in 3 downto 1 loop	--digits 1 to 3
					if v_cntr(i) = "1010" then					-- detects when 10 is reached
						v_cntr(i-1) := v_cntr(i-1) + '1';		-- carry added to next digit
						v_cntr(i) := "0000";					-- current digit set to 0
					else
					end if;
				end loop;	
				if v_cntr(0) = "1010" then		--digit 0
					v_cntr := (others => (others => '0'));
				else
				end if;
			
			-- COUNT DOWN
			elsif cntrdown_i = '1' then
				v_cntr := s_cntr;
				v_cntr(3) := v_cntr(3) - '1';
				for i in 3 downto 1 loop	--digits 1 to 3
					if v_cntr(i) = "1111" then					-- detects when wrap-around
						v_cntr(i-1) := v_cntr(i-1) - '1';		-- carry subtracted from next digit
						v_cntr(i) := "1001";					-- current digit set to 9
					else
					end if;
				end loop;	
				if v_cntr(0) = "1111" then		--digit 0
					v_cntr := (others => "1001");
				else
				end if;
			
			-- HOLD
			elsif cntrhold_i = '1' then
				v_cntr := s_cntr;
			
			-- DEFAULT
			else
				v_cntr := s_cntr;	-- keep value as fallback
			end if;
		else
		end if;
		
	s_cntr <= v_cntr;	-- assign variable to signal so it is retained after process
	end process p_decimalCounter;
	
cntr0_o <= s_cntr(0);
cntr1_o <= s_cntr(1);
cntr2_o <= s_cntr(2);
cntr3_o <= s_cntr(3);

end rtl;
