set projDir "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/vivado"
set projName "HoneyCombs"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/au_top_0.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/alu_1.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/reset_conditioner_2.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/adder16_3.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/shifter16_4.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/and16_5.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/mux4_6.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/full_adder_7.v" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/verilog/mux2_8.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/work/constraint/custom.xdc" "C:/Users/USER/Documents/GitHub/naffins/50.002-HoneyCombs/HoneyCombs/constraint/custom.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
