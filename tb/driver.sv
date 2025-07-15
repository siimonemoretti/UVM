// Driver class that drives stimulis to the DUT
// It extends the uvm_driver class and implements the necessary methods
`include "uvm_macros.svh"
`include "transaction.sv"
import uvm_pkg::*;

class driver extends uvm_driver #(transaction);
   `uvm_component_utils(driver)

   // Declare the interface as a virtual interface
   virtual adder_if vif;

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   // Main method to drive the transaction
   virtual task run_phase(uvm_phase phase);
      transaction tr;
      super.run_phase(phase);
      forever begin
         // Wait for a transaction to be available
         seq_item_port.get_next_item(tr);

         // Drive the inputs to the DUT (via the interface)
         vif.adder_a = tr.a;
         vif.adder_b = tr.b;
         vif.adder_cin = tr.c_in;

         #1;

         // Indicate that the item has been processed
         seq_item_port.item_done();
      end
   endtask

endclass