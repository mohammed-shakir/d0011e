library IEEE;
use IEEE.std_logic_1164.all;

entity programmemory is
  port( address:in std_logic_vector(31 downto 0);
        instruction: out std_logic_vector(31 downto 0)
        );
end programmemory;

architecture behav of programmemory is
begin

with address select
  instruction <=
                "00100000001000001111111111111000" when X"00000000",  --addi r0,r1,-8
                "00100000010000010000000000000011" when X"00000004",  --addi r1,r2,3
		        "00000000000000010001000000100000" when X"00000008",  --add r2,r0,r1
                "00000000001000000001100000100010" when X"0000000c",  --sub r3,r1,r0
		        "00000000010000110010000000101010" when X"00000010",  --slt r4,r2,r3
		        "00101000010001001111111111110111" when X"00000014",  --slti r4,r2,-9
		        "00000000010000110010000000101010" when X"00000018",  --slt r4,r2,r3
		        "00000000100001100010100000100101" when X"0000001c",  --or  r5,r4,r6
		        "00000000101000010011000000100100" when X"00000020",  --and r6,r5,r1
		        "10101100111000100000000000000000" when X"00000024", --sw r2, 0(r7)
		        "10001100111010000000000000000000" when X"00000028", --lw r8, 0(r7)
		        "10101101001000110000000000000100" when X"0000002c", --sw r3, 4(r9)
		        "10001101010010010000000000000100" when X"00000030", --lw r9, 4(r10)
		        --Part 4
                
               -- N = 12, D = 5
--               "00100000000001000000000000001100" when X"00000000",   --Sets N                                                     (addi $a0, $zero, N)
--               "00100000000001010000000000000101" when X"00000004",   --Sets D                                                     (addi $a1, $zero, D)
               
               -- N = 12, D = 12
--               "00100000000001000000000000001100" when X"00000000",   --Sets N                                                     (addi $a0, $zero, N)
--               "00100000000001010000000000001100" when X"00000004",   --Sets D                                                     (addi $a1, $zero, D)
               
              --  -- N = 5, D = 12
--                "00100000000001000000000000000101" when X"00000000",   --Sets N                                                     (addi $a0, $zero, N)
--                "00100000000001010000000000001100" when X"00000004",   --Sets D                                                     (addi $a1, $zero, D)
                                             
--                "00100000000000100000000000000000" when X"00000008",   --Sets Q                                                     (addi $v0, $zero, 0)
--                "00100000100000110000000000000000" when X"0000000c",   --Sets R                                                     (addi $v1, $a0, 0)
--                "00100000000010010000000000000001" when X"00000010",  --Sets temp to 1 which is then used to compare                (addi $t1, $zero, 1)
--                "00000000011001010100000000101010" when X"00000014",  --If R < D then set $t0 to 1, else 0                          (slt $t0, $v1, $a1)
--                "00010001000010010000000000000011" when X"00000018",  --If $t0 = $t1 advance_pc(offset << 2), else advance_pc(4).   (beq $t0, $v1, done)
--                "00100000010000100000000000000001" when X"0000001c",  --Q = Q + 1                                                   (addi $v0, $v0, 1)                                                           
--                "00000000011001010001100000100010" when X"00000020",  --R = R - D                                                   (sub $v1, $v1, $a1)
--                "00001000000000000000000000000101" when X"00000024",  --Jumps back to while(target << 2)
    
                "11111100001000000000000000000001" when others;

                            
end behav;