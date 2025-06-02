library IEEE;
use IEEE.std_logic_1164.all;

entity tb_adder is
end tb_adder;

architecture sim of tb_adder is

  component adder
    port (a_i   : in  std_logic_vector (7 downto 0);  -- first data bit
          b_i   : in  std_logic_vector (7 downto 0);  -- second data bit
          cy_o  : out std_logic;                      -- carry output
          sum_o : out std_logic_vector (7 downto 0)); -- sum output
  end component;
  
  -- Declare the signals used stimulating the design"s inputs.
  signal a_i : std_logic_vector (7 downto 0);
  signal b_i : std_logic_vector (7 downto 0);
  signal sum_o : std_logic_vector (7 downto 0);
  signal cy_o : std_logic;
  
begin

  -- Instantiate the adder design for testing
  i_adder : adder
    port map (a_i   => a_i,
              b_i   => b_i,
              cy_o  => cy_o,
              sum_o => sum_o);

  p_test : process
  begin
    -- ZERO
    a_i <= "00000000";
    b_i <= "00000000";
    wait for 100 ns;
    -- ONE
    a_i <= "00000001";
    b_i <= "00000000";
    wait for 100 ns;
    -- TWO
    a_i <= "00000001";
    b_i <= "00000001";
    wait for 100 ns;
    -- THREE
    a_i <= "00000001";
    b_i <= "00000010";
    wait for 100 ns;
    -- FOUR
    a_i <= "00000001";
    b_i <= "00000011";
    wait for 100 ns;
    -- FIVE
    a_i <= "11111111";
    b_i <= "11111111";
    wait for 100 ns;

  end process;

end sim;

configuration tb_adder_sim of tb_adder is
  for sim
    for i_adder : adder
      use configuration work.adder_rtl_cfg;
    end for;
  end for;
end tb_adder_sim;
