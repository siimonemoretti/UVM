# Same as 'setmentor' command
source /eda/scripts/init_questa_core_prime

# If the "work" directory exists, delete it
if [ -d work ]; then
   echo "Deleting existing 'work' directory..."
   vdel -all
fi
vlib work

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

# Compile the files

# Compile P4 adder files with flag for code coverage collection
VCOM_FLAGS="-cover sbcet"
compile_file "vcom $VCOM_FLAGS" "../src/fa.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/rca.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/csb.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/g.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/pg.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/pg_nb.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/pg_nb_cin.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/pg_n.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/cg.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/sg.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/iv_n.vhd"
compile_file "vcom $VCOM_FLAGS" "../src/p4_adder.vhd"

# Wrapper files with flags for code coverage collection and signal access
VLOG_FLAGS="-cover bcesf +acc"
compile_file "vlog $VLOG_FLAGS" "../tb/wrapper.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/interface.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/transaction.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/driver.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/monitor.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/scoreboard.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/cov_subscriber.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/environment.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/sequence.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/sequencer.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/test.sv"
compile_file "vlog $VLOG_FLAGS" "../tb/tb_top.sv"

echo "✅ All files compiled successfully."