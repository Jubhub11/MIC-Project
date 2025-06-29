#-----------------------------------------------------------------#
#-          Microelectronic Design | FH Technikum Wien           -#
#-                        COUNTER PROJECT                        -#
#-----------------------------------------------------------------#
#-       Author: Bauer Julian  (el23b071@technikum-wien.at)      -#
#-               Gundacker Max (el23b074@technikum-wien.at)      -#
#-                                                               -#
#-         Date: 24 Jun 2025                                     -#
#-                                                               -#
#-  Design Unit: Counter Unit (ModelSim simulation file)         -#
#-                                                               -#
#-     Filename: counter_sim.do                                  -#
#-                                                               -#
#-      Version: 1.0                                             -#
#-                                                               -#
#-  Description: The counter unit implements a 4 digit decimal   -#
#-               counter running at a frequency of 10hz.         -#
#-               It is a part of the counter project. This file  -#
#-               launches the simulation in ModelSim.            -#
#-----------------------------------------------------------------#

vsim -t ns -lib work work.tb_counter  
view *
do counter_wave.do # define signals to display in Wave window  
run 10 sec
