library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
	port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        -- Z : in std_logic;
        RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
end ControlUnit;


architecture Behavioral of ControlUnit is

    signal vec : std_logic_vector(11 downto 0);
    
begin

    vec <= Opcode & funct;
    
    process(vec)
    begin
        case vec is
            when "000000100100" => -- AND
                
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("1100000"); 
                ALUControl <= "000";
                
            when "000000100101" => --OR
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("1100000");
                ALUControl <= "001";
                
            when "000000100000" => --ADD
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("1100000"); 
                ALUControl <= "010";
                
            when "000000100010" => --SUB
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("1100000"); 
                ALUControl <= "110";
                
            when "000000101010" => --SLT
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("1100000"); 
                ALUControl <= "111";
                
            when "001100------" => --ANDI
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0110000"); 
                ALUControl <= "000";
                
            when "001101------" => --ORI
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0110000"); 
                ALUControl <= "001";
                
            when "001000------" => --ADDI
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0110000"); 
                ALUControl <= "010";
            
            when "001010------" => --SLTI
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0110000"); 
                ALUControl <= "111";
            
            when "100011------" => --LW
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0110100"); 
                ALUControl <= "010";
                
            when "101011------" => --SW
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("-011-00"); 
                ALUControl <= "010";
                
            when "000100------" => --BEQ
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("-000-10"); 
                ALUControl <= "110";
                
            when "000010------" => --J
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("-0-0--1"); 
                ALUControl <= "---";
                
            when others => --NOOP
                (RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump) <= std_logic_vector'("0000000"); 
                ALUControl <= "000";
        end case;
    end process;
end Behavioral;