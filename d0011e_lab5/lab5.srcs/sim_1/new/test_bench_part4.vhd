LIBRARY ieee;
use ieee.std_logic_1164.all;
 
ENTITY test_bench_part_4 IS
END test_bench_part_4;
 
ARCHITECTURE behavior OF test_bench_part_4 IS 

-- First, declare the lower-level entity (Component).
    component FirstMipsVersion is
    port(
        Clk : in std_logic;
        Reset : in std_logic;
        dbg_reg : in std_logic_vector(4 downto 0);
        dbg_reg_data : out std_logic_vector(31 downto 0);
        dbg_dm_reg : in std_logic_vector(4 downto 0);
        dbg_dm_reg_data : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component SecondMipsVersion is
    port(
        Clk : in std_logic;
        Reset : in std_logic;
        dbg_reg : in std_logic_vector(4 downto 0);
        dbg_reg_data : out std_logic_vector(31 downto 0);
        dbg_dm_reg : in std_logic_vector(4 downto 0);
        dbg_dm_reg_data : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk, reset : std_logic;
    signal dbg_reg, dbg_dm_reg : std_logic_vector(4 downto 0);
    signal dbg_reg_data, dbg_dm_reg_data : std_logic_vector(31 downto 0);

    begin
-- Create an instance of the component under test (Port map).
    --first : FirstMipsVersion port map(clk, reset, dbg_reg, dbg_reg_data, dbg_dm_reg, dbg_dm_reg_data);
    second : SecondMipsVersion port map(clk, reset, dbg_reg, dbg_reg_data, dbg_dm_reg, dbg_dm_reg_data);
-- Now define a process to apply some stimulus over time...
	process
	
	constant PERIOD: time := 40 ns;
	
    begin
    
        -- Remove code below and add your own tests to show your component implementations are correct.
        clk <= '0';
        reset <= '1';
        dbg_reg <= "00011"; dbg_dm_reg <= "00000";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" and dbg_dm_reg_data = X"00000000" report "Initial reset";
        
        clk <= '1';
        reset <= '0';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        reset <= '0';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        clk <= '1';
        wait for PERIOD;
        clk <= '0';
        wait for PERIOD;
        
        -- N = 12, D = 5
--        clk <= '1';
--        dbg_reg <= "00010";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000002" report "Q is wrong";
--        clk <= '0';
--        dbg_reg <= "00011";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000002" report "R is wrong";
        
        --N = 12, D = 12
--        clk <= '1';
--        dbg_reg <= "00010";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000001" report "Q is wrong";
--        clk <= '0';
--        dbg_reg <= "00011";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000000" report "R is wrong";
        
        --N = 5, D = 12
        clk <= '1';
        dbg_reg <= "00010";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "Q is wrong";
        clk <= '0';
        dbg_reg <= "00011";
        wait for PERIOD;
        assert dbg_reg_data = X"00000005" report "R is wrong";
        
        -- Don't delete this wait the simulation will run forever and CI testing breaks.
        wait;
    
    end process;

END;