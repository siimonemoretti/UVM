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


echo "✅ All files compiled successfully."