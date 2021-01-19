#include <stdio.h>
#include <cassert>
#include <string.h>
#include <cstdint>


// OY = Output height
// OX = Output width
// OC = Output channel
// FY = kernel height
// FX = kernel width
// Stride = movement of filter

template <int OY, int OX, int OC, int IC, int FY, int FX, int STRIDE>
void conv_gold(int16_t ifmap[(OY-1)*STRIDE+FY][(OX-1)*STRIDE+FX][IC],
               int16_t weight[FY][FX][IC][OC],
               int32_t ofmap[OY][OX][OC]){

  // Implement the functionality of a convolutional layer, which convolves
  // ifmap with weight to produce ofmap. Your code should assign values to the
  // ofmap array. Make sure you take STRIDE into account.
 
  // where tf does stride come into play

  // Your code starts here
  /* Output Channel */ 
  for ( int oc = 0 ; oc < OC; oc ++)
  {
    /*Input Channel */
    for ( int ic = 0; ic < IC; ic++)
    {
      /* Output Height */
      for ( int oy = 0; oy < OY; oy++ )
      {
        /* Output Width */
        for ( int ox = 0 ; ox < OX ; ox++ )
        {
          /* Filter Height */
          for ( int fy = 0; fy < FY ; fy++ )
          {
            /* Filter Width */
            for ( int fx = 0 ; fx < FX ; fx++)
            {
              // computational layer
              ofmap[oy][ox][oc] += ifmap[oy * STRIDE + fy][ox * STRIDE + fy][ic] * weight[fy][fx][ic][oc] ; // make sure to include stride in ifmap

            }
          }

        }
      }

    }
  }


/* for on =0 toON –1 # batch
 * foroc=0 toOC –1 # output channels
 * foric=0 toIC –1 # input channels
 * foroy =0 to OY –1 # output height
 * forox =0 to OX –1 # output width
 * forfy=0 to FY –1 # filter height
 * forfx=0 to FX –1 # filter width
 * O[on][oc][ox][oy] +=
 * I[on][ic][oy +fy][ox +fx]
 * *W[oc][ic][fy][fx]
 */


  // Your code ends here
}
