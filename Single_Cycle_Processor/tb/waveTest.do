onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /soc_ez_tb/sc_cpu_inst/clk
add wave -noupdate /soc_ez_tb/sc_cpu_inst/sys_rst_n
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/rom_addr
add wave -noupdate -radix binary /soc_ez_tb/sc_cpu_inst/rom_rdata
add wave -noupdate /soc_ez_tb/sc_cpu_inst/rom_rdy
add wave -noupdate -radix decimal /soc_ez_tb/sc_cpu_inst/mem_rdata
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/mem_addr
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/mem_wdata
add wave -noupdate /soc_ez_tb/sc_cpu_inst/mem_we
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/instr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/zero
add wave -noupdate /soc_ez_tb/sc_cpu_inst/pcSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/resultSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/mem_w
add wave -noupdate /soc_ez_tb/sc_cpu_inst/aluCtr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/comCtr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/aluSrc
add wave -noupdate -radix binary -childformat {{{/soc_ez_tb/sc_cpu_inst/immSrc[2]} -radix binary} {{/soc_ez_tb/sc_cpu_inst/immSrc[1]} -radix binary} {{/soc_ez_tb/sc_cpu_inst/immSrc[0]} -radix binary}} -subitemconfig {{/soc_ez_tb/sc_cpu_inst/immSrc[2]} {-height 15 -radix binary} {/soc_ez_tb/sc_cpu_inst/immSrc[1]} {-height 15 -radix binary} {/soc_ez_tb/sc_cpu_inst/immSrc[0]} {-height 15 -radix binary}} /soc_ez_tb/sc_cpu_inst/immSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/reg_w
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/immExt
add wave -noupdate -radix hexadecimal -childformat {{{/soc_ez_tb/sc_cpu_inst/srcA[31]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[30]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[29]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[28]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[27]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[26]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[25]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[24]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[23]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[22]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[21]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[20]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[19]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[18]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[17]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[16]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[15]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[14]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[13]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[12]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[11]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[10]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[9]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[8]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[7]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[6]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[5]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[4]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[3]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[2]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[1]} -radix hexadecimal} {{/soc_ez_tb/sc_cpu_inst/srcA[0]} -radix hexadecimal}} -subitemconfig {{/soc_ez_tb/sc_cpu_inst/srcA[31]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[30]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[29]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[28]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[27]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[26]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[25]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[24]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[23]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[22]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[21]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[20]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[19]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[18]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[17]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[16]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[15]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[14]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[13]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[12]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[11]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[10]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[9]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[8]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[7]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[6]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[5]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[4]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[3]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[2]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[1]} {-height 15 -radix hexadecimal} {/soc_ez_tb/sc_cpu_inst/srcA[0]} {-height 15 -radix hexadecimal}} /soc_ez_tb/sc_cpu_inst/srcA
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/srcB
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/aluRes
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/pc
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/pcPlus4
add wave -noupdate /soc_ez_tb/sc_cpu_inst/rd2
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/wd
add wave -noupdate -radix unsigned /soc_ez_tb/sc_cpu_inst/a1
add wave -noupdate -radix unsigned /soc_ez_tb/sc_cpu_inst/a2
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/a3
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/result
add wave -noupdate -radix hexadecimal /soc_ez_tb/sc_cpu_inst/ctrl_dut/instr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/zero
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/pcSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/resultSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/mem_w
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/aluCtr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/comCtr
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/aluSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/immSrc
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/reg_w
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/op
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/funct3
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/funct7
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/jump
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/branch
add wave -noupdate /soc_ez_tb/sc_cpu_inst/ctrl_dut/aluOp
add wave -noupdate -format Analog-Step -height 74 -max 17.0 /soc_ez_tb/IO_inst/led
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {77036 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 213
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {77026 ns} {77214 ns}
