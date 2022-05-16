LIBRARY ieee;
use ieee.std_logic_1164.all;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 

-- First, declare the lower-level entity (Component).
component FULL_ADDER is
    port(
        A, B, Cin : in std_logic;
        R, Cout : out std_logic
    );
end component;

component ADDER is
    port(
        A, B : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        R : out std_logic_vector(3 downto 0);
        V, C : out std_logic
    );
end component;

component ARITH is
    port(
        A, B : in std_logic_vector(3 downto 0);
        Sub : in std_logic;
        R : out std_logic_vector(3 downto 0);
        V, C : out std_logic
    );
end component;

component LOGIC is 
    port(
        A, B: in std_logic_vector(3 downto 0);
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(3 downto 0)
    );
end component;

-- Declare local signals to assign values to
-- Signals used for the full adder
signal FA_A, FA_B, FA_Cin : std_logic;
signal FA_R, FA_Cout : std_logic;

-- Signals used for the adder
signal Ad_A, Ad_B, Ad_R : std_logic_vector(3 downto 0);
signal Ad_Cin, Ad_V, Ad_Cout : std_logic;

-- Signals used for the arith
signal Ar_A, Ar_B, Ar_R : std_logic_vector(3 downto 0);
signal Ar_Sub, Ar_V, Ar_Cout : std_logic;

-- Signals used for the logic unit
signal L_A, L_B, L_R : std_logic_vector(3 downto 0);
signal L_Op : std_logic_vector(1 downto 0);
   
begin
-- Create an instance of the component under test (Port map).
-- Full adder port map
FA_instance: FULL_ADDER port map(
    A => FA_A,
    B => FA_B,
    Cin => FA_Cin,
    R => FA_R,
    Cout => FA_Cout
);

-- Adder port map
Ad_instance : ADDER port map(
    A => Ad_A,
    B => Ad_B,
    Cin => Ad_Cin,
    R => Ad_R,
    V => Ad_V,
    C => Ad_Cout
);

-- Arith port map
Ar_instance: ARITH port map(
    A => Ar_A,
    B => Ar_B,
    Sub => Ar_Sub,
    R => Ar_R,
    V => Ar_V,
    C => Ar_Cout
);

-- Logic port map
L_instance: LOGIC port map(
    A => L_A,
    B => L_B,
    Op => L_Op,
    R => L_R
);

-- Now define a process to apply some stimulus over time...
	process
	constant PERIOD: time := 40 ns;
	
    begin
	assert false report "Beginning of simulation" severity note;
           
        -- 1
        FA_A <= '0'; FA_B <= '0'; FA_Cin <= '0';
        Ad_A <= "0000"; Ad_B <= "0000"; Ad_Cin <= '0';
        Ar_A <= "0000"; Ar_B <= "0000";  Ar_Sub <= '0';
        L_A <= "0000"; L_B <= "1111"; L_Op <= "00";
        
        wait for PERIOD;
        assert FA_R = '0' and FA_Cout = '0' report "Full adder 1"; -- Full adder test
        assert Ad_R = "0000" and Ad_V = '0' and Ad_Cout = '0' report "Assertion violation in adder 1"; -- Adder test
        assert Ar_R = "0000" and Ar_V = '0' and Ar_Cout = '0' report "Assertion violation in arith 1"; -- Arith test
        assert L_R = "0000" report "Assertion violation in logic 1";   -- Logic test
        
        -- 2
        FA_A <= '1'; FA_B <= '0'; FA_Cin <= '1';
        Ad_A <= "0011"; Ad_B <= "1100"; Ad_Cin <= '1';
        Ar_A <= "0000"; Ar_B <= "1111";  Ar_Sub <= '1';
        L_A <= "0000"; L_B <= "1111"; L_Op <= "01";
        
        wait for PERIOD;
        assert FA_R = '0' and FA_Cout = '1' report "Assertion violation in full adder 2"; -- Full adder test
        assert Ad_R = "0000" and Ad_V = '0' and Ad_Cout = '1' report "Assertion violation in adder 2"; -- Adder test
        assert Ar_R = "0001" and Ar_V = '0' and Ar_Cout = '0' report "Assertion violation in arith 2"; -- Arith test
        assert L_R = "1111" report "Assertion violation in logic 2";   -- Logic test
        
        -- 3 
        FA_A <= '1'; FA_B <= '0'; FA_Cin <= '0';
        Ad_A <= "0011"; Ad_B <= "1000"; Ad_Cin <= '0';
        Ar_A <= "1000"; Ar_B <= "1111";  Ar_Sub <= '0';
        L_A <= "1010"; L_B <= "1111"; L_Op <= "10";
        
        wait for PERIOD;
        assert FA_R = '1' and FA_Cout = '0' report "Assertion violation in full adder 3"; -- Full adder test
        assert Ad_R = "1011" and Ad_V = '0' and Ad_Cout = '0' report "Assertion violation in adder 3"; -- Adder test
        assert Ar_R = "0111" and Ar_V = '1' and Ar_Cout = '1' report "Assertion violation in arith 3"; -- Arith test
        assert L_R = "0101" report "Assertion violation in logic 3";   -- Logic test

        -- 4
        FA_A <= '1'; FA_B <= '1'; FA_Cin <= '1';
        Ad_A <= "1001"; Ad_B <= "1001"; Ad_Cin <= '1';
        Ar_A <= "0111"; Ar_B <= "0111";  Ar_Sub <= '1';
        L_A <= "0101"; L_B <= "0000"; L_Op <= "11";
        
        wait for PERIOD;
        assert FA_R = '1' and FA_Cout = '1' report "Assertion violation in full adder 4"; -- Full adder test
        assert Ad_R = "0011" and Ad_V = '1' and Ad_Cout = '1' report "Assertion violation in adder 4"; -- Adder test
        assert Ar_R = "0000" and Ar_V = '0' and Ar_Cout = '1' report "Assertion violation in arith 4"; -- Arith test
        assert L_R = "1010" report "Assertion violation in logic 4";   -- Logic test

        wait for PERIOD;
        wait;
    
    end process;

END;
