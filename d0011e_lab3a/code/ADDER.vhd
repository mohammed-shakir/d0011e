library IEEE;
use IEEE.std_logic_1164.all;

entity ADDER is
    port(
        A, B : in std_logic_vector(3 downto 0);
        Cin  : in std_logic;
        R    : out std_logic_vector(3 downto 0);
        V, C : out std_logic);
end entity ADDER;

architecture Behavioral of ADDER is
    component FULL_ADDER is
        port(A, B, Cin : in STD_LOGIC;
            R, Cout : out STD_LOGIC);
    end component;
  
    signal carryOut : std_logic_vector(3 DOWNTO 0); 

    begin
        R1 : FULL_ADDER PORT MAP(A(0), B(0), Cin, R(0), carryOut(0));
        R2 : FULL_ADDER PORT MAP(A(1), B(1), carryOut(0), R(1), carryOut(1));
        R3 : FULL_ADDER PORT MAP(A(2), B(2), carryOut(1), R(2), carryOut(2));
        R4 : FULL_ADDER PORT MAP(A(3), B(3), carryOut(2), R(3), carryOut(3));
        V <= carryOut(2) XOR carryOut(3);
        C <= carryOut(3);
end Behavioral;