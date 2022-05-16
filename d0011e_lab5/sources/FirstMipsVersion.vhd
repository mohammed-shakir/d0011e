library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FirstMipsVersion is
    port(
            Clk : in std_logic;
            Reset : in std_logic;
            dbg_reg : in std_logic_vector(4 downto 0);
            dbg_reg_data : out std_logic_vector(31 downto 0)
        );
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

component programmemory is
    port( address:in std_logic_vector(31 downto 0);
        instruction: out std_logic_vector(31 downto 0)
        );
end component;

component PCPlus4 is
    PORT(
        Clk: in std_logic;
        Reset: in std_logic;
        Q: out std_logic_vector(31 downto 0)
        );
end component;

component ControlUnit is
    port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        Z : in std_logic;
        RegDestination, WriteEnable, ALUSource : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
end component;

component MUX_2_TO_1 is
    port ( A, B: in std_logic_vector(4 downto 0);
        Op: in std_logic; 
        R : out std_logic_vector(4 downto 0));
end component;


component MUX_2_TO_1_32 is
    port ( A, B: in std_logic_vector(31 downto 0);
    Op: in std_logic; 
    R : out std_logic_vector(31 downto 0));
end component;

component SignExtend is
    port(
		A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0)
		);
end component;

signal memAddress, memInstruction, Mux32Out, A_Data, B_Data, WD, SignExOut: std_logic_vector(31 downto 0);
signal Z, RDes, WE, AS: std_logic;
signal AC: std_logic_vector(2 downto 0);
signal MuxOut: std_logic_vector(4 downto 0);

begin
PCPlusInstance: PCPlus4 PORT MAP(Clk =>Clk, Reset => Reset, Q=>memAddress);
MemoryInstance: programmemory PORT MAP(address => memAddress, instruction => memInstruction); 
ControlInstance: ControlUnit PORT MAP(Opcode => memInstruction(31 downto 26), funct => memInstruction(5 downto 0), Z=>Z, RegDestination=>RDes, WriteEnable=>WE, ALUSource=>AS, ALUControl=>AC);
MuxInstance: MUX_2_TO_1 PORT MAP(A => memInstruction(20 downto 16), B => memInstruction(15 downto 11), Op => RDes, R=>MuxOut);
Mux32Instance: MUX_2_TO_1_32 PORT MAP(A => B_Data, B => SignExOut, Op => AS, R=>Mux32Out);
ALU : ALU_32 PORT MAP(A => A_data, B => Mux32Out, Sub => AC(2), Op => AC(1 downto 0), Z => Z, R => WD);
SignExInstance: SignExtend PORT MAP(A => memInstruction(15 downto 0), B => SignExOut);
RegInstance: RegFile PORT MAP(clk => Clk, reset => Reset, A_Data => A_Data, B_Data=>B_Data, A_addr => memInstruction(25 downto 21), B_addr => memInstruction(20 downto 16), W_data=> WD, W_addr => MuxOut, W_ena => WE, dbg_reg => dbg_reg, dbg_reg_data => dbg_reg_data);

end Behavioral;
