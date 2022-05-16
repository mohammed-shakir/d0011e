library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DataMemory is 
port ( Clk: in std_logic;
        Reset: in std_logic;
        MemWE : in std_logic;
        Address : in std_logic_vector(31 downto 0);
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0);
        dbg_dm_reg : in std_logic_vector(4 downto 0);
        dbg_dm_reg_data : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behav of DataMemory is
type datamemory_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal MyDatamemory:datamemory_type;
begin
       
process(clk,reset)
    begin
        if reset = '1' then
		  MyDatamemory <= (others => (others => '0'));
            elsif clk'event and clk='1' then
                if MemWE='1' then
                    assert(address >= 0 and address <= 31) report "Address violation: address out of range in datamemory.vhd" severity failure;
                    MyDatamemory(conv_integer(Address))<=DataIn;
                end if;
            end if;
end process;

    DataOut <= MyDatamemory(conv_integer(Address)) when Address < X"00000020" else X"00000000";
    
    -- Debugging
    dbg_dm_reg_data <= MyDatamemory(conv_integer(dbg_dm_reg));
end behav;