vsim -t ns -lib work work.tb_adder  
view *
do adder_wave.do # define signals to display in Wave window  
run 3000 ns
