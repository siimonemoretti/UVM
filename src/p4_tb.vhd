Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;
Use ieee.numeric_std.All;

Entity p4_tb Is
End p4_tb;

Architecture TEST Of p4_tb Is
	Constant N_BIT : Integer := 32;
	-- Sum signal declaration
	Signal S : Std_logic_vector(N_BIT - 1 Downto 0);
	Signal A : Std_logic_vector(N_BIT - 1 Downto 0);
	Signal B : Std_logic_vector(N_BIT - 1 Downto 0);
	Signal C_in : Std_logic;
	Signal C_out : Std_logic;

	Component p4_adder Is
		Generic (
			N_BIT : Integer := N_BIT;
			N_BPB : Integer := 4);
		Port (
			a : In Std_logic_vector(N_BIT - 1 Downto 0);
			b : In Std_logic_vector(N_BIT - 1 Downto 0);
			c_in : In Std_logic;
			c_out : Out Std_logic;
			sum : Out Std_logic_vector(N_BIT - 1 Downto 0));
	End Component;

Begin

	-- Instantiate p4 adder
	gen : p4_adder
	Generic Map(
		N_BIT => 32,
		N_BPB => 4)
	Port Map(
		a => A,
		b => B,
		c_in => C_in,
		c_out => C_out,
		sum => S);

	-- Testbench
	Process
	Begin
		A <= Std_logic_vector(To_unsigned(100000, 32));
		B <= Std_logic_vector(To_unsigned(50000, 32));
		c_in <= '0';
		Wait For 10 ns;
		A <= Std_logic_vector(To_unsigned(1234, 32));
		B <= Std_logic_vector(To_unsigned(72000, 32));
		c_in <= '0';
		Wait For 10 ns;
		A <= Std_logic_vector(To_unsigned(150000, 32));
		B <= Std_logic_vector(To_unsigned(75000, 32));
		c_in <= '1';
		Wait For 10 ns;
		A <= Std_logic_vector(To_unsigned(50000, 32));
		B <= Std_logic_vector(To_unsigned(75000, 32));
		c_in <= '1';
		Wait For 10 ns;
		A <= (others => '1');
		B <= (others => '0');
		B(0) <= '1'; 
		c_in <= '0';
		Wait For 10 ns;
	End Process;
End TEST;