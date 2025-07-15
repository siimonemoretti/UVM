-- Propagate & Generate block necessary for the sparse tree carry look-ahead adder
Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity block_pg Is
   Port (
      p_i : In Std_logic; -- i is one of the previous stages
      g_i : In Std_logic;
      p_j : In Std_logic; -- j is also one of the previous stages
      g_j : In Std_logic;
      p_out : Out Std_logic;
      g_out : Out Std_logic);
End block_pg;

Architecture Behavioral Of block_pg Is
Begin
   p_out <= p_i And p_j;
   g_out <= g_i Or (p_i And g_j);
End Behavioral;