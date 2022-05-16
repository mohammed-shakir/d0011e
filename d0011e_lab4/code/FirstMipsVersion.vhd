library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FirstMipsVersion is
    Port (
            Clk : in std_logic;
            Reset : in std_logic;
            dbg_reg : in std_logic_vector(4 downto 0);
            dbg_reg_data : out std_logic_vector(31 downto 0));
end FirstMipsVersion;

architecture Behavioral of FirstMipsVersion is

component Regfile is
    port(
        clk: IN std_logic;
        reset: IN std_logic;
        A_data: OUT std_logic_vector(31 downto 0);
        B_data: OUT std_logic_vector(31 downto 0);
        A_addr: IN std_logic_vector(4 downto 0);
        B_addr: IN std_logic_vector(4 downto 0);
        W_data: IN std_logic_vector(31 downto 0);
        W_addr: IN std_logic_vector(4 downto 0);
        W_ena: IN std_logic;
        dbg_reg : IN std_logic_vector(4 downto 0);
        dbg_reg_data : OUT std_logic_vector(31 downto 0));
end component;

component ControlUnit is
    port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        Z : in std_logic;
        RegDestination, WriteEnable, ALUSource : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0));
end component;

component ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic);
end component;

component programmemory is
    port(
        address:in std_logic_vector(31 downto 0);
        instruction: out std_logic_vector(31 downto 0));
end component;

component PCPlus4 is
    Port (
        Clk : in std_logic; 
        Reset : in std_logic;
        Q  : out std_logic_vector(31 downto 0));
 end component;

component SignExtend
 port(
     A : in std_logic_vector(15 downto 0);
     B : out std_logic_vector(31 downto 0)
 );
end component;

 
component MUX_2TO1 is
    port ( 
        A, B : in std_logic_vector(4 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(4 downto 0));
end component;

component MUX_2TO1_32 is
    port ( 
        A, B : in std_logic_vector(31 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(31 downto 0));
end component;

component SignalExtend is
	port(
		A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0));
end component;

signal Z, RegDestination, WriteEnable, ALUSource, SUB : std_logic;
signal Op : std_logic_vector(1 downto 0);
signal ALUControl : std_logic_vector(2 downto 0);
signal A1, A2, A3, rd : std_logic_vector(4 downto 0);
signal Opcode, funct : std_logic_vector(5 downto 0);
signal PC, ins, SExt, RD1, RD2, SrcB, WD : std_logic_vector(31 downto 0);

begin
    progress: PCPlus4 port map(Clk, Reset, PC);
    
    mem: programmemory port map(PC, ins);         
    Opcode <= ins(31 downto 26);
    funct <= ins(5 downto 0);
    A1 <= ins(25 downto 21);
    A2 <= ins(20 downto 16);
    rd <= ins(15 downto 11);
    
    cunit : ControlUnit port map(Opcode, funct, Z, RegDestination, WriteEnable, ALUSource, ALUControl);
    
    mux_5 : MUX_2TO1 port map(A2, rd, RegDestination, A3);
    
    reg: Regfile port map(Clk, Reset, RD1, RD2, A1, A2, WD, A3, WriteEnable, dbg_reg, dbg_reg_data);
    
    sextr : SignExtend port map(ins(15 downto 0), SExt);
    
    mux_32 : MUX_2TO1_32 port map(RD2, SExt, ALUSource, SrcB);
    
    SUB <= ALUControl(2);
    Op <= ALUControl(1 downto 0);
    
    ALU : ALU_32 port map(RD1, SrcB, SUB, Op, WD);
end Behavioral;