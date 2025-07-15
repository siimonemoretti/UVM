# Same as 'setmentor' command
source /eda/scripts/init_questa_core_prime

# Function to compile a file with error handling
compile_file() {
   local cmd="$1"
   local file="$2"
   local label="${3:-$file}"

   output=$($cmd "$file" 2>&1)
   if [ $? -ne 0 ]; then
      echo "❌ Error compiling: $label"
      echo "$output"
      exit 1
  fi
}

vdel -all
vlib work

# Compile the files

# P4 Adder files
compile_file "vcom" "../src/fa.vhd"
compile_file "vcom" "../src/rca.vhd"
compile_file "vcom" "../src/csb.vhd"
compile_file "vcom" "../src/g.vhd"
compile_file "vcom" "../src/pg.vhd"
compile_file "vcom" "../src/pg_nb.vhd"
compile_file "vcom" "../src/pg_nb_cin.vhd"
compile_file "vcom" "../src/pg_n.vhd"
compile_file "vcom" "../src/cg.vhd"
compile_file "vcom" "../src/sg.vhd"
compile_file "vcom" "../src/iv_n.vhd"
compile_file "vcom" "../src/p4_adder.vhd"

# Wrapper files
compile_file "vlog" "../tb/wrapper.sv"
compile_file "vlog" "../tb/interface.sv"
compile_file "vlog" "../tb/transaction.sv"
compile_file "vlog" "../tb/driver.sv"
compile_file "vlog" "../tb/monitor.sv"
compile_file "vlog" "../tb/scoreboard.sv"
compile_file "vlog" "../tb/environment.sv"
compile_file "vlog" "../tb/sequence.sv"
compile_file "vlog" "../tb/test.sv"
compile_file "vlog" "../tb/tb_top.sv"

echo "✅ All files compiled successfully."