# UVM based testbench for P4 adder

This repository contains a UVM-based testbench for a P4 adder. The testbench is designed to verify the functionality of a P4-based adder implementation.

## Included Files

- [`src/`](./src/) **- Adder source files**
- [`tb/`](./tb/) **- UVM testbench files**
- [`sim/`](./sim/) **- Simulation macros**
   - [`compile.sh`](./sim/compile.sh) - This script compiles the P4 source files (VHDL) and the UVM testbench. This is to be runned before running the simulation.

## Simulation instructions, without GUI

1. Move into the `sim` directory:
   ```bash
   cd sim
   ```

2. Compile the P4 source files and the UVM testbench:
   ```bash
   ./compile.sh
   ```