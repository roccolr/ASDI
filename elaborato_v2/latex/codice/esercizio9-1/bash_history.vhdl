vim ./src/main/mal/ajvm.mal 
vim ./src/main/ajvm/program.ajvm
vim ./src/test/vhdl/processor_tb.vhdl
cmake --build build --target create_control_store
cmake --build build --target create_ram
cmake --build build --target check

Test project /home/jsorel/esercitazione_mic/amic-0/build
    Start 1: src.test.vhdl.alu_tb
1/4 Test #1: src.test.vhdl.alu_tb .............   Passed    0.01 sec
    Start 2: src.test.vhdl.control_unit_tb
2/4 Test #2: src.test.vhdl.control_unit_tb ....   Passed    0.01 sec
    Start 3: src.test.vhdl.datapath_tb
3/4 Test #3: src.test.vhdl.datapath_tb ........   Passed    0.01 sec
    Start 4: src.test.vhdl.processor_tb
4/4 Test #4: src.test.vhdl.processor_tb .......   Passed    0.02 sec

100% tests passed, 0 tests failed out of 4

Total Test time (real) =   0.05 sec
Built target check