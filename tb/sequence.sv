`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

class adder_sequence extends uvm_sequence#(transaction);
   `uvm_object_utils(adder_sequence)

   function new(string name = "adder_sequence");
      super.new(name);
   endfunction

   task body();
      transaction tr;
      repeat (10) begin
         tr = transaction::type_id::create("tr");
         assert(tr.randomize());
         start_item(tr);
         finish_item(tr);
      end
   endtask

endclass
`endif // SEQUENCE_SV