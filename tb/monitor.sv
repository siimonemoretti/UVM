`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

// Monitor class
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)

   virtual adder_if vif;
   uvm_analysis_port #(transaction) ap; // Analysis port to send results to the scoreboard

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction
   
   // Main method to monitor the DUT
   task run_phase(uvm_phase phase);
      transaction tr;
      forever begin
         #1;
         // Capture the outputs from the DUT via the interface
         tr = transaction::type_id::create("tr");
         tr.c_out = vif.adder_cout;
         tr.sum = vif.adder_sum;
         // Send the transaction to the analysis port
         ap.write(tr);
      end
   endtask

endclass