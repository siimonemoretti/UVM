`ifndef TB_TOP_SV
`define TB_TOP_SV
`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;

   parameter N_BIT = 32;
   parameter N_BPB = 4;

   adder_if #(
      .N_BIT(N_BIT),
      .N_BPB(N_BPB)
   ) adder_if_inst();

   adder_wrap #(
      .N_BIT(N_BIT),
      .N_BPB(N_BPB)
   ) adder_wrap_inst (
      .adder_if(adder_if_inst)
   );

   initial begin 
      uvm_config_db#(virtual adder_if)::set(null, "*", "adder_if_inst", adder_if_inst);
      run_test("test");
   end
endmodule

`endif // TB_TOP_SV