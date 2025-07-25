`ifndef TRANSACTION_SV
`define TRANSACTION_SV
`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   `uvm_object_utils(transaction) // Register the class to the UVM factory

   // Data members
   rand bit [31:0] a, b; // Operands
   rand bit c_in; // Carry-in
   bit c_out; // Carry-out
   bit [31:0] sum; // Result

   // Constructor
   function new(string name = "transaction");
      super.new(name);
   endfunction

   // 
   function void do_print(uvm_printer printer);
      super.do_print(printer);
      printer.print_field("a", a, $bits(a));
      printer.print_field("b", b, $bits(b));
      printer.print_field("c_in", c_in, $bits(c_in));
      printer.print_field("c_out", c_out, $bits(c_out));
      printer.print_field("sum", sum, $bits(sum));
   endfunction
endclass
`endif // TRANSACTION_SV