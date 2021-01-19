`define BANK_ADDR_WIDTH 8

module ifmap_radr_gen_tb;

  reg clk;
  reg rst_n;
  reg config_en;
  reg adr_en;
  reg [`BANK_ADDR_WIDTH - 1 : 0] adr;
  reg [`BANK_ADDR_WIDTH - 1 : 0] config_OX0, config_OY0, config_FX, config_FY, 
    config_STRIDE, config_IX0, config_IY0, config_IC1, config_OC1;

  always #10 clk =~clk;
   
  ifmap_radr_gen #( 
    .BANK_ADDR_WIDTH(`BANK_ADDR_WIDTH)
  ) adr_gen (
    .clk(clk),
    .rst_n(rst_n),
    .adr_en(adr_en),
    .adr(adr),
    .config_en(config_en),
    .config_data({config_OX0, config_OY0, config_FX, config_FY, config_STRIDE, 
                  config_IX0, config_IY0, config_IC1, config_OC1})
  );
  
  initial begin
    clk <= 0;
    rst_n <= 1;
    config_en <= 0;
    config_OX0 <= 0;
    config_OY0 <= 0;
    config_FX <= 0;
    config_FY <= 0;
    config_STRIDE <= 0;
    config_IX0 <= 0;
    config_IY0 <= 0;
    config_IC1 <= 0;
    config_OC1 <= 0;
    adr_en <= 0;

    #20 rst_n <= 0;
    
    #20 rst_n <= 1;
    config_en <= 1;
    config_OX0 <= 3;
    config_OY0 <= 3;
    config_FX <= 3;
    config_FY <= 3;
    config_STRIDE <= 1;
    config_IX0 <= 5;
    config_IY0 <= 5;
    config_IC1 <= 2;
    config_OC1 <= 1;
    
    #20 config_en <= 0;
    adr_en <= 1;

    // kernel at fx = 0, fy = 0
        $display("adr = %d", adr); assert(adr == 0);
    #15 $display("adr = %d", adr); assert(adr == 1);
    #20 $display("adr = %d", adr); assert(adr == 2);

    #20 $display("adr = %d", adr); assert(adr == 5);
    #20 $display("adr = %d", adr); assert(adr == 6);
    #20 $display("adr = %d", adr); assert(adr == 7);
    
    #20 $display("adr = %d", adr); assert(adr == 10);
    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);
    
    // kernel at fx = 1, fy = 0
    #20 $display("adr = %d", adr); assert(adr == 1);
    #20 $display("adr = %d", adr); assert(adr == 2);
    #20 $display("adr = %d", adr); assert(adr == 3);
    
    #20 $display("adr = %d", adr); assert(adr == 6);
    #20 $display("adr = %d", adr); assert(adr == 7);
    #20 $display("adr = %d", adr); assert(adr == 8);

    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);

    // kernel at fx = 2, fy = 0
    #20 $display("adr = %d", adr); assert(adr == 2);
    #20 $display("adr = %d", adr); assert(adr == 3);
    #20 $display("adr = %d", adr); assert(adr == 4);

    #20 $display("adr = %d", adr); assert(adr == 7);
    #20 $display("adr = %d", adr); assert(adr == 8);
    #20 $display("adr = %d", adr); assert(adr == 9);

    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);
    #20 $display("adr = %d", adr); assert(adr == 14);

    // kernel at fx = 0, fy = 1
    #20 $display("adr = %d", adr); assert(adr == 5);
    #20 $display("adr = %d", adr); assert(adr == 6);
    #20 $display("adr = %d", adr); assert(adr == 7);

    #20 $display("adr = %d", adr); assert(adr == 10);
    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);
    
    #20 $display("adr = %d", adr); assert(adr == 15);
    #20 $display("adr = %d", adr); assert(adr == 16);
    #20 $display("adr = %d", adr); assert(adr == 17);
    
    // kernel at fx = 1, fy = 1
    #20 $display("adr = %d", adr); assert(adr == 6);
    #20 $display("adr = %d", adr); assert(adr == 7);
    #20 $display("adr = %d", adr); assert(adr == 8);
    
    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);

    #20 $display("adr = %d", adr); assert(adr == 16);
    #20 $display("adr = %d", adr); assert(adr == 17);
    #20 $display("adr = %d", adr); assert(adr == 18);

    // kernel at fx = 2, fy = 1
    #20 $display("adr = %d", adr); assert(adr == 7);
    #20 $display("adr = %d", adr); assert(adr == 8);
    #20 $display("adr = %d", adr); assert(adr == 9);

    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);
    #20 $display("adr = %d", adr); assert(adr == 14);

    #20 $display("adr = %d", adr); assert(adr == 17);
    #20 $display("adr = %d", adr); assert(adr == 18);
    #20 $display("adr = %d", adr); assert(adr == 19);

    // kernel at fx = 0, fy = 2
    #20 $display("adr = %d", adr); assert(adr == 10);
    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);

    #20 $display("adr = %d", adr); assert(adr == 15);
    #20 $display("adr = %d", adr); assert(adr == 16);
    #20 $display("adr = %d", adr); assert(adr == 17);
    
    #20 $display("adr = %d", adr); assert(adr == 20);
    #20 $display("adr = %d", adr); assert(adr == 21);
    #20 $display("adr = %d", adr); assert(adr == 22);
    
    // kernel at fx = 1, fy = 2
    #20 $display("adr = %d", adr); assert(adr == 11);
    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);
    
    #20 $display("adr = %d", adr); assert(adr == 16);
    #20 $display("adr = %d", adr); assert(adr == 17);
    #20 $display("adr = %d", adr); assert(adr == 18);

    #20 $display("adr = %d", adr); assert(adr == 21);
    #20 $display("adr = %d", adr); assert(adr == 22);
    #20 $display("adr = %d", adr); assert(adr == 23);

    // kernel at fx = 2, fy = 2
    #20 $display("adr = %d", adr); assert(adr == 12);
    #20 $display("adr = %d", adr); assert(adr == 13);
    #20 $display("adr = %d", adr); assert(adr == 14);

    #20 $display("adr = %d", adr); assert(adr == 17);
    #20 $display("adr = %d", adr); assert(adr == 18);
    #20 $display("adr = %d", adr); assert(adr == 19);

    #20 $display("adr = %d", adr); assert(adr == 22);
    #20 $display("adr = %d", adr); assert(adr == 23);
    #20 $display("adr = %d", adr); assert(adr == 24);

    // kernel at fx = 0, fy = 0, ic1 = 1
    #20 $display("adr = %d", adr); assert(adr == 0 + 25);
    #20 $display("adr = %d", adr); assert(adr == 1 + 25);
    #20 $display("adr = %d", adr); assert(adr == 2 + 25);

    #20 $display("adr = %d", adr); assert(adr == 5 + 25);
    #20 $display("adr = %d", adr); assert(adr == 6 + 25);
    #20 $display("adr = %d", adr); assert(adr == 7 + 25);
    
    #20 $display("adr = %d", adr); assert(adr == 10 + 25);
    #20 $display("adr = %d", adr); assert(adr == 11 + 25);
    #20 $display("adr = %d", adr); assert(adr == 12 + 25);
    
    #1440 $display("adr = %d", adr); assert(adr == 24 + 25); 
    #20 $display("adr = %d", adr); assert(adr == 0);
    #3220 $display("adr = %d", adr); assert(adr == 24 + 25);
  end
  
  initial begin
    $vcdplusfile("dump.vcd");
    $vcdplusmemon();
    $vcdpluson(0, ifmap_radr_gen_tb);
    #20000000;
    $finish(2);
  end

endmodule
