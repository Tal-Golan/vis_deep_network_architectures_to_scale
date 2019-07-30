close all; clear all;
cfg=struct;
cfg.inter_box_spacing=30; % distance between layers
cfg.line_density=0.1; % how dense are the connections between units and their corresponding receptive fields. 1.0 is nice and dense (but slow).
cfg.doDrawEmptyBox=true; 
cfg.do_export=false;

addpath('altmany-export_fig-5f4c67c')

model='alexnet';

[dnn_data]=demo_network(); % get necessary deep neural network data. In principle this can be imported from tensorflow/pytorch instead of being manually specified.

% precalculations - figure out the locations and dimensions of the 'layer boxes'
box_dimensions=dnn_data.layer_dimensions(:,[3 2 1]);
nBoxes=size(box_dimensions,1);
box_centers=zeros(nBoxes,3);
for iBox=2:nBoxes
    box_centers(iBox,2)=box_centers(iBox-1,2)+box_dimensions(iBox-1,2)/2+cfg.inter_box_spacing+box_dimensions(iBox,2)/2;    
end

figure;

% here we draw the boxes for the networks' layers
[~,vertices]=drawBox(box_centers,box_dimensions,'k','linewidth',1);
fillBox(vertices,'k','FaceAlpha',0.1,'EdgeColor','none');

% and this is for receptive fields (many lines - slow...)
for iRF=1:size(dnn_data.rf_vis_units,1)
    unit_layer=dnn_data.rf_vis_units(iRF,1);
    unit_X=dnn_data.rf_vis_units(iRF,3);
    unit_Y=dnn_data.rf_vis_units(iRF,2);
    unit_F=dnn_data.rf_vis_units(iRF,4);
    rf_layer=dnn_data.rf_layer(iRF);
    rf_min_X=dnn_data.rf_min_x(iRF);
    rf_max_X=dnn_data.rf_max_x(iRF);
    rf_min_Y=dnn_data.rf_min_y(iRF);
    rf_max_Y=dnn_data.rf_max_y(iRF);
    drawConnection(unit_layer,unit_X,unit_Y,unit_F,rf_layer,rf_min_X,rf_max_X,rf_min_Y,rf_max_Y,box_centers,box_dimensions,cfg.line_density);
end


% this part draws a cube to visualize to coordinate system
if cfg.doDrawEmptyBox
    SF=0.4;
    empty_axis_origin=[0 -85 -130];
    p1=bsxfun(@plus,[0 0 0;0 0 0;0 0 0],empty_axis_origin);
    uvw=[-50 0 0;0 50 0;0 0 -50];
    p2=p1+uvw;
    hold all;   
    drawBox(p1(1,:)+[-50 50 -50]/2,[50 50 50],'--','Color',[0 0 0 0.2]);
    hold all;
    global LineWidthOrder; LineWidthOrder = [1.2]; % this is used by arrow3
    arrow3(p1,p2,'k-/',SF);
end

set_fig_properties()
arrow3('update',SF)
set(gcf,'Renderer','painters');
if cfg.do_export
    export_fig dnn_architecture.png -m2 -nocrop -painters
end