LIBRARY ieee;
use ieee.std_logic_1164.all;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 

-- First, declare the lower-level entity (Component).
component ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic
    );
end component;

component PCPlus4 is
    port(
        Clk: in std_logic;
        Reset : in std_logic;
        Q: out std_logic_vector(31 downto 0)
    );
end component;

-- Next, declare some local signals to assign values to and observe...
-- Delete the signal below and make your own, it is only there to show you the structure of the test bench.
signal A, B, R, Q : std_logic_vector(31 downto 0);
signal Op : std_logic_vector(1 downto 0);
signal SUB, V, C, Z, Clk, Reset : std_logic;


begin
-- Create an instance of the component under test (Port map).
ALU_32_instance : ALU_32 port map(
    A => A,
    B => B,
    SUB => SUB,
    Op => Op,
    R => R,
    V => V,
    C => C,
    Z => Z
);

PCPlus4_instace : PCPlus4 port map (
    Clk => Clk,
    Reset => Reset,
    Q => Q
);

-- Now define a process to apply some stimulus over time...
	process
	constant PERIOD: time := 40 ns;
	
    begin
        -- ALU: AND, PCPlus4: Reset = 1
        A <= x"000F4240";
        B <= x"FFFFFFFF";
        Op <= "00";
        SUB <= '0';
        Clk <= '0'; -- The reset should be async
        Reset <= '1';
        
        wait for PERIOD;
        assert R = x"000F4240" and Q = x"00000000" report "Assertion violation for ALU AND or PCPlus4 reset";

        -- ALU: OR, PCPlus4: Clk = 1
        A <= x"000F4240";
        B <= x"FFFFFFFF";
        Op <= "01";
        SUB <= '1';
        Clk <= '1';
        Reset <= '0';

        wait for PERIOD;
        assert R = x"FFFFFFFF" and Q = x"00000004" report "Assertion violation for ALU OR or PCPlus4 first high clk";

        -- ALU: ADD, PCPlus4: Clk = 0
        A <= x"FACEFEED";
        B <= x"00000AAA";
        Op <= "10";
        SUB <= '0';
        Clk <= '0';
        Reset <= '0';

        wait for PERIOD;
        assert R = x"FACF0997" and Q = x"00000004" report "Assertion violation for ALU ADD or PCPlus4 first low clk";

        -- ALU: SUB, PCPlus4: Clk = 1
        A <= x"FACEFEED";
        B <= x"DEADBEEF";
        Op <= "10";
        SUB <= '1';
        Clk <= '1';
        Reset <= '0';

        wait for PERIOD;
        assert R = x"1C213FFE" and Q = x"00000008" report "Assertion violation for ALU SUB or PCPlus4 second high clk";
        
        -- ALU: ZeroExtend, PCPlus4: Reset = 1
        -- ZeroExtend calculated by Z = MSB xor V
        A <= x"DEADBEEF";
        B <= x"FACEFEED";
        Op <= "11";
        SUB <= '1';
        Clk <= '1';
        Reset <= '1';

        wait for PERIOD;
        assert R = x"00000001" and Q = x"00000000" report "Assertion violation for ALU ZeroExtend or PCPlus4 second reset";
        
        -- Don't delete this wait the simulation will run forever and CI testing breaks.
        wait;
    
    end process;

END;
