`define IFMAP_WIDTH 16
`define WEIGHT_WIDTH 16
`define OFMAP_WIDTH 32
`define ARRAY_HEIGHT 4
`define ARRAY_WIDTH 4

module systolic_array_with_skew_tb;

  reg clk;
  reg rst_n;
  reg weight_wen_r [`ARRAY_HEIGHT - 1 : 0];
  reg signed [`WEIGHT_WIDTH - 1 : 0] weight_r [`ARRAY_WIDTH - 1 : 0];
  reg weight_en_r;
  reg en_r;
  reg signed [`IFMAP_WIDTH - 1 : 0] ifmap_r [`ARRAY_HEIGHT - 1 : 0];
  reg signed [`OFMAP_WIDTH - 1 : 0] ofmap_in_r [`ARRAY_WIDTH - 1 : 0];
  wire signed [`OFMAP_WIDTH - 1 : 0] ofmap_out_w [`ARRAY_WIDTH - 1 : 0];

  always #10 clk =~clk;
  
  systolic_array_with_skew
  #( 
    .IFMAP_WIDTH(`IFMAP_WIDTH),
    .WEIGHT_WIDTH(`WEIGHT_WIDTH),
    .OFMAP_WIDTH(`OFMAP_WIDTH),
    .ARRAY_HEIGHT(`ARRAY_HEIGHT),
    .ARRAY_WIDTH(`ARRAY_WIDTH)
  ) systolic_array_with_skew_inst (
    .clk(clk),
    .rst_n(rst_n),
    .en(en_r),
    .weight_en(weight_en_r),
    .weight_wen(weight_wen_r),
    .ifmap_in(ifmap_r),
    .weight_in(weight_r),
    .ofmap_in(ofmap_in_r),
    .ofmap_out(ofmap_out_w)
  );

  integer x;
  integer y;

  initial begin
    clk <= 0;
    rst_n <= 1;
    for (y = 0; y < `ARRAY_HEIGHT; y = y + 1) weight_wen_r[y] <= 0;
    weight_en_r <= 0;
    en_r <= 0;
    #20 rst_n <= 0;
    #20 rst_n <= 1;
    weight_en_r <= 1;
    weight_wen_r[0] <= 1;
    weight_wen_r[1] <= 0;
    weight_wen_r[2] <= 0;
    weight_wen_r[3] <= 0;
    weight_r[0] <= 1;
    weight_r[1] <= 2;
    weight_r[2] <= 3;
    weight_r[3] <= 4;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20
    en_r <= 1;
    weight_en_r <= 1;
    weight_wen_r[0] <= 0;
    weight_wen_r[1] <= 1;
    weight_wen_r[2] <= 0;
    weight_wen_r[3] <= 0;
    weight_r[0] <= 5;
    weight_r[1] <= 6;
    weight_r[2] <= 7;
    weight_r[3] <= 8;
    ifmap_r[0] <= 1;
    ifmap_r[1] <= 2;
    ifmap_r[2] <= 3;
    ifmap_r[3] <= 4;
    for (x = 0; x < `ARRAY_WIDTH; x = x + 1) ofmap_in_r[x] <= 0;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    weight_en_r <= 1;
    weight_wen_r[0] <= 0;
    weight_wen_r[1] <= 0;
    weight_wen_r[2] <= 1;
    weight_wen_r[3] <= 0;
    weight_r[0] <= 9;
    weight_r[1] <= 10;
    weight_r[2] <= 11;
    weight_r[3] <= 12;
    ifmap_r[0] <= 5;
    ifmap_r[1] <= 6;
    ifmap_r[2] <= 7;
    ifmap_r[3] <= 8;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20
    weight_en_r <= 1;
    weight_wen_r[0] <= 0;
    weight_wen_r[1] <= 0;
    weight_wen_r[2] <= 0;
    weight_wen_r[3] <= 1;
    weight_r[0] <= 13;
    weight_r[1] <= 14;
    weight_r[2] <= 15;
    weight_r[3] <= 16;
    ifmap_r[0] <= 9;
    ifmap_r[1] <= 10;
    ifmap_r[2] <= 11;
    ifmap_r[3] <= 12;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    weight_en_r <= 1;
    weight_wen_r[0] <= 0;
    weight_wen_r[1] <= 0;
    weight_wen_r[2] <= 0;
    weight_wen_r[3] <= 0;
    ifmap_r[0] <= 13;
    ifmap_r[1] <= 14;
    ifmap_r[2] <= 15;
    ifmap_r[3] <= 16;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    weight_en_r <= 1;
    ifmap_r[0] <= 17;
    ifmap_r[1] <= 18;
    ifmap_r[2] <= 19;
    ifmap_r[3] <= 20;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    weight_en_r <= 1;
    ifmap_r[0] <= 21;
    ifmap_r[1] <= 22;
    ifmap_r[2] <= 23;
    ifmap_r[3] <= 24;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    weight_en_r <= 0;
    ifmap_r[0] <= 25;
    ifmap_r[1] <= 26;
    ifmap_r[2] <= 27;
    ifmap_r[3] <= 28;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    #20 
    ifmap_r[0] <= 29;
    ifmap_r[1] <= 30;
    ifmap_r[2] <= 31;
    ifmap_r[3] <= 32;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    assert(ofmap_out_w[0] == 1*1 + 2*5 + 3* 9 + 4*13);
    assert(ofmap_out_w[1] == 1*2 + 2*6 + 3*10 + 4*14);
    assert(ofmap_out_w[2] == 1*3 + 2*7 + 3*11 + 4*15);
    assert(ofmap_out_w[3] == 1*4 + 2*8 + 3*12 + 4*16);
    #20 
    ifmap_r[0] <= 33;
    ifmap_r[1] <= 34;
    ifmap_r[2] <= 35;
    ifmap_r[3] <= 36;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    assert(ofmap_out_w[0] == 5*1 + 6*5 + 7* 9 + 8*13);
    assert(ofmap_out_w[1] == 5*2 + 6*6 + 7*10 + 8*14);
    assert(ofmap_out_w[2] == 5*3 + 6*7 + 7*11 + 8*15);
    assert(ofmap_out_w[3] == 5*4 + 6*8 + 7*12 + 8*16);
    #20 
    ifmap_r[0] <= 37;
    ifmap_r[1] <= 38;
    ifmap_r[2] <= 39;
    ifmap_r[3] <= 40;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    assert(ofmap_out_w[0] == 9*1 + 10*5 + 11* 9 + 12*13);
    assert(ofmap_out_w[1] == 9*2 + 10*6 + 11*10 + 12*14);
    assert(ofmap_out_w[2] == 9*3 + 10*7 + 11*11 + 12*15);
    assert(ofmap_out_w[3] == 9*4 + 10*8 + 11*12 + 12*16);
    #20 
    ifmap_r[0] <= 41;
    ifmap_r[1] <= 42;
    ifmap_r[2] <= 43;
    ifmap_r[3] <= 44;
    $display("%t: output = %d %d %d %d", $time, ofmap_out_w[0], ofmap_out_w[1], ofmap_out_w[2], ofmap_out_w[3]);
    assert(ofmap_out_w[0] == 13*1 + 14*5 + 15* 9 + 16*13);
    assert(ofmap_out_w[1] == 13*2 + 14*6 + 15*10 + 16*14);
    assert(ofmap_out_w[2] == 13*3 + 14*7 + 15*11 + 16*15);
    assert(ofmap_out_w[3] == 13*4 + 14*8 + 15*12 + 16*16);
    #20
    $display("Test finished!");
  end
 
  initial begin
    $vcdplusfile("dump.vcd");
    $vcdplusmemon();
    $vcdpluson(0, systolic_array_with_skew_tb);
    #20000000;
    $finish(2);
  end

endmodule
