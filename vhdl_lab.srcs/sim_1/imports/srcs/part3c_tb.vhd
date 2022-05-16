library ieee;              -- Load the ieee 1164 library
use ieee.std_logic_1164.all;  -- Make the package 'visible'

-- The top level entity of the test bench has no ports...
entity part3c_tb is
end part3c_tb;

architecture stimulus of part3c_tb is
  -- First, declare the lower-level entity...
  component part3c
    port  (a, b, c, d, e : in STD_LOGIC;
           g : out STD_LOGIC);
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal a_test, b_test, c_test, d_test, e_test : STD_LOGIC;
  signal g_test : STD_LOGIC;
  
begin
  -- Create an instance of the component under test
  bcdcheck_instance: part3c port map( 
	a => a_test, 
	b => b_test, 
	c => c_test, 
	d => d_test,
	e => e_test, 
	g => g_test);
  
  -- Now define a process to apply some stimulus over time...
  process
    constant PERIOD: time := 40 ns;
  begin
    a_test <= '0'; b_test <= '0'; c_test <= '0'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '1' report "Assertion violation in Input value 00000 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '0'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '1' report "Assertion violation in Input value 00001 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '0'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '1' report "Assertion violation in Input value 00010 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '0'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '1' report "Assertion violation in Input value 00011 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '1'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 00100 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '1'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 00101 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '1'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 00110 failed";

    a_test <= '0'; b_test <= '0'; c_test <= '1'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 00111 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '0'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01000 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '0'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01001 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '0'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01010 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '0'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01011 failed";
    
    a_test <= '1'; b_test <= '0'; c_test <= '0'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10000 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '0'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10001 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '0'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10010 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '0'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10011 failed";
    
    a_test <= '0'; b_test <= '1'; c_test <= '1'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01100 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '1'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01101 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '1'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01110 failed";

    a_test <= '0'; b_test <= '1'; c_test <= '1'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 01111 failed";
    
    a_test <= '1'; b_test <= '0'; c_test <= '1'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10100 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '1'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10101 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '1'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10110 failed";

    a_test <= '1'; b_test <= '0'; c_test <= '1'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 10111 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '0'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11000 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '0'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11001 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '0'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11010 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '0'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11011 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '1'; d_test <= '0'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11100 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '1'; d_test <= '0'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11101 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '1'; d_test <= '1'; e_test <= '0'; 
    wait for PERIOD;
    assert g_test = '0' report "Assertion violation in Input value 11110 failed";

    a_test <= '1'; b_test <= '1'; c_test <= '1'; d_test <= '1'; e_test <= '1'; 
    wait for PERIOD;
    assert g_test = '1' report "Assertion violation in Input value 11111 failed";

    -- put breakpoint to line below
    wait for PERIOD;
    
    wait;    
  end process;  
end stimulus;