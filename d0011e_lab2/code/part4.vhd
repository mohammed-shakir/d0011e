library IEEE;
use IEEE.std_logic_1164.all;

entity part4 is
    port(x : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(3 downto 0));
end part4;

architecture beteende of part4 is
    component part4Cell is
        port(x5, x4, x3, x2, x1, x0, inv : in std_logic;
            y : out std_logic);
    end component;

    begin
        cell1 : part4Cell PORT MAP(x(0), '1', '0', '0', '0', '0', '1', y(0));
        cell2 : part4Cell PORT MAP(x(1), '1', '0', '0', '0', '0', '0', y(1));
        cell3 : part4Cell PORT MAP(x(1), '1', '0', '0', '0', '0', x(2), y(2));
        cell4 : part4Cell PORT MAP(x(3), '1', x(2), '1', x(1), '1', '1', y(3));
end architecture beteende;