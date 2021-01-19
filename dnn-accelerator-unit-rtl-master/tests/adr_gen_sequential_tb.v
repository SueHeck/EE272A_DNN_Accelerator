`define BANK_ADDR_WIDTH 8

module adr_gen_sequential_tb;

  reg clk;
  reg rst_n;
  reg config_en;
  reg [`BANK_ADDR_WIDTH - 1 : 0] config_data;
  reg adr_en;
  reg [`BANK_ADDR_WIDTH - 1 : 0] adr;

  always #10 clk =~clk;
   
  adr_gen_sequential #( 
    .BANK_ADDR_WIDTH(8)
  ) adr_gen_sequential_inst (
    .clk(clk),
    .rst_n(rst_n),
    .adr_en(adr_en),
    .adr(adr),
    .config_en(config_en),
    .config_data(config_data)
  );
  
  initial begin
    clk <= 0;
    rst_n <= 1;
    config_en <= 0;
    config_data <= 0;
    adr_en <= 0;
    #20 rst_n <= 0;
    #20 rst_n <= 1;
    config_en <= 1;
    config_data <= 2*5*5 - 1; 
    #20 config_en <= 0;
    adr_en <= 1;
    assert(adr == 0);
    #15 assert(adr == 1);
    #20 assert(adr == 2);
    #20 assert(adr == 3);
    #20 assert(adr == 4);
    #900 assert(adr == 49);
    #20 assert(adr == 0);
    adr_en <= 0;
    #20 assert(adr == 0);
    adr_en <= 1;
    #20 assert(adr == 1);
  end
  
  initial begin
    $vcdplusfile("dump.vcd");
    $vcdplusmemon();
    $vcdpluson(0, adr_gen_sequential_tb);
    #20000000;
    $finish(2);
  end

endmodule
