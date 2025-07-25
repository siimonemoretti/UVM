// Interface between the VHDL adder and SystemVerilog UVM testbench

interface adder_if #(
   parameter N_BIT = 32,
   parameter N_BPB = 4
);

   logic [N_BIT-1:0] adder_a;
   logic [N_BIT-1:0] adder_b;
   logic adder_cin;
   logic adder_cout;
   logic [N_BIT-1:0] adder_sum;

   // Define the adder port
   modport adder_port (
      input  adder_a, adder_b, adder_cin,
      output adder_cout, adder_sum
   );

endinterface