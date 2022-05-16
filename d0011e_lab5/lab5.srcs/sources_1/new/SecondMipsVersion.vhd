library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SecondMipsVersion is
  port(
    Clk : in std_logic;
    Reset : in std_logic;
    dbg_reg : in std_logic_vector(4 downto 0);
    dbg_reg_data : out std_logic_vector(31 downto 0);
    dbg_dm_reg : in std_logic_vector(4 downto 0);
    dbg_dm_reg_data : out std_logic_vector(31 downto 0)
  );
end SecondMipsVersion;



architecture beteende of SecondMipsVersion is

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
    
    component ADDER is
    port(
		A, B : in std_logic_vector(31 downto 0);
		Cin : in std_logic;
		R : out std_logic_vector(31 downto 0);
		V, C   : out std_logic);
	end component;
    
    component sll_32bit is
    port(
        A : in std_logic_vector(31 downto 0);
        R : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component sll_26bit is
    port(
        A : in std_logic_vector(25 downto 0);
        R : out std_logic_vector(27 downto 0)
        );
    end component;
    
    component Regist is
    port(
        Clk, Reset: in std_logic;
        D: in std_logic_vector(31 downto 0);
        Q: out std_logic_vector(31 downto 0));
    end component;
    
    signal PC, instr, singed, SrcA, B_Data_Temp, SrcB, Result, ReadData, Result2, CrntClk, NewClk : std_logic_vector(31 downto 0); 
    signal singedTemp, AdrTemp, muxTemp1, muxTemp2, shatpat, shatpat2 : std_logic_vector(31 downto 0);
    signal RegDes, WriteEn, ALUSou, Z, MemWewe, MemtoR, BranchT, J, op4 : std_logic;
    signal ALUCon : std_logic_vector(2 downto 0);
    signal WriteRegTemp : std_logic_vector(4 downto 0);
    
begin
    reg : Regist port map(Clk, Reset, muxTemp2, NewClk);
    PCPlus4 : ADDER port map(NewClk, X"00000004", '0', PC);
    ProgMem : programmemory port map(NewClk, instr);
    ctrl : ControlUnit port map(instr(31 downto 26), instr(5 downto 0), RegDes, WriteEn, ALUSou, MemWewe, MemtoR, BranchT, J, ALUCon);
    miniMux1 : MUX_2_TO_1 port map(A => instr(20 downto 16), B => instr(15 downto 11), Op => RegDes, R=> WriteRegTemp);
    regflile : Regfile port map(
        clk => clk, 
        reset => reset, 
        A_addr => instr(25 downto 21), 
        B_addr => instr(20 downto 16), 
        W_addr => WriteRegTemp, 
        W_ena => WriteEn, 
        A_data => SrcA, 
        B_data => B_Data_Temp, 
        W_data => Result2, 
        dbg_reg => dbg_reg, 
        dbg_reg_data => dbg_reg_data);
    sign : SignExtend port map(instr(15 downto 0), singed);
    leftshit : sll_32bit port map(singed, singedTemp);
    PCBranch : ADDER port map(singedTemp, PC, '0', AdrTemp);
    op4 <= BranchT and Z;
    miniMux4 : MUX_2_TO_1_32 port map(PC, AdrTemp, op4,  muxTemp1);
    leftshat : sll_26bit port map(instr(25 downto 0), shatpat(27 downto 0));
    shatpat2(31 downto 28) <= PC(31 downto 28);
    shatpat2(27 downto 0) <= shatpat(27 downto 0);
    miniMux5 : MUX_2_TO_1_32 port map(MuxTemp1, shatpat2, J, muxTemp2);
    miniMux2 : MUX_2_TO_1_32 port map(B_Data_Temp, singed, ALUSou, SrcB);
    ALU : ALU_32 port map(SrcA, SrcB, ALUCon(2), ALUCon(1 downto 0), Result, Z => Z);
    DataMem : DataMemory port map(Clk, Reset, MemWewe, Result, B_Data_Temp, ReadData, dbg_dm_reg, dbg_dm_reg_data);
    miniMux3 : MUX_2_TO_1_32 port map(Result, ReadData, MemtoR, Result2);
end architecture beteende;
