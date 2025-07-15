Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;

Entity SUM_GENERATOR Is
	Generic (
		NBIT_PER_BLOCK : Integer := 4;
		NBLOCKS : Integer := 8);
	Port (
		A : In Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0);
		B : In Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0);
		Ci : In Std_logic_vector(NBLOCKS - 1 Downto 0);
		S : Out Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0));
End SUM_GENERATOR;

Architecture STRUCTURE Of SUM_GENERATOR Is

	Component CSB Is
		Generic (
			DCSBS : Time := 0 ns;
			DCSBC : Time := 0 ns;
			N : Integer := 8);
		Port (
			A : In Std_logic_vector(N - 1 Downto 0);
			B : In Std_logic_vector(N - 1 Downto 0);
			Ci : In Std_logic;
			S : Out Std_logic_vector(N - 1 Downto 0));
	End Component;

Begin
	gen : For i In 0 To NBLOCKS - 1 Generate
		CSB0 : CSB
		Generic Map(
			DCSBS => 0 ns,
			DCSBC => 0 ns,
			N => NBIT_PER_BLOCK)
		Port Map(
			A => A(NBIT_PER_BLOCK * (i + 1) - 1 Downto NBIT_PER_BLOCK * i),
			B => B(NBIT_PER_BLOCK * (i + 1) - 1 Downto NBIT_PER_BLOCK * i),
			Ci => Ci(i),
			S => S(NBIT_PER_BLOCK * (i + 1) - 1 Downto NBIT_PER_BLOCK * i));
	End Generate gen;

End STRUCTURE;