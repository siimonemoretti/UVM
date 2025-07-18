-- Generic sparse tree carry generator
Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.math_real.All;

Entity cg Is
   Generic (
      NBIT : Integer := 32;
      RADIX : Integer := 4);
   Port (
      a : In Std_logic_vector(NBIT - 1 Downto 0);
      b : In Std_logic_vector(NBIT - 1 Downto 0);
      c_in : In Std_logic;
      c_out : Out Std_logic_vector((NBIT/RADIX) - 1 Downto 0));
End cg;

Architecture structural Of cg Is
   Constant NROWS : Integer := Integer(log2(real(NBIT)));
   -- Defining type and signals
   Type SignalVector Is Array (NROWS Downto 0) Of Std_logic_vector(NBIT - 1 Downto 0);
   Signal G, P : SignalVector := (Others => (Others => '0'));

   -- Import components
   Component pg_n Is
      Generic (
         N : Integer := 16);
      Port (
         a_i : In Std_logic_vector (N - 1 Downto 0);
         b_i : In Std_logic_vector (N - 1 Downto 0);
         c_in : In Std_logic;
         p_o : Out Std_logic_vector (N - 1 Downto 0);
         g_o : Out Std_logic_vector (N - 1 Downto 0));
   End Component;
   -- Propagate & Generate block
   Component block_pg Is
      Port (
         p_i : In Std_logic; -- i is one of the previous stages
         g_i : In Std_logic;
         p_j : In Std_logic; -- j is also one of the previous stages
         g_j : In Std_logic;
         p_out : Out Std_logic;
         g_out : Out Std_logic);
   End Component;
   -- Generate only block
   Component block_g Is
      Port (
         p_i : In Std_logic;
         g_i : In Std_logic;
         g_j : In Std_logic;
         g_out : Out Std_logic);
   End Component;

Begin

   -- Istanciate P&G network
   pg_inst : pg_n
   Generic Map(N => NBIT)
   Port Map(
      a_i => a(NBIT - 1 Downto 0),
      b_i => b(NBIT - 1 Downto 0),
      c_in => c_in,
      p_o => P(0),
      g_o => G(0));

   -- Double nested for loop to generate the structure
   outer_loop : For i In 0 To NROWS - 1 Generate
      inner_loop : For j In 0 To NBIT - 1 Generate
         -- IDEA IS:

         -- There are blocks which are standard and blocks that are there because of the "radix" configuration.
         -- For example, all the PGs and Gs needed to generate/propagate the Carries in 2 ** x positions, are standard.
         -- Those coming from the "radix" are "non standard". Eg: if we have 32 bit in's and Radix = 4, there is one PG and one G in position 28 that would not be there otherwise.

         -- Moreover, the pattern I've noticed is the following: at each line, we can divide the WIDTH (= n° of bits) in sections equal to 2**level.
         -- The "odd" blocks are usually empty, except the case they are in the "mod radix" index, in that case there will be a propagation of P's and G's towards the successive level.
         -- Instead, even blocks follow this pattern: the first one is filled with G blocks and the remaining with PG blocks. 

         -- Goal of this simulation is to check wheter the implemented algorithm is correct.

         -- NOTES:
         -- Sometimes "j" is implied and other times it is "j+1". That is not an error.
         -- J must start from 0 because it helps with the odd/even blocks subdivision. Of course, j could have starded from 1 and when necessary be subtracted 1, but that's just a choice.

         -- "even" blocks are just shifting down values
         even_blocks : If ((j / (2 ** i)) Mod 2 = 0) And ((j + 1) Mod RADIX = 0) Generate
            G(i + 1)(j) <= G(i)(j);
            P(i + 1)(j) <= P(i)(j);
         End Generate even_blocks;

         -- Odd blocks: Special treatment based on first or later "blocks"
         odd_blocks : If ((j / (2 ** i)) Mod 2 /= 0) Generate
            -- First odd block: fill it with G blocks
            first_g_blocks : If (((j / (2 ** i)) = 1) And ((j + 1) Mod RADIX = 0)) Or (((j + 1) < RADIX) And (RADIX Mod (j + 1) = 0)) Generate
               first_G : block_g Port Map(
                  p_i => P(i)(j),
                  g_i => G(i)(j),
                  g_j => G(i)((2 ** i) - 1),
                  g_out => G(i + 1)(j));
            End Generate first_g_blocks;

            -- Other odd blocks: fill them with PG
            other_odd_blocks_pg : If ((j / (2 ** i)) > 1) And (((j + 1) Mod RADIX = 0) Or (i = 0)) Generate
               other_PG : block_pg Port Map(
                  p_i => P(i)(j),
                  g_i => G(i)(j),
                  p_j => P(i)(((j / (2 ** i)) * (2 ** i)) - 1),
                  g_j => G(i)(((j / (2 ** i)) * (2 ** i)) - 1),
                  p_out => P(i + 1)(j),
                  g_out => G(i + 1)(j));
            End Generate other_odd_blocks_pg;

         End Generate odd_blocks;
      End Generate inner_loop;
   End Generate outer_loop;

   -- Assign carry outs
   assign_cout : For i In 0 To (NBIT/RADIX - 1) Generate
      c_out(i) <= G(NROWS)((RADIX * (i + 1)) - 1);
   End Generate assign_cout;
End Architecture structural;