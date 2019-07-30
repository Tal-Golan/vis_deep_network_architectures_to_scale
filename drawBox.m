function [h,vertices]=drawBox(center_coordinates,dimensions,varargin)

if size(center_coordinates,1)>1 && size(center_coordinates,2)>1
    nBoxes=size(center_coordinates,1);
    assert(size(dimensions,1)==nBoxes)
    n=size(center_coordinates,2);
    nEdges=n*2^(n-1);
    h=nan(nBoxes,nEdges);
    vertices=cell(nBoxes,1);
    for iBox=1:nBoxes
        [h(iBox,:),vertices{iBox}]=drawBox(center_coordinates(iBox,:),dimensions(iBox,:),varargin{:});
    end
else
    
    n=size(center_coordinates,2);
    assert(size(dimensions,2)==n)
    
    % calculate box vertex
    vertices=(dec2bin(0:2^n-1)=='1')-1/2;
    vertices=bsxfun(@times,vertices,dimensions(:)');
    vertices=bsxfun(@plus,vertices,center_coordinates(:)');
    nVertex=size(vertices,1);
    
    % calculate box edges
    [v_ind]=nchoosek(1:nVertex,2);
    edgeMask=sum((vertices(v_ind(:,1),:)-vertices(v_ind(:,2),:))~=0,2)==1;
    edge_vertex_ind=[v_ind(edgeMask,1) v_ind(edgeMask,2)];
        
    nEdges=size(edge_vertex_ind,1);
    h=nan(1,nEdges);
    for iEdge=1:nEdges
        curVertex1=vertices(edge_vertex_ind(iEdge,1),:);
        curVertex2=vertices(edge_vertex_ind(iEdge,2),:);
        if n==2
            h(iEdge)=plot2([curVertex1(1),curVertex2(1)],[curVertex1(2),curVertex2(2)],varargin{:});
        elseif n==3
            h(iEdge)=plot3([curVertex1(1),curVertex2(1)],[curVertex1(2),curVertex2(2)],[curVertex1(3),curVertex2(3)],varargin{:});
        else
            error('invalid n')
        end
        hold on;
    end
end
axis vis3d


