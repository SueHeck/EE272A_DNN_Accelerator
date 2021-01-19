generate_layer: cpp/conv_gold.cpp cpp/conv_gold_tiled.cpp cpp/conv_tb.cpp
	g++ -g -std=c++11 cpp/conv_tb.cpp -o conv_tb
	./conv_tb
	mv ifmap_data.txt layers
	mv weight_data.txt layers
	mv ofmap_data.txt layers

debug_conv: run_conv
	dve -full64 -vpd dump.vcd &

run_conv: compile_conv
	./simv

compile_conv: 
	vcs -full64 -sverilog -timescale=1ns/1ps -debug_access+pp tests/conv_tb.v verilog/conv.v verilog/systolic_array_with_skew.v verilog/skew_registers.v verilog/systolic_array.v verilog/mac.v verilog/adr_gen_sequential.v verilog/deaggregator.v verilog/aggregator.v verilog/fifo.v verilog/SizedFIFO.v verilog/conv_controller.v verilog/accumulation_buffer.v verilog/ram_sync_1r1w.v verilog/ifmap_radr_gen.v verilog/double_buffer.v

run_c: compile_c
	./conv_gold

compile_c: cpp/conv_gold.cpp cpp/conv_gold_test.cpp
	g++ -g -std=c++11 cpp/conv_gold_test.cpp -o conv_gold

run_tiled_c: compile_tiled_c
	./conv_gold_tiled

compile_tiled_c: cpp/conv_gold_tiled.cpp cpp/conv_tb.cpp
	g++ -g -std=c++11 cpp/conv_tb.cpp -o conv_gold_tiled
	
clean:
	rm -rf ./conv_gold
	rm -rf ./conv_tb
	rm -rf ./simv
	rm -rf simv.daidir/ 
	rm -rf *.vcd
	rm -rf csrc
	rm -rf ucli.key
	rm -rf vc_hdrs.h
	rm -rf DVEfiles
