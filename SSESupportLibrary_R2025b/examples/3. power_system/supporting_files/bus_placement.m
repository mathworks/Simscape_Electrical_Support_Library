function bus_placement(mdl,data)
%
% This function places the buses
%
% Copyright (C) 2025, The MathWorks, Inc.
%

% place the buses

nl = numel(data.bus(:,1));

for l = 1:nl

    h = add_block('network_components/bus',[mdl,'/node_',num2str(data.bus(l,1))]);
   
    set_buses(h,data)

    posa = get(h,'Position');

    pos = posa - [posa(1) posa(2) posa(1) posa(2)];

    x = data.X(l);
    y = data.Y(l);

    set(h,'Position',pos + [x y x y])

    pause(0.001) % this pause is in place to visually see the network 'grow'.
    
end



