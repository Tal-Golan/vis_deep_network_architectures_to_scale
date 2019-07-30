function fillBox(vertices,varargin)
if iscell(vertices)
    cellfun(@(v) fillBox(v,varargin{:}),vertices);
    return
end
face_vertices_inds=nan(4,6);
iFace=0;
for dim=1:3
    iFace=iFace+1;
    face_vertices_inds(:,iFace)=find(vertices(:,dim)==min(vertices(:,dim)));
    iFace=iFace+1;
    face_vertices_inds(:,iFace)=find(vertices(:,dim)==max(vertices(:,dim)));
end

 
    
for iFace=1:6
    cur_face_vertices=vertices(face_vertices_inds(:,iFace),:); 
    sorted_cur_face_vertices=sort_vertices_to_form_a_loop(cur_face_vertices);
    
    X=sorted_cur_face_vertices(:,1);
    Y=sorted_cur_face_vertices(:,2);
    Z=sorted_cur_face_vertices(:,3);
    
   
    hold all;
    patch(X,Y,Z,varargin{:})
end