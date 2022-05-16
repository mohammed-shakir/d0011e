LIBRARY ieee;
use ieee.std_logic_1164.all;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 

    component FirstMipsVersion is
        port(
            Clk : in std_logic;
            Reset : in std_logic;
            dbg_reg : in std_logic_vector(4 downto 0);
            dbg_reg_data : out std_logic_vector(31 downto 0)
            );
    end component;
    
    signal Clk,Reset : std_logic;
    signal dbg_reg : std_logic_vector(4 downto 0);
    signal dbg_reg_data : std_logic_vector(31 downto 0);

    begin
        FirstMipsVersion_I: FirstMipsVersion port map(Clk,Reset,dbg_reg,dbg_reg_data);
        
	process
	constant PERIOD: time := 40 ns;
	
    begin
        Clk <='0';
        Reset <= '1';
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00000";
        wait for PERIOD;
        assert dbg_reg_data = x"fffffff8" report "Assertion violation 1";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00001";
        wait for PERIOD;
        assert dbg_reg_data = x"00000003" report "Assertion violation 2";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00011";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 3";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 4";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 5";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 6";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 7";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00101";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 8";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        Clk <= '1';
        Reset <= '0';
        dbg_reg <= "00110";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "Assertion violation 9";
        Clk <= '0';
        Reset <= '0';      
        wait for PERIOD;

        -- Don't delete this wait the simulation will run forever and CI testing breaks.
        wait;
    end process;
END;