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
      // Expected value:
      // If c_in is 0, expected sum = a + b
      // If c_in is 1, expected difference = a + not{b} + 1
      bit [32:0] full_sum = (tr.c_in == 0) ? (tr.a + tr.b + tr.c_in) : (tr.a - tr.b);
      bit [31:0] expected_sum = full_sum[31:0];
      bit expected_c_out = (tr.c_in == 0) ? (full_sum[32]) : ( (tr.a < tr.b) ? 0 : 1);

      if (expected_sum !== tr.sum || expected_c_out !== tr.c_out) begin
         `uvm_error("SCOREBOARD", $sformatf("ERROR: a=%0d, b=%0d, c_in=%0d, expected sum=%0d, got sum=%0d, expected c_out=%0b, got c_out=%0b",
                                             tr.a, tr.b, tr.c_in, expected_sum, tr.sum, expected_c_out, tr.c_out));
      end 
   endfunction

endclass