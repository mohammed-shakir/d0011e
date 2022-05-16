LIBRARY ieee;
use ieee.std_logic_1164.all;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 

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
    
    component ControlUnit is
    port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        --Z : in std_logic; --still don't know what it's for
        RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
	end component;

    signal clk, reset : std_logic;
    signal dbg_reg, dbg_dm_reg : std_logic_vector(4 downto 0);
    signal dbg_reg_data, dbg_dm_reg_data : std_logic_vector(31 downto 0);
    
    signal Opcode, funct : std_logic_vector(5 downto 0);
    signal RegDestination, WriteEnable, ALUSource, MemWe, MemtoReg, Branch, Jump : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    
    begin
-- Create an instance of the component under test (Port map).
    --first : FirstMipsVersion port map(clk, reset, dbg_reg, dbg_reg_data, dbg_dm_reg, dbg_dm_reg_data);
    second : SecondMipsVersion port map(clk, reset, dbg_reg, dbg_reg_data, dbg_dm_reg, dbg_dm_reg_data);
    --NOTE to PEERS: vet inte hur de ville ha first och second olika men...
    controller : ControlUnit port map(Opcode, funct, RegDestination, WriteEnable, ALUSource, MemWe, MemtoReg, Branch, Jump, ALUControl);
-- Now define a process to apply some stimulus over time...
	process
	
	constant PERIOD: time := 40 ns;
	
    begin
    
        -- Remove code below and add your own tests to show your component implementations are correct.
        clk <= '0';
        reset <= '1';
        dbg_reg <= "00000"; dbg_dm_reg <= "00000";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" and dbg_dm_reg_data = X"00000000" report "Initial reset";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00000"; dbg_dm_reg <= "00000";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" and dbg_dm_reg_data = X"00000000" report "ERROR 1st clock (addi)";

        clk <= '0';
        reset <= '0';
        dbg_reg <= "00000";
        wait for PERIOD;
        assert dbg_reg_data = x"00000000" report "ERROR 1st uclock (addi)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00001";
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" report "ERROR 2nd clock (addi)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00001";
        wait for PERIOD;
        assert dbg_reg_data = x"00000003" report "ERROR 2nd uclock (addi)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00010";
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" report "ERROR 3rd clock (add)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00010";
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" report "ERROR 3rd uclock (add)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00011";
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" report "ERROR 4th clock (sub)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00011";
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" report "ERROR 4th uclock (sub)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 5th clock (slt)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 5th uclock (slt)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 6th clock (slti)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 6th uclock (slti)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 7th clock (slt)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00100";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 7th uclock (slt)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00101";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 8th clock (or)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00101";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 8th uclock (or)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "00110";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 9th clock (and)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "00110";
        wait for PERIOD;
        assert dbg_reg_data = X"00000000" report "ERROR 9th uclock (and)";
        
        clk <= '1';
        reset <= '0';
        dbg_dm_reg <= "00000";
        wait for PERIOD;
        assert dbg_dm_reg_data = X"00000003" report "ERROR 10th clock (SW)";
        
        clk <= '0';
        reset <= '0';
        dbg_dm_reg <= "00000";
        wait for PERIOD;
        assert dbg_dm_reg_data = X"00000003" report "ERROR 10th uclock (SW)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "01000";
        dbg_dm_reg <= "00000"; 
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR 11th clock (LW)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "01000";
        dbg_dm_reg <= "00000"; 
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR 11th uclock (LW)";
        
        clk <= '1';
        reset <= '0';
        dbg_dm_reg <= "00100"; 
        wait for PERIOD;
        assert dbg_dm_reg_data = X"00000003" report "ERROR 12th clock (SW)";
        
        clk <= '0';
        reset <= '0';
        dbg_dm_reg <= "00100"; 
        wait for PERIOD;
        assert dbg_dm_reg_data = X"00000003" report "ERROR 12th uclock (SW)";
        
        clk <= '1';
        reset <= '0';
        dbg_reg <= "01001";
        dbg_dm_reg <= "00100"; 
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR 13th clock (LW)";
        
        clk <= '0';
        reset <= '0';
        dbg_reg <= "01001";
        dbg_dm_reg <= "00100"; 
        wait for PERIOD;
        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR 13th uclock (LW)";
        
