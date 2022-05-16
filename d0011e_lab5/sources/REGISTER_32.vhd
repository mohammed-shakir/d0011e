----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2021 15:56:39
-- Design Name: 
-- Module Name: REGISTER_32 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTER_32 is
    port (Clk, Reset : in std_logic;
          d : in std_logic_vector(31 downto 0);
          q : out std_logic_vector(31 downto 0)    
          );
end REGISTER_32;

architecture Behavioral of REGISTER_32 is

begin
process (Clk, Reset) 
  
  begin
       if Reset = '1' then
            q <= x"00000000";
       
      elsif rising_edge(clk) then
           q <= d;
      end if;
  
  end process ;

end Behavioral;
