--------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien            --
--                        IO PROJECT                              --
--------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)       --
--               Gundacker Max (el23b074@technikum-wien.at)       --
--                                                                --
--         Date: 24 Jun 2025                                      --
--                                                                --
--  Design Unit: IO Ctrl Unit (RTL Architecture)                  --
--                                                                --
--     Filename: io_ctrl_rtl.vhd                                  --
--                                                                --
--      Version: 1.2                                              --
--                                                                --
--  Description: The IO ctrl unit implements the control logic for--
--               the IOs of the counter project. It handles the   --
--               synchronization of the switches and buttons,     --
--               controls the LEDs, and manages the 7-segment     --
--               display. It is a part of the counter project.    --
--               This file contains the rtl architecture of the   --
--               IO ctrl unit.                                    --
--------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	--contains + operator
use work.counter_constants_pkg.all;

architecture rtl of io_ctrl is
	signal s_1khzclk : std_logic;									-- scaled 1kHz clock signal
    signal s_clkcount : integer := 0;								-- counter for scaling clock signal

    signal s_ss : std_logic_vector(0 to 7) := (others => '1'); -- 7-segment display output
    signal s_ss_sel : std_logic_vector(0 to 3) := (others => '1'); -- 7-segment select output
    signal swsync : std_logic_vector(0 to 15) := (others => '0');	-- switch synchronization signals
    signal pbsync : std_logic_vector(0 to 3) := (others => '0');	-- button synchronization signals
    type debounce_array_t is array (natural range <>) of std_logic_vector(2 downto 0);  -- 3-bit shift register for debouncing
    signal switch_sr  : debounce_array_t(15 downto 0) := (others => (others => '0'));   
    signal button_sr  : debounce_array_t(3 downto 0)  := (others => (others => '0'));
    signal v_digit : integer range 0 to 3 := 0;

        -- Convert binary to 7-segment display encoding -----
    -- This function converts a 3-bit binary input to a 7-segment display encoding.
    -- The output is a 7-bit std_logic_vector where each bit corresponds to a segment.
    -- The segments are ordered as follows: a, b, c, d, e, f, g (dp is not used here).
    function dec2seg(input : std_logic_vector(3 downto 0)) return std_logic_vector is
            variable seg : std_logic_vector(6 downto 0);
        begin
            case input is
                when "0000" => seg := "1000000"; -- 0
                when "0001" => seg := "1111001"; -- 1
                when "0010" => seg := "0100100"; -- 2
                when "0011" => seg := "0110000"; -- 3
                when "0100" => seg := "0011001"; -- 4
                when "0101" => seg := "0010010"; -- 5
                when "0110" => seg := "0000010"; -- 6
                when "0111" => seg := "1111000"; -- 7
                when "1000" => seg := "0000000"; -- 8
                when "1001" => seg := "0010000"; -- 9
                when others => seg := "1111111";
            end case;
            return seg;
        end function;
begin	--rtl

----- SCALE CLOCK TO 1kHz -----
	p_slowclk : process (clk_i, reset_i)
	begin
		if reset_i = '1' then
			s_1khzclk <= '0';
			s_clkcount <= 0;
		elsif (clk_i'event and clk_i = '1') then
			if s_clkcount = (((c_clk/1000)/2)-1) then				-- scale based on configured external clock -> 1000 = Desired clock speed
				s_clkcount <= 0;
				s_1khzclk <= not s_1khzclk;
			else
				s_clkcount <= s_clkcount + 1;
			end if;
		else
		end if;
	end process p_slowclk;

----- SW & pb debouncing -----
    p_debounce : process(s_1khzclk, reset_i)
        begin
            if reset_i = '1' then   
                swsync <= (others => '0');
                pbsync <= (others => '0');
                switch_sr <= (others => (others => '0'));
                button_sr <= (others => (others => '0')); 
            elsif (s_1khzclk'event and s_1khzclk = '1') then
                for i in SW_i'range loop
                    switch_sr(i) <= switch_sr(i)(1 downto 0) & SW_i(i);
                    if switch_sr(i) = "111" then
                        swsync(i) <= '1';
                    elsif switch_sr(i) = "000" then
                        swsync(i) <= '0';
                    end if;
                end loop;
                
                -- Buttons: 0=BTNL, 1=BTNR, 2=BTNU, 3=BTND
                button_sr(0) <= button_sr(0)(1 downto 0) & BTNL_i;
                button_sr(1) <= button_sr(1)(1 downto 0) & BTNR_i;
                button_sr(2) <= button_sr(2)(1 downto 0) & BTNU_i;
                button_sr(3) <= button_sr(3)(1 downto 0) & BTND_i;
                for j in 0 to 3 loop
                    if button_sr(j) = "111" then
                        pbsync(j) <= '1';
                    elsif button_sr(j) = "000" then
                        pbsync(j) <= '0';
                    end if;
                end loop;
            end if;
        swsync_o <= swsync;  -- Output the debounced switch states
        pbsync_o <= pbsync;  -- Output the debounced button states
    end process p_debounce;

----- 7-Segment Display Control -----

    p_display_ctrl : process(s_1khzclk, reset_i)
    begin
        if reset_i = '1' then
            s_ss <= (others => '1');
            s_ss_sel <= (others => '1');
            v_digit <= 0;
        elsif (s_1khzclk'event and s_1khzclk = '1') then
            case v_digit is
                when 0 =>
                    s_ss(0 to 6) <= dec2seg(cntr0_i);
                    s_ss(7) <= '1'; -- Dp off
                    s_ss_sel <= "1110";
                when 1 =>
                    s_ss(0 to 6) <= dec2seg(cntr1_i);
                    s_ss(7) <= '1';
                    s_ss_sel <= "1101";
                when 2 =>
                    s_ss(0 to 6) <= dec2seg(cntr2_i);
                    s_ss(7) <= '1';
                    s_ss_sel <= "1011";
                when 3 =>
                    s_ss(0 to 6) <= dec2seg(cntr3_i);
                    s_ss(7) <= '1';
                    s_ss_sel <= "0111";
                when others =>
                    s_ss <= (others => '1');  -- Default case, turn off all segments
                    s_ss_sel <= (others => '1'); 
            end case;
        v_digit <= (v_digit + 1) mod 4;
        end if;
        ss_o <= s_ss;
        ss_sel_o <= s_ss_sel;
    end process p_display_ctrl;

    ----- LED Control -----
    p_led_ctrl : process(s_1khzclk, reset_i)
    begin
        if reset_i = '1' then
            LED_o <= (others => '0');
        elsif (s_1khzclk'event and s_1khzclk = '1') then
            LED_o <= LED_i;
        end if;
    end process p_led_ctrl;

end rtl;
