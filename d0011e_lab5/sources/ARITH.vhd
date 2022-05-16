----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2021 21:21:43
-- Design Name: 
-- Module Name: ARITH - Behavioral
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

entity ARITH is
    port(
        A, B : in std_logic_vector(31 downto 0);
        Sub : in std_logic;
        R : out std_logic_vector(31 downto 0);
        V, C : out std_logic);
end ARITH;


architecture Behavioral of ARITH is
component ADDER is 
	port(
		A, B : in std_logic_vector(31 downto 0);
		Cin  : in std_logic;
		R    : out std_logic_vector(31 downto 0);
		V, C : out std_logic);
end component ;

signal local_SubB: std_logic_vector(31 downto 0);
begin
    merge: for i in 0 to 31 generate
        local_SubB(i) <= B(i) xor Sub;
    end generate;
    
    R1: ADDER PORT MAP(A, local_SubB, Sub, R, V, C);

end Behavioral;

