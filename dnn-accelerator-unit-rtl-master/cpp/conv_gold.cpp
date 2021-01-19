#include <stdio.h>
#include <cassert>
#include <string.h>
#include <cstdint>

template <int OY, int OX, int OC, int IC, int FY, int FX, int STRIDE>
void conv_gold(int16_t ifmap[(OY-1)*STRIDE+FY][(OX-1)*STRIDE+FX][IC],
               int16_t weight[FY][FX][IC][OC],
               int32_t ofmap[OY][OX][OC]){

  // Implement the functionality of a convolutional layer, which convolves
  // ifmap with weight to produce ofmap. Your code should assign values to the
  // ofmap array. Make sure you take STRIDE into account.
 
  // Your code starts here

  // Your code ends here
}
