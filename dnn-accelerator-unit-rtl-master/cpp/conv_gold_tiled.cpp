#include <stdio.h>
#include <cassert>
#include <string.h>
#include <cstdint>

template <int OY1, int OY0, int OX1, int OX0, int OC1, int OC0, int IC1, int IC0, int FX, int FY, int STRIDE>
void conv_gold_tiled(
    int16_t ifmap[(OY1*OY0-1)*STRIDE+FY][(OX1*OX0-1)*STRIDE+FX][IC1*IC0],
    int16_t weights[FY][FX][IC1*IC0][OC1*OC0],
    int32_t ofmap[OY1*OY0][OX1*OX0][OC1*OC0]
) 
{
  // Implement the functionality of a convolutional layer, which convolves
  // ifmap with weight to produce ofmap, but now with tiling. The order of
  // loops should be OY1, OX1, OC1, IC1, FY, FX, OY0, OX0, OC0, IC0 going from
  // outer to inner (IC0 should be the innermost loop). Your code should assign
  // values to the ofmap array. Make sure you take STRIDE into account.
  
  // This tiled convolution should produce exactly the same ofmap as the
  // non-tiled version you wrote in conv_gold.cpp.
  
  // Your accelerator will use the same tiling, and in the next homework you
  // will use this function to verify the output of your accelerator.
 
  // Your code starts here

  // Your code ends here
}
