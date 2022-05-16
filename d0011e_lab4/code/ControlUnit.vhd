library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
	port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        Z : in std_logic;
        RegDestination, WriteEnable, ALUSource : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
end ControlUnit;

architecture Behavioral of ControlUnit is

begin
process(Opcode, funct)
    begin
        if Opcode = "000000"  then
            if funct = "100000" then
                WriteEnable <= '1';
                ALUControl <= "010";
                Regdestination <= '1';
                ALUSource <= '0';

            elsif funct = "100010" then
                WriteEnable <= '1';
                ALUControl <= "110";
                RegDestination <= '1';
                ALUSource <= '0';

            elsif funct = "101010" then
                WriteEnable <= '1';
                ALUControl <= "111";
                RegDestination <= '1';
                ALUSource <= '0';

            elsif funct = "100100" then
                WriteEnable <= '1';
                ALUControl <= "000";
                RegDestination <= '1';
                ALUSource <= '0';

            elsif funct = "100101" then
                WriteEnable <= '1';
                ALUControl <= "001";
                RegDestination <= '1';
                ALUSource <= '0';

            else
                ALUControl <= "000";
                WriteEnable <= '0';
                RegDestination <= '0';
                ALUSource <= '0';
            end if;

        elsif Opcode = "001000" then
            WriteEnable <= '1';
            ALUControl <= "010";
            RegDestination <= '0';
            ALUSource <= '1';

        elsif Opcode = "001010" then 
            WriteEnable <= '1';
            ALUControl <= "111";
            RegDestination <= '0';
            ALUSource <= '1';
        
        else
            ALUControl <= "000";
            WriteEnable <= '0';
            RegDestination <= '0';
            ALUSource <= '0';
        end if;
    end process;
end Behavioral;