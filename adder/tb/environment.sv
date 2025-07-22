`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV
`include "uvm_macros.svh"
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"
`include "sequencer.sv"
`include "cov_subscriber.sv"

import uvm_pkg::*;

class env extends uvm_env;
   `uvm_component_utils(env)

   driver drv; // Driver component
   scoreboard sb; // Scoreboard component
   monitor mon; // Monitor component
   sequencer seqr; // Sequencer component
   adder_coverage cov_subscriber; // Coverage subscriber

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Print that the environment is being built
      `uvm_info("ENV", "Building environment", UVM_LOW)
      // Create components
      seqr = sequencer::type_id::create("seqr", this);
      drv = driver::type_id::create("drv", this);
      sb = scoreboard::type_id::create("sb", this);
      mon = monitor::type_id::create("mon", this); 
      cov_subscriber = adder_coverage::type_id::create("cov_subscriber", this);
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Print that the environment is connecting components
      `uvm_info("ENV", "Connecting driver and sequencer ports", UVM_LOW)

      // Connect the driver to the sequencer
      drv.seq_item_port.connect(seqr.seq_item_export);
      
      // Connect the driver to the scoreboard
      mon.ap.connect(sb.sb_port);

      // Connect agent to subscriber's analysis port
      mon.ap.connect(cov_subscriber.analysis_export);
   endfunction

endclass

`endif // ENVIRONMENT_SV