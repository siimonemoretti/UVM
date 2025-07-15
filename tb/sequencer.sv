`ifndef SEQUENCER_SV
`define SEQUENCER_SV
`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

class sequencer extends uvm_sequencer#(transaction);
   `uvm_component_utils(sequencer)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction //new()

endclass //sequencer extends uvm_sequencer
`endif // SEQUENCER_SV