function [n_PRef,n_QRef] = idx_Load_segs(data,tagI)

% index into load buses

idx = ismember(data.bus(:,1),data.busLoad);

% get bus numbers

busPQ = data.bus(idx,1);

% bus numbers for segments

n1Busc = extractBefore(extractAfter(tagI,'Ib_'),'_');
n1Bus = cellfun(@str2double, n1Busc);

% index into PQ buses in segments

idxn1pq = find(ismember(n1Bus,busPQ));

n1_PQ = n1Bus(idxn1pq);

% PQ ref in each segment

[~,idx1pq] = ismember(n1_PQ,data.bus(:,1));

% pu setpoints in each segment
assignin('base','idx1pq',idx1pq)

n_PRef = data.bus(idx1pq,3) + data.bus(idx1pq,5);
n_QRef = data.bus(idx1pq,4) - data.bus(idx1pq,6);

assignin('base','n_PRef',n_PRef)
assignin('base','n_QRef',n_QRef)

%% load parameters

for x = 1:numel(data.bus(:,1))
    evalin('base',['loadParam.Pref_',num2str(data.bus(x,1)),' = 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    evalin('base',['loadParam.Qposref_',num2str(data.bus(x,1)),' =  10e3;']) %#ok<*EVLSEQVAR>
    evalin('base',['loadParam.Qnegref_',num2str(data.bus(x,1)),' = -10e3;']) %#ok<*EVLSEQVAR>
    evalin('base',['loadParam.Vrated_',num2str(data.bus(x,1)),' = ',num2str(data.bus(x,8)*data.bus(x,10)*1e3),';']) %#ok<*EVLSEQVAR>   
end


qq1 = data.bus(idx1pq,1);

for x = 1:numel(qq1)

    if  n_PRef(x) >= 0
    evalin('base',['loadParam.Pref_',num2str(qq1(x)),' = n_PRef(',num2str(x),')*1e6 + 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    end
    
    if n_QRef(x) > 0
        evalin('base',['loadParam.Qposref_',num2str(qq1(x)),' = n_QRef(',num2str(x),')*1e6 + 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    elseif n_QRef(x) < 0
        evalin('base',['loadParam.Qnegref_',num2str(qq1(x)),' = n_QRef(',num2str(x),')*1e6 - 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    end

end