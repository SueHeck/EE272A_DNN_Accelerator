`define DATA_WIDTH (4)
`define FIFO_DEPTH (3)
`define COUNTER_WIDTH (1)
`define TEST_LENGTH (15)

interface fifo_if (input bit clk);
  logic rst_n;
  logic [`DATA_WIDTH - 1 : 0] din;
  logic enq;
  logic full_n;
  logic [`DATA_WIDTH - 1 : 0] dout;
  logic deq;
  logic empty_n;
  logic clr;
endinterface

class fifo_item;
  rand bit [`DATA_WIDTH - 1 : 0] data;
endclass;

class driver;
  virtual fifo_if vif;
  mailbox drv_mbx;
  
  task run();
    $display ("T=%0t [Write driver] Starting ...", $time);
    @ (negedge vif.clk);
    forever begin
      if (vif.full_n) begin
        fifo_item transaction;
        drv_mbx.get(transaction);
        vif.enq = 1'b1;
        vif.din = transaction.data;
      end else begin
        vif.enq = 1'b0;
      end
      if (vif.empty_n) begin
        vif.deq = 1'b1;
      end else begin
        vif.deq = 1'b0;
      end
      @ (negedge vif.clk);
    end       
  endtask
endclass

class monitor; 
  virtual fifo_if vif;
  mailbox scb_mbx; // mailbox connected to scoreboard

  task run();
    $display("T=%0t [Read monitor] Starting ...", $time);
    forever begin
      fifo_item transaction = new;

      @ (posedge vif.clk);
      if (vif.deq) begin
        transaction.data = vif.dout;
        scb_mbx.put(transaction);
      end
    end
  endtask
endclass

class scoreboard;
  mailbox scb_mbx;
  int resp_id;
  reg [`DATA_WIDTH - 1 : 0] expected_data;

  task run();
    forever begin
      fifo_item transaction;
      resp_id = 0;
      expected_data = 0;
      while(resp_id < `TEST_LENGTH) begin
        scb_mbx.get(transaction);
        if (transaction.data != expected_data) begin
          $display("T=%0t [Scoreboard] Error! Received = %h, expected = %h", $time, transaction.data, expected_data);
        end else begin
          $display("T=%0t [Scoreboard] Pass! Received = %h, expected = %h", $time, transaction.data, expected_data);
        end
        expected_data = expected_data + 1;
        resp_id = resp_id + 1;
      end
      $finish;
    end
  endtask
endclass

class env;
  driver d0;
  monitor m0;
  scoreboard s0;
  mailbox scb_mbx;
  virtual fifo_if vif;

  function new();
    d0 = new; 
    m0 = new;
    s0 = new;
    scb_mbx = new();
  endfunction

  virtual task run();
    d0.vif = vif;
    m0.vif = vif;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    fork
      s0.run();
      d0.run();
      m0.run();    
    join_any 
    endtask   
endclass    

class test;
  env e0;
  mailbox drv_mbx;
  int stim_id;
  reg [`DATA_WIDTH : 0] test_data;

  function new();
    drv_mbx = new();
    e0 = new();
  endfunction

  virtual task run();
    e0.d0.drv_mbx = drv_mbx;
    fork 
      e0.run();
    join_none

    apply_stim();
  endtask

  virtual task apply_stim();
    fifo_item transaction;
    $display ("T=%0t [Test] Starting write stimulus ...", $time);

    stim_id = 0;
    test_data = 0;
    while(stim_id < `TEST_LENGTH) begin
      transaction = new;
      transaction.data = test_data;
      test_data = test_data + 1;
      stim_id = stim_id + 1;
      drv_mbx.put(transaction);
    end

  endtask
endclass

module fifo_tb;

    reg clk;
    reg rst_n;
    reg clr;

    always #10 clk =~clk;
    
    fifo_if _if (clk);

    fifo #(
      .DATA_WIDTH(`DATA_WIDTH), 
      .FIFO_DEPTH(`FIFO_DEPTH), 
      .COUNTER_WIDTH(`COUNTER_WIDTH)
    ) dut (
      .clk(_if.clk),
      .rst_n(_if.rst_n),
      .din(_if.din),
      .enq(_if.enq),
      .full_n(_if.full_n),
      .dout(_if.dout),
      .deq(_if.deq),
      .empty_n(_if.empty_n),
      .clr(_if.clr)
    );

    assign _if.rst_n = rst_n;
    assign _if.clr = clr;

    initial begin
        test t0;

        clk <= 0;
        rst_n <= 0;
        clr <= 0;
        #40 rst_n <= 1;
        t0 = new(); 
        t0.e0.vif = _if;
        t0.run();
    end

    initial begin
        $vcdplusfile("dump.vcd");
        $vcdplusmemon();
        $vcdpluson(0, fifo_tb);
        #20000000;
        $finish(2);
    end

endmodule
