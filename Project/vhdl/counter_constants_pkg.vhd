-------------------------------------------------------------------
--          Microelectronic Design | FH Technikum Wien           --
--                        COUNTER PROJECT                        --
-------------------------------------------------------------------
--       Author: Bauer Julian  (el23b071@technikum-wien.at)      --
--               Gundacker Max (el23b074@technikum-wien.at)      --
--                                                               --
--         Date: 24 Jun 2025                                     --
--                                                               --
--  Design Unit: counter_constants_pkg.vhd (Package)             --
--                                                               --
--     Filename: tb_cntr_top.vhd                                 --
--                                                               --
--      Version: 1.0                                             --
--                                                               --
--  Description: This is a package containing constants used     --
--				 across the counter project.                     --
-------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package counter_constants_pkg is
    --constant c_clk : integer := 50_000;			-- low speed clock for simulation
    constant c_clk : integer := 100_000_000;	-- true speed
	constant c_Tclk : time    := 1 sec / c_clk; -- clock period
end package counter_constants_pkg;
