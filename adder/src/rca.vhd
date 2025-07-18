Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;

Entity RCA Is
	Generic (NBIT : Integer := 8);
	Port (
		A : In Std_logic_vector(NBIT - 1 Downto 0);
		B : In Std_logic_vector(NBIT - 1 Downto 0);
		Ci : In Std_logic;
		S : Out Std_logic_vector(NBIT - 1 Downto 0);
		Co : Out Std_logic);
End RCA;

Architecture STRUCTURAL Of RCA Is

	Signal STMP : Std_logic_vector(NBIT - 1 Downto 0);
	Signal CTMP : Std_logic_vector(NBIT Downto 0);

	Component FA
		Port (
			A : In Std_logic;
			B : In Std_logic;
			Ci : In Std_logic;
			S : Out Std_logic;
			Co : Out Std_logic);
	End Component;

Begin

	CTMP(0) <= Ci;
	S <= STMP;
	Co <= CTMP(NBIT);

	ADDER1 : For I In 1 To NBIT Generate
		FAI : FA
		Port Map(A(I - 1), B(I - 1), CTMP(I - 1), STMP(I - 1), CTMP(I));
	End Generate;

End STRUCTURAL;