library ieee;              -- Load the ieee 1164 library
use ieee.std_logic_1164.all;  -- Make the package 'visible'
 
 
-- The top level entity of the test bench has no ports...
entity bcdcheck2_tb is
end bcdcheck2_tb;
 
architecture stimulus of bcdcheck2_tb is
  -- First, declare the lower-level entity...
  component bcdcheck2
    port(x : in std_logic_vector(3 downto 0);
         max, min, even, lo3, noBCD : out STD_LOGIC);
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal x : std_logic_vector(3 downto 0);
  signal max, min, even, lo3, noBCD : STD_LOGIC;
 
begin
  -- Create an instance of the component under test
  bcdcheck2_instance: bcdcheck2 port map( x => x, max => max, min=>min, even=>even, lo3=>lo3, noBCD => noBCD);
 
  -- Now define a process to apply some stimulus over time...
  process
    constant PERIOD: time := 40 ns;
  begin
    x <= "0000";
    wait for PERIOD;
    assert max = '0' and min = '1' and even = '1' and lo3 = '1' and noBCD = '0' report "Error: Input value 0000" severity error;

    x <= "0001";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '1' and noBCD = '0' report "Error: Input value 0001" severity error;

    x <= "0010";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '1' and noBCD = '0' report "Error: Input value 0010" severity error;

    x <= "0011";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '0' report "Error: Input value 0011" severity error;

    x <= "0100";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '0' report "Error: Input value 0100" severity error;

    x <= "0101";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '0' report "Error: Input value 0101" severity error;

    x <= "0110";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '0' report "Error: Input value 0110" severity error;

    x <= "0111";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '0' report "Error: Input value 0111" severity error;

    x <= "1000";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '0' report "Error: Input value 1000" severity error;
    
    x <= "1001";
    wait for PERIOD;
    assert max = '1' and min = '0' and even = '0' and lo3 = '0' and noBCD = '0' report "Error: Input value 1001" severity error;

    x <= "1010";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '1' report "Error: Input value 1010" severity error;

    x <= "1011";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '1' report "Error: Input value 1011" severity error;

    x <= "1100";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '1' report "Error: Input value 1100" severity error;

    x <= "1101";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '1' report "Error: Input value 1101" severity error;

    x <= "1110";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '1' and lo3 = '0' and noBCD = '1' report "Error: Input value 1110" severity error;

    x <= "1111";
    wait for PERIOD;
    assert max = '0' and min = '0' and even = '0' and lo3 = '0' and noBCD = '1' report "Error: Input value 1111" severity error;

    -- put breakpoint to line below
    wait for PERIOD; 
    
    -- don't remove this, as it will break CI
    wait;
          
  end process;
end stimulus;