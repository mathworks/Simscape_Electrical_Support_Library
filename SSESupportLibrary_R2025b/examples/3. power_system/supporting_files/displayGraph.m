function [X,Y,h] = displayGraph(data)

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


