-- Propagate Generate network basic block
-- Computes the propagate and generate signals for the first stage of the Carry generator as p = a_i XOR b_i and g = a_i AND b_i

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity pg_nb Is
   Port (
      a_i : In Std_logic;
      b_i : In Std_logic;
      p : Out Std_logic;
      g : Out Std_logic);
End pg_nb;

Architecture Behavioral Of pg_nb Is
Begin
   p <= a_i Xor b_i;
   g <= a_i And b_i;
End Behavioral;