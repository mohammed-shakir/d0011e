library IEEE;
use IEEE.std_logic_1164.all;

entity part4Cell is
    port(x5, x4, x3, x2, x1, x0, inv : in std_logic;
        y : out std_logic);
end part4Cell;

architecture beteende of part4Cell is
    begin
        y <= ((x0 and x1) or (x2 and x3) or (x4 and x5)) xor inv;
end architecture beteende;