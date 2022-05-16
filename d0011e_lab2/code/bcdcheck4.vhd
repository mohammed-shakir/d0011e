library IEEE;
use IEEE.std_logic_1164.all;

entity bcdcheck4 is
    port(x : in std_logic_vector(3 downto 0);
        max, min, even, lo3, noBCD, hieq3 : out std_logic);
end entity bcdcheck4;

architecture beteende of bcdcheck4 is
    signal noBCD_in, lo3_in: std_logic;
    
    begin
        hieq3 <= not noBCD_in and not lo3_in;
        lo3_in <= '1' when (x >= X"0") and (x < X"3") else '0';
        noBCD_in <= '1' when (x > X"9") and (x <= X"F") else '0';
        max <= '1' when x = X"9" else '0';
        min <= '1' when x = X"0" else '0';
        even <= not x(0);
        lo3 <= lo3_in;
        noBCD <= noBCD_in;
end architecture beteende;