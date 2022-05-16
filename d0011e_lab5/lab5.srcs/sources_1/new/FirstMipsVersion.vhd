--  FirstMipsVersion
--  Indikerar egenskaper hos siffror i BCD-kod
--  2001-07-04
--  Lars-H Hemert

library IEEE;
use IEEE.std_logic_1164.all;

entity FirstMipsVersion is
    port(
            Clk : in std_logic;
            Reset : in std_logic;
            dbg_reg : in std_logic_vector(4 downto 0);
            dbg_reg_data : out std_logic_vector(31 downto 0);
            dbg_dm_reg : in std_logic_vector(4 downto 0);
            dbg_dm_reg_data : out std_logic_vector(31 downto 0)
        );
end FirstMipsVersion;

architecture beteende of FirstMipsVersion is

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
      dbg_reg_data : OUT std_logic_vector(31 downto 0)
    );
    end component;
    
    component ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic);
    end component;
    
    component Programmemory is -- maybe add something, i dunno
    port(
        address:in std_logic_vector(31 downto 0);
        instruction: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component ControlUnit is
    port( 
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        --Z : in std_logic;
        RegDestination, WriteEnable, ALUSource, MemWE, MemtoReg, Branch, Jump : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
	end component;

    component SignExtend is
	port(
		A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0)
		);
    end component;
    
    component MUX_2_TO_1_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component MUX_2_TO_1 is
    port(
        A, B : in std_logic_vector(4 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(4 downto 0)
        );
    end component;
    
    component PCPlus4 is
    port(
        Clk: in std_logic;
        Reset: in std_logic;
        Q: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component DataMemory is
    port(
        Clk: in std_logic;
        Reset: in std_logic;
        MemWE : in std_logic;
        Address : in std_logic_vector(31 downto 0);
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0);
        dbg_dm_reg : in std_logic_vector(4 downto 0);
        dbg_dm_reg_data : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal PC, instr, singed, SrcA, B_Data_Temp, SrcB, Result, ReadData : std_logic_vector(31 downto 0);
    signal RegDes, WriteEn, ALUSou, Z, MemWewe, MemtoR, BranchT, J : std_logic;
    signal ALUCon : std_logic_vector(2 downto 0);
    signal WriteRegTemp : std_logic_vector(4 downto 0);
    
begin
    PCPlus4_instance : PCPlus4 port map(Clk, Reset, PC);
    ProgMem : programmemory port map(PC, instr);
    ctrl : ControlUnit port map(instr(31 downto 26), instr(5 downto 0), RegDes, WriteEn, ALUSou, MemWewe, MemtoR, BranchT, J, ALUCon);
    miniMux1 : MUX_2_TO_1 port map(instr(20 downto 16), instr(15 downto 11), RegDes, WriteRegTemp);
    regflile : Regfile port map(
        clk => clk, 
        reset => reset, 
        A_addr => instr(25 downto 21), 
        B_addr => instr(20 downto 16), 
        W_addr => WriteRegTemp, 
        W_ena => WriteEn, 
        A_data => SrcA, 
        B_data => B_Data_Temp, 
        W_data => Result, 
        dbg_reg => dbg_reg, 
        dbg_reg_data => dbg_reg_data);
    sign : SignExtend port map(instr(15 downto 0), singed);
    miniMux2 : MUX_2_TO_1_32 port map(B_Data_Temp, singed, ALUSou, SrcB);
    ALU : ALU_32 port map(SrcA, SrcB, ALUCon(2), ALUCon(1 downto 0), Result, Z => Z);
    DataMem : DataMemory port map(Clk, Reset, MemWewe, Result, B_Data_Temp, ReadData, dbg_dm_reg, dbg_dm_reg_data);
end architecture beteende;

