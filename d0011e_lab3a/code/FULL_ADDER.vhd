library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FULL_ADDER is
    port(
        A, B, Cin : in std_logic;
        R, Cout : out std_logic);
end entity;

architecture beteende of FULL_ADDER is
    signal x_or, and1, and2: STD_LOGIC;
    
    begin
        x_or <= A XOR B;
        and1 <= A AND B;
        and2 <= x_or AND Cin;
        R <= x_or XOR Cin;
        Cout <= and1 OR and2;
end beteende;