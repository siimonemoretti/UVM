-- Propagate & Generate network
Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity pg_n Is
   Generic (
      N : Integer := 8);
   Port (
      a_i : In Std_logic_vector (N - 1 Downto 0);
      b_i : In Std_logic_vector (N - 1 Downto 0);
      c_in : In Std_logic;
      p_o : Out Std_logic_vector (N - 1 Downto 0);
      g_o : Out Std_logic_vector (N - 1 Downto 0));
End pg_n;

Architecture Behavioral Of pg_n Is
   Component pg_nb
      Port (
         a_i : In Std_logic;
         b_i : In Std_logic;
         p : Out Std_logic;
         g : Out Std_logic);
   End Component;

   Component pg_nb_cin
      Port (
         a_0 : In Std_logic;
         b_0 : In Std_logic;
         c_in : In Std_logic;
         g : Out Std_logic);
   End Component;

Begin
   Gen : For i In 0 To N - 1 Generate
      -- First block of the network is slightly different than the others: it has to consider C_in signal.
      first_component : If i = 0 Generate
         pg_nb_cin_inst : pg_nb_cin Port Map(
            a_0 => a_i(i),
            b_0 => b_i(i),
            c_in => c_in,
            g => g_o(i));
      End Generate first_component;

      others_components : If i /= 0 Generate
         pg_nb_inst : pg_nb Port Map(
            a_i => a_i(i),
            b_i => b_i(i),
            p => p_o(i),
            g => g_o(i));
      End Generate others_components;
   End Generate;

End Behavioral;