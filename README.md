# UVM based testbench for P4 adder

This repository contains a UVM-based testbench for a P4 adder. The testbench is designed to verify the functionality of a P4-based adder implementation.

## Included Files

Here's a brief overview of the files and directories in this repository:

- [`src/`](./src/) **- Adder source files**
- [`tb/`](./tb/) **- UVM testbench files**
   - [`driver.sv`](./tb/driver.sv) - Defines the driver class, which is responsible for driving the inputs to the DUT (Device Under Test). Here the interface is declared as virtual because the driver is simply a class and not a module, so it cannot have ports but it needs handles to indirectly access the DUT's signals. 
   - [`environment.sv`](./tb/environment.sv) - 
   - [`interface.sv`](./tb/interface.sv) - Interface between the VHDL adder and SystemVerilog UVM testbench.
   - [`monitor.sv`](./tb/monitor.sv) - 
   - [`scoreboard.sv`](./tb/scoreboard.sv) - 
   - [`sequencer.sv`](./tb/sequencer.sv) - 
   - [`sequence.sv`](./tb/sequence.sv) - 
   - [`tb_top.sv`](./tb/tb_top.sv) - (MODULE) Here the interface and the wrapper are instantiated. Then it sets the virtual interface in the UVM configuration database and runs the test defined in the `test.sv` file.
   - [`test.sv`](./tb/test.sv) - 
   - [`transaction.sv`](./tb/transaction.sv) - 
   - [`wrapper.sv`](./tb/wrapper.sv) - (MODULE)
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