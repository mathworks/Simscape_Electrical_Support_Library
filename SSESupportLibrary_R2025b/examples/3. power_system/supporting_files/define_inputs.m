function tagI = define_inputs(mdl,voltageLevels)

%
% This function creates the goto tags within the 'inputs' subsystem
%
% Copyright (C) 2025, The MathWorks, Inc.
%

%%

hI = [];

for x = 1:numel(voltageLevels)

    hI = [hI;find_system(mdl,'FindAll','on','LookUnderMasks','on','Name',['IabcFrom_',voltageLevels{x}])]; %#ok<*AGROW>

end

hom1 = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','i_input_demux');

set(hom1,'Outputs',num2str(numel(hI)));

homp1 = get(hom1,'PortHandles');

tagI = cell(numel(hI),1);


for lt = 1:numel(hI)
    
    tagI{lt} = get(hI(lt),'GotoTag');
    
end

%%

for l = 1:numel(hI)
    
    nn = get(hI(l),'GotoTag');
    
    hf = add_block('simulink/Signal Routing/Goto',[mdl,'/current_inputs/to_',nn]);
    
    set(hf,'TagVisibility','global');
    
    hfp = get(hf,'PortHandles');
    
    set(hf,'GotoTag',nn);
    
    pos = get(hf,'Position');
    
    set(hf,'Position',[pos(1)+800 pos(2)+(l-1)*50 pos(3)+1000 pos(4)+(l-1)*50])
    
    hl = add_line([mdl,'/current_inputs'],homp1.Outport(l),hfp.Inport);
    
    set(hl,'SignalNameFromLabel',get(hI(l),'GotoTag'))
    
end
