----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2021 23:15:02
-- Design Name: 
-- Module Name: FULL_ADDER - Behavioral
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

entity FULL_ADDER is 
	port(
		A, B, Cin : in std_logic;
		R, Cout   : out std_logic);
end entity;


architecture Behavioral of FULL_ADDER is

begin
    R <= (A xor B) xor Cin;
    Cout <= (A and B) or ((Cin and A) or (Cin and B));

end Behavioral;
