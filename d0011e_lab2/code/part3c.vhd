library IEEE;
use IEEE.std_logic_1164.all;

entity part3c is
    port(a, b, c, d, e : in std_logic;
        g : out std_logic);
end part3c;

architecture beteende of part3c is
    component PLDcell is
        port(x5, x4, x3, x2, x1, x0, inv : in std_logic;
            y : out std_logic);
    end component;

    signal inverseA, inverseB, inverseC, z : std_logic;

    begin
        inverseA <= not a;
        inverseB <= not b;
        inverseC <= not c;
        cell1 : PLDcell PORT MAP('0','0','0',inverseA,inverseB,inverseC,'0',z);
        cell2 : PLDcell PORT MAP(inverseA,inverseB,inverseC,'1','1',z,'0',g);
end architecture beteende;