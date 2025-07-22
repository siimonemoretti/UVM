// Simple class "coverage" to measure the functional coverage of the adder
// With methods to monitor the DUT and sample coverage

`ifndef COVERAGE_SUBSCRIBER_SV
`define COVERAGE_SUBSCRIBER_SV
`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

class adder_coverage extends uvm_subscriber #(transaction);
   `uvm_component_utils(adder_coverage)

   bit [31:0] a, b; // Operands
   bit c_in; // Carry-in

   // Covergroup to measure functional coverage
   covergroup adder_cg;
      // Coverpoint for adder inputs
      a_cp : coverpoint a {
         bins corner[] = {0, (1<<32)-1, (1<<32-1)-1};
         bins other = default;
      }
      b_cp : coverpoint b {
         bins corner[] = {0, (1<<32)-1, (1<<32-1)-1};
         bins other = default;
      }
      c_in_cp : coverpoint c_in {
         bins corner[] = {0, 1};
         bins other = default;
      }
      // Cross coverage for inputs
      ab_cin_cp : cross a_cp, b_cp, c_in_cp;
   endgroup

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
      // Create the coverage group
      adder_cg = new();
   endfunction

   function void write(transaction t);
      a = t.a;
      b = t.b;
      c_in = t.c_in;
      adder_cg.sample();
   endfunction
endclass
`endif // COVERAGE_SUBSCRIBER_SV