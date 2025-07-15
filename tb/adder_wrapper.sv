/*
 * file: adder_wrapper.sv
 * description: This module wraps the VHDL adder module to provide a SystemVerilog interface.
 */

/*
 * Entity p4_adder Is
 * Generic (
 * 	N_BIT : Integer := 32;
 * 	N_BPB : Integer := 4); --number of bits per block 
 * Port (
 * 	a : In Std_logic_vector(N_BIT - 1 Downto 0);
 * 	b : In Std_logic_vector(N_BIT - 1 Downto 0);
 * 	c_in : In Std_logic;
 * 	c_out : Out Std_logic;
 * 	sum : Out Std_logic_vector(N_BIT - 1 Downto 0));
 * End p4_adder;
*/

module adder_wrap #(
   parameter N_BIT = 32,
   parameter N_BPB = 4
) (
   adder_if.adder_port p
);

   adder #(
      .N_BIT(N_BIT),
      .N_BPB(N_BPB)
   ) adder_inst ( 
      .A      (p.adder_a),
      .B      (p.adder_b),
      .CIN    (p.adder_cin),
      .COUT   (p.adder_cout),
      .SUM    (p.adder_sum)
   );

endmodule