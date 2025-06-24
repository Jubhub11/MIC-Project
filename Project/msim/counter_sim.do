vsim -t ns -lib work work.tb_counter  
view *
do counter_wave.do # define signals to display in Wave window  
run 7 sec
