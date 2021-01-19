#include <fstream>
#include <iostream>
#include <string>

#include "conv_gold.cpp"

using namespace std;

template <int OFMAP_HEIGHT, 
          int OFMAP_WIDTH, 
          int OFMAP_CHANNELS, 
          int IFMAP_CHANNELS, 
          int FILTER_SIZE, 
          int STRIDE>
void run_layer(string layer_name){
    std::cout << "Running: " << layer_name << std::endl;
    
    std::ifstream ifmap_file;
    ifmap_file.open("data/" + layer_name + "_ifmap.txt");

    int16_t ifmap[(OFMAP_HEIGHT-1)*STRIDE+FILTER_SIZE][(OFMAP_WIDTH-1)*STRIDE+FILTER_SIZE][IFMAP_CHANNELS];
    for(int i = 0; i < (OFMAP_HEIGHT-1)*STRIDE+FILTER_SIZE; i++){
        for(int j = 0; j < (OFMAP_WIDTH-1)*STRIDE+FILTER_SIZE; j++){
            for(int k = 0; k < IFMAP_CHANNELS; k++){
                ifmap_file >> ifmap[i][j][k];
            }
        }
    }

    std::ifstream weights_file;
    weights_file.open("data/" + layer_name + "_weights.txt");
    int16_t weights[FILTER_SIZE][FILTER_SIZE][IFMAP_CHANNELS][OFMAP_CHANNELS];
    for(int i = 0; i < FILTER_SIZE; i++){
        for(int j = 0; j < FILTER_SIZE; j++){
            for(int k = 0; k < IFMAP_CHANNELS; k++){
                for(int l = 0; l < OFMAP_CHANNELS; l++){
                    weights_file >> weights[i][j][k][l];
                }
            }
        }
    }

    int32_t ofmap[OFMAP_HEIGHT][OFMAP_WIDTH][OFMAP_CHANNELS];
    conv_gold<OFMAP_HEIGHT, OFMAP_WIDTH, OFMAP_CHANNELS, IFMAP_CHANNELS, FILTER_SIZE, FILTER_SIZE, STRIDE>(ifmap, weights, ofmap);

    std::ofstream ofmap_file;
    ofmap_file.open("data/" + layer_name + "_ofmap.txt");
    for(int i = 0; i < OFMAP_HEIGHT; i++){
        for(int j = 0; j < OFMAP_WIDTH; j++){
            for(int k = 0; k < OFMAP_CHANNELS; k++){
                ofmap_file << ofmap[i][j][k] << "\n";
            }
        }
    }
    ofmap_file.close();

    
    std::ifstream gold_ofmap_file;
    gold_ofmap_file.open("data/" + layer_name + "_gold_ofmap.txt");
    for(int i = 0; i < OFMAP_HEIGHT; i++){
        for(int j = 0; j < OFMAP_WIDTH; j++){
            for(int k = 0; k < OFMAP_CHANNELS; k++){
                int32_t tmp;
                gold_ofmap_file >> tmp;

                if(tmp != ofmap[i][j][k]){
                    std::cout << "Error! Output does not match gold" << std::endl;
                    return;
                }
            }
        }
    }

    std::cout << "No errors found!" << std::endl;
}

int main(){
  run_layer<112, 112, 64, 3, 7, 2>("layer1");
  run_layer<56, 56, 64, 64, 3, 1>("layer2");
  run_layer<28, 28, 128, 128, 3, 1>("layer3");
}