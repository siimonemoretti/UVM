`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV
`include "uvm_macros.svh"
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"
import uvm_pkg::*;

class env extends uvm_env;
   `uvm_component_utils(env)

   driver drv; // Driver component
   scoreboard sb; // Scoreboard component
   monitor mon; // Monitor component

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Create components
      drv = driver::type_id::create("drv", this);
      sb = scoreboard::type_id::create("sb", this);
      mon = monitor::type_id::create("mon", this);
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Connect the driver to the scoreboard
      mon.ap.connect(sb.sb_port);
   endfunction

endclass  
`endif // ENVIRONMENT_SV