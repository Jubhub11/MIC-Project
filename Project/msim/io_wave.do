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
add wave -noupdate -format logic /tb_io_ctrl/clk_i    
add wave -noupdate -format logic /tb_io_ctrl/i_io_ctrl/s_1khzclk
add wave -noupdate -format logic /tb_io_ctrl/reset_i   
add wave -noupdate -format logic /tb_io_ctrl/LED_i    
add wave -noupdate -format logic /tb_io_ctrl/LED_o    
add wave -noupdate -format logic /tb_io_ctrl/SW_i     
add wave -noupdate -format logic /tb_io_ctrl/swsync_o 
add wave -noupdate -format logic /tb_io_ctrl/BTNL_i
add wave -noupdate -format logic /tb_io_ctrl/BTNR_i
add wave -noupdate -format logic /tb_io_ctrl/BTNU_i
add wave -noupdate -format logic /tb_io_ctrl/BTND_i
add wave -noupdate -format logic /tb_io_ctrl/pbsync_o
add wave -noupdate -format logic /tb_io_ctrl/cntr0_i
add wave -noupdate -format logic /tb_io_ctrl/cntr1_i
add wave -noupdate -format logic /tb_io_ctrl/cntr2_i
add wave -noupdate -format logic /tb_io_ctrl/cntr3_i
add wave -noupdate -format logic /tb_io_ctrl/ss_sel_o 
add wave -noupdate -format logic /tb_io_ctrl/ss_o     
