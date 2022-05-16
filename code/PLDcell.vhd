library IEEE;
use IEEE.std_logic_1164.all;

entity PLDcell is 
    port(x5, x4, x3, x2, x1, x0, inv : in std_logic;
        y : out std_logic);
end entity PLDcell;

architecture beteende of PLDcell is
    SIGNAL and1, and2, or1 : STD_LOGIC;
    begin
        y <= ((x5 and x4 and x3) or (x2 and x1 and x0)) xor inv;
end architecture beteende;