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

entity ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic);
end ALU_32;



architecture Behavioral of ALU_32 is

component FOUR_TO_ONE_MUX_32
        port(
        A, B, C, D : in std_logic_vector(31 downto 0);
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0));
end component;

component LOGIC_32
    port(
        A, B : in std_logic_vector(31 downto 0);
		Op   : in std_logic_vector(1 downto 0);
		R    : out std_logic_vector(31 downto 0));
end component;

component ARITH
    port(
        A, B : in std_logic_vector(31 downto 0);
        Sub : in std_logic;
        R : out std_logic_vector(31 downto 0);
        V, C : out std_logic);
end component;

component ZeroExtend
    port(
        A: in std_logic;
        R: out std_logic_vector(31 downto 0));
end component; 
    
signal ANDG, ORG, ADDERRes, ZeroRes, MUXRes : std_logic_vector(31 downto 0);
signal ADDEROverflow, ADDERCarry, VorN: std_logic;

begin
  ANDInstance: LOGIC_32 PORT MAP(A , B, "00",ANDG);
  ORInstance: LOGIC_32 PORT MAP(A, B, "01", ORG);
  ADDERInstance: ARITH PORT MAP(A, B, SUB, ADDERRes, ADDEROverflow, ADDERCarry);
  VorN <= ADDERRes(31) xor ADDEROverflow;
  ZeroInstance: ZeroExtend PORT MAP(VorN, ZeroRes);
  MUXInstance: FOUR_TO_ONE_MUX_32 PORT MAP(ANDG, ORG, ADDERRes, ZeroRes, Op, MUXRes);
  R <= MUXRes;
  V <= ADDEROverflow;
  Z <= '0' when (MUXRes /= X"00000000") else '1';
end Behavioral;
