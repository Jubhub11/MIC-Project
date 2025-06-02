library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity adder is
  port (a_i   : in  std_logic_vector (7 downto 0);  -- first data bit
        b_i   : in  std_logic_vector (7 downto 0);  -- second data bit
        cy_o  : out std_logic;                      -- carry output
        sum_o : out std_logic_vector (7 downto 0)); -- sum output
end adder;

----------------------------------------------

----------------------------------------------------------
architecture rtl of adder is
begin

p_adder :process (a_i, b_i)
  variable temp_sum : std_logic_vector (8 downto 0);
  begin
    temp_sum := unsigned(a_i) + conv_unsigned(unsigned(b_i), 9);
    cy_o <= temp_sum(8);
    sum_o <= temp_sum(7 downto 0);
  end process;
end rtl;

configuration adder_rtl_cfg of adder is
  for rtl  -- architecture rtl is used for entity halfadder
  end for;
end adder_rtl_cfg;