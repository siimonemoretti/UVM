# UVM based testbench for P4 adder

This repository contains a UVM-based testbench for a P4 adder. The testbench is designed to verify the functionality of a P4-based adder implementation.

## Included Files

Here's a brief overview of the files and directories in this repository:

- [`src/`](./src/) **- Adder source files**
- [`tb/`](./tb/) **- UVM testbench files**
   - [`driver.sv`](./tb/driver.sv) - Defines the driver class, which is responsible for driving the inputs to the DUT (Device Under Test). Here the interface is declared as virtual because the driver is simply a class and not a module, so it cannot have ports but it needs handles to indirectly access the DUT's signals. 
   - [`environment.sv`](./tb/environment.sv) - contains all the components needed to verify the design, such as the driver, monitor, scoreboard, and sequencer. Then in the `connect_phase` attaches the sequencer to the `seq_item_port` of the driver and the `sb_port` of the scoreboard to the monitor's analysis port.
   - [`interface.sv`](./tb/interface.sv) - Interface between the VHDL adder and SystemVerilog UVM testbench.
   - [`monitor.sv`](./tb/monitor.sv) - Captures transaction from the `virtual interface` and `write`s them to the `analysis port` so that the scoreboard can read them. 
   - [`scoreboard.sv`](./tb/scoreboard.sv) - Has a TLM interface to receive transactions via its `void function write()` method. It compares the received transactions with the expected results and reports any mismatches.
   - [`sequencer.sv`](./tb/sequencer.sv) - extends `uvm_sequencer` and handles the `transaction` type defined in `transaction.sv`. The file is so minimal because UVM already provides most of the sequencer behavior, so it only needs to extend the base class.
   - [`sequence.sv`](./tb/sequence.sv) - defines the class `adder_sequence` which extends `uvm_sequence` and is responsible for generating random input transactions for the adder. 
   - [`tb_top.sv`](./tb/tb_top.sv) - (MODULE) Here the interface and the wrapper are instantiated. Then it sets the virtual interface in the UVM configuration database and runs the test defined in the `test.sv` file.
   - [`test.sv`](./tb/test.sv) - Declares the environment and in the `run_phase`, it creates and starts an adder_sequence (defined in `sequence.sv`) on the environment's sequencer, managing phase objections to control simulation time.
   - [`transaction.sv`](./tb/transaction.sv) - it's a simple class that defines the transaction data structure used in the testbench. It contains five fields: `a`, `b`, `c_in`, `sum`, and `c_out`, which represent the inputs and outputs of the adder. 
   - [`wrapper.sv`](./tb/wrapper.sv) - (MODULE) that simply wraps the VHDL entity with a SV one.
- [`sim/`](./sim/) **- Simulation macros**
   - [`compile.sh`](./sim/compile.sh) - This script compiles the P4 source files (VHDL) and the UVM testbench. This is to be runned before running the simulation.
   - [`run.sh`](./sim/run.sh) - This script runs the simulation also saving code coverage. 
   - [`sim.do`](./sim/sim.do) - This is needed to run the simulation in ModelSim. It is sourced by the `run.sh` script.

## Simulation instructions, without GUI

1. Move into the `sim` directory:
   ```bash
   cd sim
   ```

2. Compile the P4 source files and the UVM testbench:
   ```bash
   ./compile.sh
   ```

3. Run the simulation:
   ```bash
   ./run.sh
   ```