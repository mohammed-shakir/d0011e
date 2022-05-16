library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LOGIC is
    port(A, B : in std_logic_vector(3 downto 0);
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(3 downto 0));
end entity LOGIC;

architecture Behavioral of LOGIC is
    component MUX
        port(
            A, B, C, D : in std_logic_vector(3 downto 0);
            OP : in std_logic_vector(1 downto 0);
            R : out std_logic_vector(3 downto 0));
    end component;
    
    signal tempA, tempB, tempC, tempD : std_logic_vector(3 downto 0);
    
    begin
        merge: for i in 0 to 3 generate 
            tempA(i) <= (A(i) and B(i));
            tempB(i) <= (A(i) or B(i));
            tempC(i) <= (A(i) xor B(i));
            tempD(i) <= A(i) nor B(i);
        end generate;
    
    MUXinstance : MUX port map(
        A => tempA,
        B => tempB,
        C => tempC,
        D => tempD,
        OP => Op,
        R => R);
end Behavioral;