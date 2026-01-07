function [X,Y,n1,n2,nb1,nb2,bus1,bus2,linesConn] = displayGraph_2segs(data,cc)

buses1 = unique([data.branch(:,1);data.branch(:,2)]);

for x = 1:numel(data.branch(:,1))
    
   qq(x,1) = find(ismember(buses1,data.branch(x,1))); %#ok<*AGROW>
   ww(x,1) = find(ismember(buses1,data.branch(x,2)));
   
end

eea = [qq ww];

eea = sort(eea,2);

eea = unique(eea,'rows');

G1 = graph(eea(:,1),eea(:,2),ones(numel(eea(:,1)),1));

G1.Nodes.Name = arrayfun(@num2str, data.bus(:,1), 'UniformOutput', false);

figure(1);h = plot(G1,'layout','force');

X =  h.XData;
Y = -h.YData;


[n1,n2,~,~,~,~,~,n1a,n2a,idxB,idxa,idxb] = splitNetwork02(G1,cc); % 

qq1 = colormap('lines');

highlight(h,n1a,'NodeColor',qq1(1,:))
highlight(h,n2a,'NodeColor',qq1(2,:))
 
highlight(h,G1.Edges.EndNodes(idxa,1),G1.Edges.EndNodes(idxa,2),'EdgeColor',qq1(1,:)) % highlight region 1
highlight(h,G1.Edges.EndNodes(idxb,1),G1.Edges.EndNodes(idxb,2),'EdgeColor',qq1(2,:)) % highlight region 2
highlight(h,G1.Edges.EndNodes(idxB,1),G1.Edges.EndNodes(idxB,2),'EdgeColor','g') % highlight connection lines

bus1 = n1a;
bus2 = n2a;
linesConn = str2double(G1.Edges.EndNodes(idxB,:));

nb1 = sort(n1(ismember(n1,n2)));
 
nb2 = sort(n2(ismember(n2,n1)));

