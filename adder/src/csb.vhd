Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;

Entity CSB Is
	Generic (N : Integer := 8);
	Port (
		A : In Std_logic_vector(N - 1 Downto 0);
		B : In Std_logic_vector(N - 1 Downto 0);
		Ci : In Std_logic;
		S : Out Std_logic_vector(N - 1 Downto 0));
End CSB;

Architecture STRUCTURAL Of CSB Is
	Constant N_bits : Integer := 4;

	Signal STMP1, STMP2 : Std_logic_vector(N - 1 Downto 0);
	Component RCA
		Generic (NBIT : Integer := 8);
		Port (
			A : In Std_logic_vector(NBIT - 1 Downto 0);
			B : In Std_logic_vector(NBIT - 1 Downto 0);
			Ci : In Std_logic;
			S : Out Std_logic_vector(NBIT - 1 Downto 0);
			Co : Out Std_logic);
	End Component;

Begin

	S <= STMP1 When Ci = '0' Else
		STMP2;
	FAI1 : RCA
	Generic Map(NBIT => N_bits)
	Port Map(A, B, '0', STMP1, Open);

	FAI2 : RCA
	Generic Map(NBIT => N_bits)
	Port Map(A, B, '1', STMP2, Open);
End STRUCTURAL;