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
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Get the virtual interface from the configuration database
      if (!uvm_config_db#(virtual adder_if)::get(this, "", "adder_if_inst", vif)) begin
         `uvm_fatal("MONITOR", "Virtual interface not found in config DB")
      end
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
         tr.a = vif.adder_a;
         tr.b = vif.adder_b;
         tr.c_in = vif.adder_cin;

         `uvm_info("MONITOR", $sformatf("Captured transaction: a=%0d, b=%0d, c_in=%0d, sum=%0d, c_out=%0b",
                                         tr.a, tr.b, tr.c_in, tr.sum, tr.c_out), UVM_LOW);

         // Send the transaction to the analysis port
         ap.write(tr);
      end
   endtask

endclass