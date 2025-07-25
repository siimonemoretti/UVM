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

   // Build phase to set the virtual interface
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Get the virtual interface from the configuration database
      if (!uvm_config_db#(virtual adder_if)::get(this, "", "adder_if_inst", vif)) begin
         `uvm_fatal("DRIVER", "Virtual interface not found in config DB")
      end
   endfunction
   
   // Main method to drive the transaction
   virtual task run_phase(uvm_phase phase);
      transaction tr;
      super.run_phase(phase);

      `uvm_info("DRIVER", "Driver started", UVM_LOW);

      if (vif == null) begin
         `uvm_fatal("DRIVER", "Virtual interface is not set")
      end

      forever begin
         `uvm_info("DRIVER", "Waiting for next item...", UVM_LOW);
         // Wait for a transaction to be available
         seq_item_port.get_next_item(tr);

         `uvm_info("DRIVER", $sformatf("Driving transaction: a=%0d, b=%0d, c_in=%0d", tr.a, tr.b, tr.c_in), UVM_LOW);

         // Drive the inputs to the DUT (via the interface)
         vif.adder_a = tr.a;
         vif.adder_b = tr.b;
         vif.adder_cin = tr.c_in;

         #1;
         
         // Indicate that the item has been processed
         seq_item_port.item_done();
         `uvm_info("DRIVER", "Transaction completed", UVM_LOW);
      end
   endtask

endclass