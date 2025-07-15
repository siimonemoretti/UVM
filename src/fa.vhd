Library ieee;
Use ieee.std_logic_1164.All;

Entity FA Is
	Generic (
		DFAS : Time := 0 ns;
		DFAC : Time := 0 ns);
	Port (
		A : In Std_logic;
		B : In Std_logic;
		Ci : In Std_logic;
		S : Out Std_logic;
		Co : Out Std_logic);
End FA;

Architecture BEHAVIORAL Of FA Is

Begin

	S <= A Xor B Xor Ci After DFAS;
	Co <= (A And B) Or (B And Ci) Or (A And Ci) After DFAC;
	-- Co <= (A and B) or (B and Ci) or (A and Ci);

End BEHAVIORAL;