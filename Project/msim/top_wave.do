#-----------------------------------------------------------------#
#-          Microelectronic Design | FH Technikum Wien           -#
#-                        COUNTER PROJECT                        -#
#-----------------------------------------------------------------#
#-       Author: Bauer Julian  (el23b071@technikum-wien.at)      -#
#-               Gundacker Max (el23b074@technikum-wien.at)      -#
#-                                                               -#
#-         Date: 24 Jun 2025                                     -#
#-                                                               -#
#-  Design Unit: Counter Unit (ModelSim wave file)               -#
#-                                                               -#
#-     Filename: counter_wave.do                                 -#
#-                                                               -#
#-      Version: 1.0                                             -#
#-                                                               -#
#-  Description: The counter unit implements a 4 digit decimal   -#
#-               counter running at a frequency of 10hz.         -#
#-               It is a part of the counter project. This file  -#
#-               adds the relevant waves in ModelSim.            -#
#-----------------------------------------------------------------#

onerror {resume}
add wave -noupdate -format logic /tb_cntr_top/clk_i    
add wave -noupdate -format logic /tb_cntr_top/reset_i    
add wave -noupdate -format logic /tb_cntr_top/sw_i      
add wave -noupdate -format logic /tb_cntr_top/LED_o  
add wave -noupdate -format logic /tb_cntr_top/ss_sel_o 
add wave -noupdate -format logic /tb_cntr_top/ss_o     