library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ARITH is
    port(
        A, B : in std_logic_vector(3 downto 0);
        Sub  : in std_logic;
        R    : out std_logic_vector(3 downto 0);
        V, C : out std_logic);
end ARITH;

architecture Behavioral of ARITH is
    component ADDER is
        port(A, B : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            R : out std_logic_vector(3 downto 0); 
            V, C : out std_logic);
    end component;
    
    signal vec: std_logic_vector(3 downto 0);
  
    begin
        vec(0) <= Sub XOR B(0);
        vec(1) <= Sub XOR B(1);
        vec(2) <= Sub XOR B(2);
        vec(3) <= Sub XOR B(3);
  
        A1 : ADDER PORT MAP(A => A, B => vec, Cin => Sub, R => R, V => V, C => C);
end Behavioral;