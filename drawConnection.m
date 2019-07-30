function drawConnection(unit_layer,unit_X,unit_Y,unit_F,rf_layer,rf_min_X,rf_max_X,rf_min_Y,rf_max_Y,box_centers,box_dimensions,line_density)
patchColor=[0.8 0.8 1.0];
targetMode='many_lines';
rf_box_dim=[box_dimensions(rf_layer,1),rf_max_X-rf_min_X+1,rf_max_Y-rf_min_Y+1];
rf_layer_box_top_left_corner=box_centers(rf_layer,:)-box_dimensions(rf_layer,:)/2;
rf_box_center=rf_layer_box_top_left_corner+rf_box_dim/2+[0,rf_min_X-1,rf_min_Y-1];

hold all;
%[~,vertices]=drawBox(rf_box_center,rf_box_dim,'k-','linewidth',0.1);


[~,vertices]=drawBox(rf_box_center,rf_box_dim,'-k','linewidth',0.1);
fillBox(vertices,'k','FaceAlpha',0.05,'EdgeColor','none');


unit_box_dim=[1,1,1];
unit_layer_box_top_left_corner=box_centers(unit_layer,:)-box_dimensions(unit_layer,:)/2;
unit_box_center=unit_layer_box_top_left_corner+unit_box_dim/2+[unit_F-1,unit_X-1,unit_Y-1];
rf_forward_vertices=vertices(vertices(:,2)==max(vertices(:,2)),:);

switch targetMode
    case 'targetVoxel'
%        this draws small voxel at the target unit and connects it by lines
        [~,vertices]=drawBox(unit_box_center,unit_box_dim,'k-','linewidth',1);
        unit_backward_vertices=vertices(vertices(:,2)==min(vertices(:,2)),:);

        for iPlot=1:4
            plot3([rf_forward_vertices(iPlot,1) unit_backward_vertices(iPlot,1)],[rf_forward_vertices(iPlot,2) unit_backward_vertices(iPlot,2)],[rf_forward_vertices(iPlot,3) unit_backward_vertices(iPlot,3)],'--k','linewidth',0.01);
        end

    case 'transparent_cone'
        rf_forward_vertices=sort_vertices_to_form_a_loop(rf_forward_vertices);
        for iFace=0:3
            v1_ind=mod(iFace,4)+1;
            v2_ind=mod(iFace+1,4)+1;
            X=[rf_forward_vertices(v1_ind,1) unit_box_center(1) rf_forward_vertices(v2_ind,1)];
            Y=[rf_forward_vertices(v1_ind,2) unit_box_center(2) rf_forward_vertices(v2_ind,2)];
            Z=[rf_forward_vertices(v1_ind,3) unit_box_center(3) rf_forward_vertices(v2_ind,3)];
            hold all;
            patch(X,Y,Z,patchColor,'FaceAlpha',0.3,'EdgeColor',patchColor);
        end
    case 'many_lines'
        hold all;
        front_most_y=max(rf_forward_vertices(:,2));        
        p_draw_line=1/prod(rf_box_dim)*1000*line_density*3;
        for Xind=1:rf_box_dim(1)
            for Yind=1:rf_box_dim(2)
                for Zind=1:rf_box_dim(3)
                    if rand<p_draw_line
                        X=[rf_box_center(1)-rf_box_dim(1)/2+Xind-1/2  unit_box_center(1)];
                        %Y=[front_most_y  unit_box_center(2)];
                        Y=[rf_box_center(2)-rf_box_dim(2)/2+Yind-1/2  unit_box_center(2)];
                        Z=[rf_box_center(3)-rf_box_dim(3)/2+Zind-1/2  unit_box_center(3)];
                        linealpha=0.2;
                        linecolor=patchColor*(1-rand*.05);
                        plot3(X,Y,Z,'Color',[linecolor linealpha]);
                    end
                end
            end
        end
        
end

