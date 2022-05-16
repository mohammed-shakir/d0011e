----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2021 22:29:25
-- Design Name: 
-- Module Name: LOGIC - Behavioral
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

entity LOGIC_32 is
	port(
		A, B : in std_logic_vector(31 downto 0);
		Op   : in std_logic_vector(1 downto 0);
		R    : out std_logic_vector(31 downto 0));
end entity;


architecture Behavioral of LOGIC_32 is

component FOUR_TO_ONE_MUX_32
        port(
        A, B, C, D : in std_logic_vector(31 downto 0);
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0));
    end component;
    
   signal A_temp, B_temp, C_temp, D_temp : std_logic_vector(31 downto 0);

begin
  merge: for i in 0 to 31 generate 
       A_temp(i) <= (A(i) and B(i));
       B_temp(i) <= (A(i) or B(i));
       C_temp(i) <= (A(i) xor B(i));
       D_temp(i) <= A(i) nor B(i);
    end generate;
    
    
    MUXinstance : FOUR_TO_ONE_MUX_32 port map(A_temp, B_temp, C_temp, D_temp, Op, R);


end Behavioral;
