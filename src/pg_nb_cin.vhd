-- Propagate Generate network basic block that considers also the input carry
-- Computes the generate "1:0" signal which considers carry in as g_00

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity pg_nb_cin Is
   Port (
      a_0 : In Std_logic;
      b_0 : In Std_logic;
      c_in : In Std_logic;
      g : Out Std_logic);
End pg_nb_cin;

Architecture Behavioral Of pg_nb_cin Is
Begin
   -- g <= (g_00 and p_11) Or g_11
   g <= (c_in And (a_0 Xor b_0)) Or (a_0 And b_0);
End Behavioral;