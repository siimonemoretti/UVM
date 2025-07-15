`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)

   // Declare the analysis port
   uvm_analysis_imp#(transaction, scoreboard) sb_port;

   function new(string name, uvm_component parent);
      super.new(name, parent);
      sb_port = new("sb_port", this);
   endfunction

   function void write(transaction tr);
      bit [32:0] expected = tr.a + tr.b + tr.c_in;

      if (expected[31:0] !== tr.sum || expected[32] !== tr.c_out) begin
         `uvm_error("scoreboard", $sformatf("Mismatch: Expected sum = %0h, c_out = %0b; Got sum = %0h, c_out = %0b",
                                             expected[31:0], expected[32], tr.sum, tr.c_out));
      end else begin
         `uvm_info("scoreboard", $sformatf("Match: a = %0h, b = %0h, c_in = %0b, sum = %0h, c_out = %0b",
                                            tr.a, tr.b, tr.c_in, tr.sum, tr.c_out), UVM_MEDIUM);
      end
   endfunction

endclass