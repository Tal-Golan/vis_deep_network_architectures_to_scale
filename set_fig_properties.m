function set_fig_properties()

box off
axis tight
axis off
set(gca,'DataAspectRatio',[1 1 1]);
set(gcf,'Color','w'); 
set(gca,'clipping','off');
set(gca,'ZDir','reverse');
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

set(gca,'CameraPosition',[1.5868   -0.5079   -0.5622]*1e3);
set(gca,'CameraTarget',[0 182 0]);
set(gca,'CameraUpVector',[0 0 -1]);
set(gca,'CameraViewAngle',10.3396,'CameraViewAngleMode','manual');
set(gcf,'position',[31         -30        1855        1001]);
