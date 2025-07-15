-- Generate block necessary for the sparse tree carry look-ahead adder
Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity block_g Is
   Port (
      p_i : In Std_logic; -- i is one of the previous stages
      g_i : In Std_logic;
      g_j : In Std_logic;
      g_out : Out Std_logic);
End block_g;

Architecture Behavioral Of block_g Is
Begin
   g_out <= g_i Or (p_i And g_j);
End Behavioral;