-- Part 2's post run assertions. Five clocks to go forward a bit, then assertions for all the used registers. 
--        clk <= '1';
--        wait for PERIOD;
--        clk <= '0';
--        wait for PERIOD;
--        clk <= '1';
--        wait for PERIOD;
--        clk <= '0';
--        wait for PERIOD;
--        clk <= '1';
--        wait for PERIOD;
--        clk <= '0';
--        wait for PERIOD;
--        clk <= '1';
--        wait for PERIOD;
--        clk <= '0';
--        wait for PERIOD;
--        clk <= '1';
--        wait for PERIOD;
--        clk <= '0';
--        wait for PERIOD;
        
--        dbg_reg <= "00000";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000000" report "ERROR reg 00000";
        
--        dbg_reg <= "00001";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000003" report "ERROR reg 00001";

--        dbg_reg <= "00010";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000003" report "ERROR reg 00010";

--        dbg_reg <= "00011";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000003" report "ERROR reg 00011";

--        dbg_reg <= "00100";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000000" report "ERROR reg 00100";

--        dbg_reg <= "00101";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000000" report "ERROR reg 00101";

--        dbg_reg <= "00110";
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000000" report "ERROR reg 00110";
                
--        dbg_reg <= "01000";
--        dbg_dm_reg <= "00000"; 
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR reg 01000, mem 00000";

--        dbg_reg <= "01001";
--        dbg_dm_reg <= "00100"; 
--        wait for PERIOD;
--        assert dbg_reg_data = X"00000003" and dbg_dm_reg_data = X"00000003" report "ERROR reg 01001, mem 00100";
        
-- End of Part 2's check
        
-- Part 3's control unti tests
        
--        Opcode <= "000000";
--        funct <= "100000"; -- ADD
--        wait for PERIOD;
--        assert ALUControl = "010" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '1' and ALUSource = '0' and Branch = '0' and Jump = '0' report "ERROR ADD";
        
--        funct <= "100010"; -- SUB
--        wait for PERIOD;
--        assert ALUControl = "110" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '1' and ALUSource = '0' and Branch = '0' and Jump = '0' report "ERROR SUB";

--        funct <= "101010"; -- SLT
--        wait for PERIOD;
--        assert ALUControl = "111" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '1' and ALUSource = '0' and Branch = '0' and Jump = '0' report "ERROR SLT"; 
        
--        funct <= "100100"; -- AND
--        wait for PERIOD;
--        assert ALUControl = "000" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '1' and ALUSource = '0' and Branch = '0' and Jump = '0' report "ERROR AND";
        
--        funct <= "100101"; -- OR
--        wait for PERIOD;
--        assert ALUControl = "001" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '1' and ALUSource = '0' and Branch = '0' and Jump = '0' report "ERROR OR";
        
--        Opcode <= "001000"; -- ADDI
--        wait for PERIOD;
--        assert ALUControl = "010" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR ADDI";
        
--        Opcode <= "001010"; -- SLTI
--        wait for PERIOD;
--        assert ALUControl = "111" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR SLTI";
        
--        Opcode <= "100011"; -- LW
--        wait for PERIOD;
--        assert ALUControl = "010" and WriteEnable = '1' and MemtoReg = '1' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR LW";
        
--        Opcode <= "101011"; -- SW
--        wait for PERIOD;
--        assert ALUControl = "010" and WriteEnable = '0' and MemtoReg = '0' and MemWE = '1' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR SW";
        
--        Opcode <= "000100"; -- BEQ
--        wait for PERIOD;
--        assert ALUControl = "110" and WriteEnable = '0' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '0' and Branch = '1' and Jump = '0' report "ERROR BEQ";
        
--        Opcode <= "000010"; -- JUMP
--        wait for PERIOD;
--        assert WriteEnable = '0' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '1' report "ERROR JUMP";
        
--        Opcode <= "001100"; -- ANDI
--        wait for PERIOD;
--        assert ALUControl = "000" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR ANDI";
        
--        Opcode <= "001101"; -- ORI
--        wait for PERIOD;
--        assert ALUControl = "001" and WriteEnable = '1' and MemtoReg = '0' and MemWE = '0' and RegDestination = '0' and ALUSource = '1' and Branch = '0' and Jump = '0' report "ERROR ORI";
        
        -- Don't delete this wait the simulation will run forever and CI testing breaks.
        wait;
    
    end process;

END;