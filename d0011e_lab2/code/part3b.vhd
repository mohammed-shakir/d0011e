library IEEE;
use IEEE.std_logic_1164.all;

entity part3b is
    port(a, c, d : in std_logic;
        f : out std_logic);
end part3b;

architecture beteende of part3b is
    component PLDcell
        port(x5, x4, x3, x2, x1, x0, inv: std_logic;
            y : out std_logic);
    end component;
    
    signal inverseA, inverseC: std_logic;
    
    begin
        inverseA <= not a;
        inverseC <= not c;

        f2 : PLDcell PORT MAP(inverseA, inverseC, d, a, c, '1', '1', f);
end architecture beteende;