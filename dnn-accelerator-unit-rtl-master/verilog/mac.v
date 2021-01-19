module mac
#(
  parameter IFMAP_WIDTH = 16,
  parameter WEIGHT_WIDTH = 16,
  parameter OFMAP_WIDTH = 32
)(
  input clk,
  input rst_n,
  input en,
  input weight_wen,
  input signed [IFMAP_WIDTH - 1 : 0] ifmap_in,
  input signed [WEIGHT_WIDTH - 1 : 0] weight_in,
  input signed [OFMAP_WIDTH - 1 : 0] ofmap_in,
  output signed [IFMAP_WIDTH - 1 : 0] ifmap_out,
  output signed [OFMAP_WIDTH - 1 : 0] ofmap_out
);

  reg signed [WEIGHT_WIDTH - 1 : 0] weight_r;
  reg signed [IFMAP_WIDTH - 1 : 0] ifmap_r;
  reg signed [OFMAP_WIDTH - 1 : 0] ofmap_r;
 
  // Implement the functionality of a scalar multiply-accumulate (MAC) unit.
  // This unit performs one multiply and one accumulate per cycle. The
  // functionality should be identical to the figure shown in the homework
  // pdf: the current input (ifmap_in) is multiplied with the stored weight
  // (weight_r) and added to the current output (ofmap_in), and the result is
  // stored in the output register (ofmap_r). The input and output registers
  // are only updated if en is high. Registered input and output are sent out.

  // If weight_en is high, then store the incoming weight (weight_in) into the
  // weight register (weight_r).
  
  // Synchronously reset all registers when rst_n is low.

  // Your code starts here

  // Your code ends here
endmodule
