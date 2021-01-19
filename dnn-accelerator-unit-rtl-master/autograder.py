import subprocess
import sys
import inspect 

CRED = '\033[91m'
CGREEN  = '\33[32m'
CEND = '\033[0m'

def run_process(call_arr):
    process = subprocess.run(call_arr, 
                         stdout=subprocess.PIPE, 
                         universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "Error" in process.stdout or process.returncode != 0:
        print(CRED + "Test failed to compile\n" + CEND)
        return 0

    process = subprocess.run(['./simv'], 
                        stdout=subprocess.PIPE, 
                        universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "Failed" in process.stdout or "failed" in process.stdout or "Error" in process.stdout or "error" in process.stdout:
        print(CRED + "Test failed\n" + CEND)
        return 0
    elif "Time: 0 ps" in process.stdout:
        print(CRED + "Test not implemented\n" + CEND)
        return 0
    else:
        print(CGREEN + "Test passed!\n" + CEND)
        return 1

def test_conv_gold_test():
    print("Running conv_gold_test")
    process = subprocess.run(['make', 'compile_c'], 
                         stdout=subprocess.PIPE, 
                         universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "Error" in process.stdout or process.returncode != 0:
        print(CRED + "Test failed to compile\n" + CEND)
        return 0

    process = subprocess.run(['make', 'run_c'], 
                        stdout=subprocess.PIPE, 
                        universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "Error! Output does not match gold" in process.stdout:
        print(CRED + "Test failed\n" + CEND)
        return 0
    else:
        print(CGREEN + "Test passed!\n" + CEND)
        return 1

def test_conv_gold_tiled_test():
    print("Running conv_gold_tiled_test")
    process = subprocess.run(['make', 'compile_tiled_c'], 
                         stdout=subprocess.PIPE, 
                         universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "Error" in process.stdout or process.returncode != 0:
        print(CRED + "Test failed to compile\n" + CEND)
        return 0

    process = subprocess.run(['make', 'run_tiled_c'], 
                        stdout=subprocess.PIPE, 
                        universal_newlines=True)

    if (verbose):
        print(process.stdout)

    if "***ERROR***" in process.stdout:
        print(CRED + "Test failed\n" + CEND)
        return 0
    else:
        print(CGREEN + "Test passed!\n" + CEND)
        return 1

def test_mac_tb():
    print("Running test_mac_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/mac_tb.v', 'verilog/mac.v'])          

def test_mac_tb_uvm():
    print("Running test_mac_tb_uvm")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/mac_tb_uvm.v', 'verilog/mac.v'])          

def test_skew_registers_tb():
    print("Running test_skew_registers_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/skew_registers_tb.v', 'verilog/skew_registers.v'])

def test_fifo_tb_uvm():
    print("Running test_fifo_tb_uvm")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/fifo_tb_uvm.v', 'verilog/fifo.v', 'verilog/SizedFIFO.v'])

def test_fifo_tb():
    print("Running test_fifo_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/fifo_tb.v', 'verilog/fifo.v', 'verilog/SizedFIFO.v'])

def test_ram_sync_1r1w_tb_uvm():
    print("Running test_ram_sync_1r1w_tb_uvm")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/ram_sync_1r1w_tb_uvm.v', 'verilog/ram_sync_1r1w.v'])

def test_aggregator_tb():
    print("Running test_aggregator_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/aggregator_tb.v', 'verilog/aggregator.v', 'verilog/fifo.v', 'verilog/SizedFIFO.v'])

def test_adr_gen_sequential_tb():
    print("Running test_adr_gen_sequential_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/adr_gen_sequential_tb.v', 'verilog/adr_gen_sequential.v'])

def test_adr_gen_sequential_tb_uvm():
    print("Running test_adr_gen_sequential_tb_uvm")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/adr_gen_sequential_tb_uvm.v', 'verilog/adr_gen_sequential.v'])

def test_ifmap_radr_gen_tb():
    print("Running test_ifmap_radr_gen_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/ifmap_radr_gen_tb.v', 'verilog/ifmap_radr_gen.v'])

def test_systolic_array_with_skew_tb():
    print("Running test_systolic_array_with_skew_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/systolic_array_with_skew_tb.v', 'verilog/systolic_array_with_skew.v', 'verilog/skew_registers.v', 'verilog/systolic_array.v', 'verilog/mac.v'])

def test_deaggregator_tb():
    print("Running test_deaggregator_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/deaggregator_tb.v', 'verilog/deaggregator.v', 'verilog/fifo.v', 'verilog/SizedFIFO.v'])

def test_double_buffer_tb():
    print("Running test_double_buffer_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/double_buffer_tb.v', 'verilog/double_buffer.v', 'verilog/ram_sync_1r1w.v'])

def test_accumulation_buffer_tb():
    print("Running test_accumulation_buffer_tb")
    return run_process(['vcs', '-full64', '-sverilog', '-timescale=1ns/1ps', '-debug_access+pp', 'tests/accumulation_buffer_tb.v', 'verilog/accumulation_buffer.v', 'verilog/ram_sync_1r1w.v'])


args = sys.argv
args_len = len(sys.argv)

verbose = "-v" in args

if "-v" in args: 
    num_tests = args_len - 2
else:
    num_tests = args_len - 1

all_tests = [obj for name,obj in inspect.getmembers(sys.modules[__name__]) 
                        if (inspect.isfunction(obj) and 
                            name.startswith('test') and
                            obj.__module__ == __name__)]

tests = []

if "list" in args:
    tests_names = [test.__name__ for test in all_tests]
    print(tests_names)
    exit()

if num_tests == 0 or "all" in args:
    tests = all_tests
else:
    for arg in args[1:]:
        if "-v" != arg:
            for test in all_tests:
                if arg in test.__name__:
                    tests.append(test)

tests_names = [test.__name__ for test in tests]

print("Tests being run: ", tests_names)

# process = subprocess.run(['make'], 
#                          stdout=subprocess.PIPE, 
#                          universal_newlines=True)
# if (verbose):
#     print(process.stdout)


tests_run = 0
tests_passed = 0

for test in tests:
    tests_run += 1
    tests_passed += test()

print("Tests passed:", tests_passed)
print("Tests run:", tests_run)
