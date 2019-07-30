function sorted_vertices=sort_vertices_to_form_a_loop(vertices)
% sorts a list of vertices to minimize distances between each consequtive
% vertices


% this can be replaced with PDIST
nVertices=size(vertices,1);
D=nan(nVertices,nVertices);
for i=1:nVertices
    for j=1:nVertices
        D(i,j)=sum(abs(vertices(i,:)-vertices(j,:)));
    end
end


possible_vertices_inds=1:nVertices;
sorted_vertices_inds=possible_vertices_inds(1);

possible_vertices_inds(1)=[];

while ~isempty(possible_vertices_inds)
    [~,ind]=min(D(possible_vertices_inds,sorted_vertices_inds(end)));
    sorted_vertices_inds(end+1)=possible_vertices_inds(ind); %#ok<AGROW>
    possible_vertices_inds(ind)=[];
end

sorted_vertices=vertices(sorted_vertices_inds,:);
