`define IFMAP_WIDTH 16
`define WEIGHT_WIDTH 16
`define OFMAP_WIDTH 32

module mac_tb;

  reg clk;
  reg rst_n;
  reg weight_en_r;
  reg signed [`WEIGHT_WIDTH - 1 : 0] weight_r;
  reg en_r;
  reg signed [`IFMAP_WIDTH - 1 : 0] ifmap_r;
  reg signed [`OFMAP_WIDTH - 1 : 0] ofmap_r;
  wire signed [`IFMAP_WIDTH - 1 : 0] ifmap_out_w;
  wire signed [`OFMAP_WIDTH - 1 : 0] ofmap_out_w;

  always #10 clk =~clk;
   
  mac #( 
    .IFMAP_WIDTH(16),
    .WEIGHT_WIDTH(16),
    .OFMAP_WIDTH(32)
  ) mac_inst (
    .clk(clk),
    .rst_n(rst_n),
    .en(en_r),
    .weight_wen(weight_en_r),
    .ifmap_in(ifmap_r),
    .weight_in(weight_r),
    .ofmap_in(ofmap_r),
    .ifmap_out(ifmap_out_w),
    .ofmap_out(ofmap_out_w)
  );
  
  initial begin
    clk <= 0;
    rst_n <= 1;
    weight_en_r <= 0;
    en_r <= 0;
    #20 rst_n <= 0;
    #20 rst_n <= 1;
    weight_en_r <= 1;
    weight_r <= -5; 
    #20 weight_en_r <= 0;
    en_r <= 1;
    ifmap_r <= 12;
    ofmap_r <= -7;
    #20 
    ifmap_r <= 3;
    ofmap_r <= 16;
    $display("ifmap_out_w = %d", ifmap_out_w); assert(ifmap_out_w == 12);
    $display("ofmap_out_w = %d", ofmap_out_w); assert(ofmap_out_w == -67);
    #20 en_r <= 0;
    $display("ifmap_out_w = %d", ifmap_out_w); assert(ifmap_out_w == 3);
    $display("ofmap_out_w = %d", ofmap_out_w); assert(ofmap_out_w == 1);
    #20
    $display("ifmap_out_w = %d", ifmap_out_w); assert(ifmap_out_w == 3);
    $display("ofmap_out_w = %d", ofmap_out_w); assert(ofmap_out_w == 1);
    #20
    $display("Test finished!");
  end
  
  initial begin
    $vcdplusfile("dump.vcd");
    $vcdplusmemon();
    $vcdpluson(0, mac_tb);
    #20000000;
    $finish(2);
  end

endmodule
