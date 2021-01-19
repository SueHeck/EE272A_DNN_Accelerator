`define DATA_WIDTH 16
`define N 4

module skew_registers_tb;

  reg clk;
  reg rst_n;
  reg en_r;
  reg signed [`DATA_WIDTH - 1 : 0] din_r [`N - 1 : 0];
  wire signed [`DATA_WIDTH - 1 : 0] dout_w [`N - 1 : 0];

  always #10 clk =~clk;
  
  skew_registers
  #(
    .DATA_WIDTH(`DATA_WIDTH),
    .N(`N)
  ) skew_resgiters_inst (
    .clk(clk),
    .rst_n(rst_n),
    .en(en_r),
    .din(din_r),
    .dout(dout_w)
  );

  integer y;

  initial begin
    clk <= 0;
    rst_n <= 1;
    en_r <= 0;
    #20 rst_n <= 0;
    #20 rst_n <= 1;
    en_r <= 1;
    din_r[0] = 1;
    din_r[1] = 2;
    din_r[2] = 3;
    din_r[3] = 4;
    #20 
    din_r[0] = 2;
    din_r[1] = 3;
    din_r[2] = 4;
    din_r[3] = 5;
    assert(dout_w[1] == 2);
    #20
    din_r[0] = 3;
    din_r[1] = 4;
    din_r[2] = 5;
    din_r[3] = 6;
    assert(dout_w[1] == 3);
    assert(dout_w[2] == 3);
    #20
    din_r[0] = 4;
    din_r[1] = 5;
    din_r[2] = 6;
    din_r[3] = 7;
    assert(dout_w[1] == 4);
    assert(dout_w[2] == 4);
    assert(dout_w[3] == 4);
    #20
    $display("Test finished!");
  end

  initial begin
    $vcdplusfile("dump.vcd");
    $vcdplusmemon();
    $vcdpluson(0, skew_registers_tb);
    #20000000;
    $finish(2);
  end

endmodule 
