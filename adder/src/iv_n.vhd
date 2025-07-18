-- Inverter network based on carry input signal: if c_in = 0 then out is equal to input, otherwise output is input negated.
Library IEEE;
Use IEEE.std_logic_1164.All;

Entity iv_n Is
   Generic (NBIT : Integer := 32);
   Port (
      A : In Std_logic_vector(NBIT - 1 Downto 0);
      c_in : In Std_logic;
      Y : Out Std_logic_vector(NBIT - 1 Downto 0));
End iv_n;

Architecture structural Of iv_n Is
Begin
   xor_gen : For i In 0 To NBIT - 1 Generate
      Y(i) <= A(i) Xor c_in;
   End Generate xor_gen;
End structural;