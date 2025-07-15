--full P4 adder
Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.math_real.All;

Entity p4_adder Is
	Generic (
		N_BIT : Integer := 32;
		N_BPB : Integer := 4); --number of bits per block 
	Port (
		a : In Std_logic_vector(N_BIT - 1 Downto 0);
		b : In Std_logic_vector(N_BIT - 1 Downto 0);
		c_in : In Std_logic;
		c_out : Out Std_logic;
		sum : Out Std_logic_vector(N_BIT - 1 Downto 0));
End p4_adder;

Architecture structural Of p4_adder Is

	Signal c_out_cg : Std_logic_vector((N_BIT/N_BPB) - 1 Downto 0);
	Signal c_prop : Std_logic_vector((N_BIT/N_BPB) - 1 Downto 0);
	Signal b_tmp : Std_logic_vector(N_BIT - 1 Downto 0);

	Component cg Is
		Generic (
			NBIT : Integer := 32;
			RADIX : Integer := 4);
		Port (
			a : In Std_logic_vector(NBIT - 1 Downto 0);
			b : In Std_logic_vector(NBIT - 1 Downto 0);
			c_in : In Std_logic;
			c_out : Out Std_logic_vector((NBIT/RADIX) - 1 Downto 0));
	End Component;

	Component iv_n Is
		Generic (NBIT : Integer := 32);
		Port (
			A : In Std_logic_vector(NBIT - 1 Downto 0);
			c_in : In Std_logic;
			Y : Out Std_logic_vector(NBIT - 1 Downto 0));
	End Component;

	Component SUM_GENERATOR Is
		Generic (
			NBIT_PER_BLOCK : Integer := 4;
			NBLOCKS : Integer := 8);
		Port (
			A : In Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0);
			B : In Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0);
			Ci : In Std_logic_vector(NBLOCKS - 1 Downto 0);
			S : Out Std_logic_vector(NBIT_PER_BLOCK * NBLOCKS - 1 Downto 0));
	End Component;
Begin
	-- Iv network produces either B or not(B) based on carry in, which distinguishes between sum and sub
	iv_network : iv_n
	Generic Map(NBIT => N_BIT)
	Port Map(
		A => b,
		c_in => c_in,
		Y => b_tmp);

	-- cg instance
	c_gen : cg
	Generic Map(
		NBIT => N_BIT,
		RADIX => N_BPB)
	Port Map(
		a => a,
		b => b_tmp,
		c_in => c_in,
		c_out => c_out_cg);

	-- Wiring carry from CG to GS
	wiring : For i In 0 To (N_BIT/N_BPB) Generate
		if_first : If i = 0 Generate
			c_prop(0) <= c_in;
		End Generate;

		if_others : If ((i /= 0) And (i /= (N_BIT/N_BPB))) Generate
			c_prop(i) <= c_out_cg(i - 1);
		End Generate;

		if_last : If i = (N_BIT/N_BPB) Generate
			c_out <= c_out_cg(i - 1);
		End Generate;
	End Generate wiring;

	-- sg instance
	s_gen : SUM_GENERATOR
	Generic Map(
		NBIT_PER_BLOCK => N_BPB,
		NBLOCKS => N_BIT/N_BPB)
	Port Map(
		A => a,
		B => b_tmp,
		Ci => c_prop,
		S => sum);

End Architecture structural;