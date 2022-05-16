# D0011E Lab 3a (4-bit ALU)
The goal of this lab is to implement a 4-bit arithmetic unit and a 4-bit logic unit. The labs should be completed individually, **however cooperation is encouraged.**

All the VHDL code together with this README should be uploaded to GitLab. You can commit the whole Vivado project to facilitate reviewers in their task. The README file include the tables and the answers to the questions. Remember to add images to the zip file you submit to Canvas. Remember when you write test benches to use the **correct naming as defined below or you will have to edit the bash scripts for CI testing**.

## Preparation
Fork this repository and clone your fork as you did for lab 1 and 2.

## Part 0
If you have gotten CI testing to work on your local machine or by connecting to the servers at the university through thinlinc you can skip part 0.

If not, to get CI testing to work on the servers at the university through thinlinc do the following:
1. Log in through thinlinc
2. Search for Vivado, right click and chose "Edit application".
3. Note down the command but **REMOVE THE LAST PART (Vivado)**, you need this later. For me it became `/software/Vivado/2020.2/bin` after removing vivado at the end.
4. Open the terminal and write `echo $0`. Check what shell you are running. There will be two guides below for `tcsh` and `bash`. If you are using something else you need to figure out how to get the path correct. If you want to change the standard shell see [chsh](https://linux.die.net/man/1/chsh) or google.

For `tcsh`:
1. Go to your home folder and make a file called `.cshrc`. If it already exists open it.
2. Add the line `setenv PATH ${PATH}:VIVADO_PATH` where `VIVADO_PATH` is what you noted down earlier. My file looks like `setenv PATH ${PATH}:/software/Vivado/2020.2/bin`.
3. Save the file and restart your shell.
4. Enter `echo $PATH` to check that the vivado path has been added. If it is not in the path go back to step 1.

For `bash`:
1. Go to your home folder and make a file called `.bashrc`. If it already exists open it.
2. Add the line `export PATH="VIVADO_PATH:$PATH"` where `VIVADO_PATH` is what you noted down earlier. My file looks like `export PATH="/software/Vivado/2020.2/bin:$PATH"`.
3. Save the file and restart your shell.
4. Enter `echo $PATH` to check that the vivado path has been added. If it is not in the path go back to step 1.

When the path has been added to your prefered shell you should now be able to run the CI scripts by going to the lab folder in your terminal and typing `./ci_scripts/run.sh`. The test should give you an assert error and print "OH NO". Once you have implemented the components correctly the output should be "OK !!".

## Part 1
Based on the correct design chosen in quiz 1, write VHDL code for

- a one-bit full adder.

```vhdl
entity FULL_ADDER is 
	port(
		A, B, Cin : in std_logic;
		R, Cout   : out std_logic);
end entity;
```

- a 4-bit adder that uses four one-bit full adders as components.

```vhdl
entity ADDER is 
	port(
		A, B : in std_logic_vector(3 downto 0);
		Cin  : in std_logic;
		R    : out std_logic_vector(3 downto 0);
		V, C : out std_logic);
end entity;
```

- a 4-bit addition and subtraction unit that uses a 4-bit adder as a component.

```vhdl
entity ARITH is
	port(
		A, B : in std_logic_vector(3 downto 0);
		Sub  : in std_logic;
		R    : out std_logic_vector(3 downto 0);
		V, C : out std_logic));
end entity;
```

Based on your understanding of how the ARITH component functions, complete the below table. In the table `U` stands for unsigned decimal, `S` for signed decimal. Notice, that any bit vector can be viewed (interpreted) as either a singed or unsigned value. An arithmetic operation on the other hand (as we will see later) assumes an interpretation for the correctness of the result (shown as `U Ok` and `S Ok` in the table). 

|  A   |  B   | Op | R    | U A | U B | U R | U Ok | S A | S B | S R | S Ok | V | C |
|------|------|----|------|-----|-----|-----|------|-----|-----|-----|------|---|---|
| 0100 | 0011 |  + | 0111 |  4  |  3  |  7  |  Yes |  4  |  3  |  7  |  Yes | 0 | 0 |
| 0111 | 0010 |  + | 1001 |  7  |  2  |  9  |  Yes |  7  |  2  | -1  |  No  | 1 | 0 |
| 0111 | 0010 |  - | 0101 |  7  |  2  |  5  |  Yes |  7  |  2  |  5  |  Yes | 0 | 0 |
| 0000 | 1000 |  - | 1000 |  0  |  8  |  8  |  No  |  0  | -0  | -0  |  Yes | 1 | 1 |

Verify your design (=check the outputs R, V, C) by performing manual computations.  
**Question 1:** Are the answers _mathematically_ correct? Can the overflow flag be used to detect errors in _unsigned addition/subtraction_? If not, can the carry flag be used to detect errors?

The answers are mathematically correct except for the second case when it is a signed value and on the last case when the value is unsigned, and yes, we can detect errors by using both the overflow flag and the carry flag when both of them are true.

Verify your design (=check the outputs R, V, C) by performing manual computations.  
**Question 2:** Are the answers _mathematically_ correct? Can the overflow flag be used to detect errors in _signed addition/subtraction_? If not, can the carry flag be used to detect errors?

The answers are mathematically correct except for the second case when it is a signed value and on the last case when the value is unsigned, and yes, we can detect errors using both the overflow flag and the carry flag when the overflow flag is true and the carry flag is false.

Add corresponding tests (assertions) in the test bench to verify that your implementation is correct.

## Part 2
Based on the correct designs chosen in quiz 1, write VHDL code for
- a 4-bit logic unit

```vhdl
entity LOGIC is
	port(
		A, B : in std_logic_vector(3 downto 0);
		Op   : in std_logic_vector(1 downto 0);
		R    : out std_logic_vector(3 downto 0));
end entity;
```

Make sure that the multiplexer is generalized such that it does not contain any of the logical gates you are using. It should only change which input becomes the output depending on `Op`. Feel free to add your own tests to make sure that the implementation is correct.

## Part 3 Upload the Vivado project and the README file. Remember:

- Implementation of the 4-bit arithmetic unit and code.
- Implementation of the 4-bit logic unit and code.
- Update the tables and answer all the questions.
