#-----------------------------------------------------------------#
#-          Microelectronic Design | FH Technikum Wien           -#
#-                        COUNTER PROJECT                        -#
#-----------------------------------------------------------------#
#-       Author: Bauer Julian  (el23b071@technikum-wien.at)      -#
#-               Gundacker Max (el23b074@technikum-wien.at)      -#
#-                                                               -#
#-         Date: 24 Jun 2025                                     -#
#-                                                               -#
#-  Design Unit: Counter Unit (ModelSim compile file)            -#
#-                                                               -#
#-     Filename: counter_compile.do                              -#
#-                                                               -#
#-      Version: 1.0                                             -#
#-                                                               -#
#-  Description: The counter unit implements a 4 digit octal     -#
#-               counter running at a frequency of 100Hz.        -#
#-               It is a part of the counter project. This file  -#
#-               compiles the necessary elements for ModelSim.   -#
#-----------------------------------------------------------------#

vcom ../vhdl/counter_.vhd
vcom ../vhdl/counter_rtl.vhd
vcom ../vhdl/counter_rtl_cfg.vhd
vcom ../tb/tb_counter.vhd