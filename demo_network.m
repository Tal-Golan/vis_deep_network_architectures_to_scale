
function [dnn_data]=demo_network

dnn_data=struct;

% here we define the layers dimensions: HxWxC
dnn_data.layer_dimensions=[
    128,128,16;
    128,128,64;
    64,64,128;
    32,32,256;
    16,16,512;
    4,4,512;
    2,2,512;
    1,1,512;
    ];

% this are particular units highlighted for receptive field demonstratation
dnn_data.rf_vis_units=[ % unit layer index, Y, X, feature map  
  2,17,17,32;
  3,8,8,32;
  4,2,2,32;
  5,2,2,200;
  6,2,2,32;
  7,1,1,150;             
  8,1,1,32;
  ];

% each unit needs its receptive field in the previous layer to be defined:
dnn_data.rf_min_x=[14, 5,  5,  1, 1, 1, 1];
dnn_data.rf_max_x=[20, 11, 11 ,2 ,1 ,1 ,1];
dnn_data.rf_min_y=[64, 5,  5  ,1 ,1 ,1 ,1];
dnn_data.rf_max_y=[70, 11, 11 ,2 ,1 ,1 ,1];
dnn_data.rf_layer=[1,  2  ,3  ,4 ,5 ,6 ,7];

