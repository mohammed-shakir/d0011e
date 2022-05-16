----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2021 07:47:09 PM
-- Design Name: 
-- Module Name: MUX_2_TO_1 - Behavioral
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

entity MUX_2_TO_1 is
    port ( A, B: in std_logic_vector(4 downto 0);
        Op: in std_logic; 
        R : out std_logic_vector(4 downto 0));
end MUX_2_TO_1;

architecture Behavioral of MUX_2_TO_1 is

begin
R <= A when (Op = '0') else
     B;

end Behavioral;
