puts "\n########## SIMULATION STARTS ##########\n"

# Save coverage database
coverage save -onexit code_coverage.ucdb
run -all

puts "\n########## SIMULATION ENDS ##########\n"
exit