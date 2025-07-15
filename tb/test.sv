`ifndef TEST_SV
`define TEST_SV
`include "uvm_macros.svh"
`include "sequence.sv"
`include "environment.sv"
import uvm_pkg::*;

class test extends uvm_test;
   `uvm_component_utils(test)

   env environment;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      environment = env::type_id::create("environment", this);
   endfunction

   task run_phase(uvm_phase phase);
      adder_sequence seq = adder_sequence::type_id::create("seq");
      phase.raise_objection(this);
      seq.start(environment.seqr);
      phase.drop_objection(this);
   endtask
endclass

`endif // TEST_SV