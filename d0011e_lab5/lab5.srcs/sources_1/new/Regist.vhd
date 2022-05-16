library IEEE;
use IEEE.std_logic_1164.all;

entity Regist is
	port(
        Clk, Reset: in std_logic;
        D: in std_logic_vector(31 downto 0);
        Q: out std_logic_vector(31 downto 0)
        );
end entity;


architecture beteende of Regist is
	
begin
  process(clk, Reset) begin
       if Reset = '1' then
           Q <= X"00000000";
	   elsif clk'event and clk = '1' then 
	       Q <= D;
	   end if;
  end process;
end architecture beteende;

