function define_outputs(mdl,voltageLevels)

%
% This function places from tags in measurement subsystems
%
% Copyright (C) 2025, The MathWorks, Inc.
%


%%

hi = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','IabcLine');

hom = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','line_current_output_bus');

set(hom,'Inputs',num2str(numel(hi)));

homp = get(hom,'PortHandles');

for l = 1:numel(hi)
    
    nn = get(hi(l),'GotoTag');
    
    hf = add_block('simulink/Signal Routing/From',[mdl,'/measurements/line_current_outputs/from_',nn]);
    
    hfp = get(hf,'PortHandles');
    
    set(hf,'GotoTag',nn);
    
    pos = get(hf,'Position');
    
    set(hf,'Position',[pos(1) pos(2)+(l-1)*20 pos(3) pos(4)+(l-1)*20])
    
    hl = add_line([mdl,'/measurements/line_current_outputs'],hfp.Outport,homp.Inport(l));
    
    set(hl,'SignalNameFromLabel',get(hi(l),'GotoTag'))
    
end

%%

vl = voltageLevels;

for xx = 1:numel(vl)

hv = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name',['VabcBus_',vl{xx}]);

hvom = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name',['bus_',vl{xx},'kV_output_bus']);

if ~isempty(hv)

set(hvom,'Inputs',num2str(numel(hv)));

hvomp = get(hvom,'PortHandles');

for l = 1:numel(hv)
    
    nn = get(hv(l),'GotoTag');

    hf = add_block('simulink/Signal Routing/From',[mdl,'/measurements/bus_',vl{xx},'kV_outputs/from_',nn]);
    
    hfp = get(hf,'PortHandles');
    
    set(hf,'GotoTag',nn);
    
    pos = get(hf,'Position');
    
    set(hf,'Position',[pos(1) pos(2)+(l-1)*20 pos(3) pos(4)+(l-1)*20])
    
    hl = add_line([mdl,'/measurements/bus_',vl{xx},'kV_outputs'],hfp.Outport,hvomp.Inport(l));
    
    set(hl,'SignalNameFromLabel',get(hv(l),'GotoTag'))
    
end
else
    set(hvom,'Inputs','1');
    hvomp = get(hvom,'PortHandles');
    hf = add_block('simulink/Sources/Constant',[mdl,'/measurements/bus_',vl{xx},'kV_outputs/Constant']);
    set(hf,'Value','[0 0 0]')
    hfp = get(hf,'PortHandles');
    hl = add_line([mdl,'/measurements/bus_',vl{xx},'kV_outputs'],hfp.Outport,hvomp.Inport); %#ok<*NASGU>
end


end



