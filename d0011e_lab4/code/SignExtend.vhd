library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SignExtend is
    port(
	    A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is

begin
    B(15 downto 0) <= A;
    B(31 downto 16) <= (others => A(15));
end Behavioral;