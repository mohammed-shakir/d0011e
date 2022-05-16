library IEEE;
use IEEE.std_logic_1164.all;

entity ADDER is 
	port(
		A, B : in std_logic_vector(31 downto 0);
		Cin  : in std_logic;
		R    : out std_logic_vector(31 downto 0);
		V, C : out std_logic);
end entity;


architecture beteende of ADDER is
    
    component FULL_ADDER is
    port(
		A, B, Cin : in std_logic;
		R, Cout   : out std_logic);
	end component;
	
	signal Coutt : std_logic_vector(32 downto 0);
	
begin
  Coutt(0) <= Cin;
  adders: for i in 0 to 31 generate
    addet_instance : FULL_ADDER port map (A(i), B(i), Coutt(i), R(i), Coutt(i+1));
  end generate;
  C <= Coutt(32);
  V <= Coutt(32) xor Coutt(31);
  
end architecture beteende;

