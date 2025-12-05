function set_buses(h,data)
%
% This function names the bus goto and fromtags
%
% Copyright (C) 2025, The MathWorks, Inc.
%

no1 = get(h,'Name');
no = strtok(no1,'node_');

idxv = ismember(data.bus(:,1),str2num(no)); %#ok<*ST2NM>
vv1 = num2str(data.bus(idxv,10)); % get voltage level
vv = strrep(vv1,'.','p');


hVb2 = find_system(h,'LookUnderMasks','All','RegExp','on','Name','VabcBus');

set(hVb2,'GotoTag',['Vb_',no]);

set(hVb2,'Name',['VabcBus_',vv]);

hI = find_system(h,'LookUnderMasks','All','RegExp','on','Name','IabcFrom');

set(hI,'GotoTag',['Ib_',no,'_',vv]);

set(hI,'Name',['IabcFrom_',vv]);


% hG = find_system(h,'LookUnderMasks','All','RegExp','on','Name','generator');
% set(hG,'Vnom',[vv,'000'])

try
hl = find_system(h,'LookUnderMasks','All','RegExp','on','Name','Wye-Connected Load');

set(hl,'VRated',['loadParam.Vrated_',no])
set(hl,'P',['loadParam.Pref_',no])
set(hl,'Qpos',['loadParam.Qposref_',no])
set(hl,'Qneg',['loadParam.Qnegref_',no])
catch
end

