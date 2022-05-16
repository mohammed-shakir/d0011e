library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignExtend is
	port(
		A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0)
		);
end SignExtend;


architecture Behavioral of SignExtend is

begin
original: for i in 0 to 15 generate
    B(i) <= A(i);
end generate;

extend: for j in 16 to 31 generate
    B(j) <= A(15); 
end generate;


end Behavioral;
