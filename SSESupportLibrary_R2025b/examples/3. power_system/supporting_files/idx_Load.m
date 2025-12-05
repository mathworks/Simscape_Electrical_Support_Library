% index into load buses

idx = ismember(data1.bus(:,1),data1.busLoad);

% get bus numbers

busPQ = data1.bus(idx,1);

% bus numbers for segments

n1Busca = extractAfter(tagI,'Ib_');
n1Busc = extractBefore(n1Busca,'_');

n1Bus = cellfun(@str2double, n1Busc);

% index into PQ buses in segments

idxn1pq = find(ismember(n1Bus,busPQ));

n1_PQ = n1Bus(idxn1pq);

% PQ ref in each segment

[~,idx1pq] = ismember(n1_PQ,data1.bus(:,1));

% pu setpoints in each segment

n_PRef = data1.bus(idx1pq,3) + data1.bus(idx1pq,5);
n_QRef = data1.bus(idx1pq,4) - data1.bus(idx1pq,6);

%% load parameters

for x = 1:numel(data1.bus(:,1))
    eval(['loadParam.Pref_',num2str(data1.bus(x,1)),' = 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    eval(['loadParam.Qposref_',num2str(data1.bus(x,1)),' =  10e3;']) %#ok<*EVLSEQVAR>
    eval(['loadParam.Qnegref_',num2str(data1.bus(x,1)),' = -10e3;']) %#ok<*EVLSEQVAR>
    eval(['loadParam.Vrated_',num2str(data1.bus(x,1)),' = ',num2str(data1.bus(x,8)*data1.bus(x,10)*1e3),';']) %#ok<*EVLSEQVAR>   
end


qq1 = data1.bus(idx1pq,1);

for x = 1:numel(qq1)

    if  n_PRef(x) >= 0
    eval(['loadParam.Pref_',num2str(qq1(x)),' = n_PRef(x)*1e6 + 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    end
    
    if n_QRef(x) > 0
        eval(['loadParam.Qposref_',num2str(qq1(x)),' = n_QRef(x)*1e6 + 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    elseif n_QRef(x) < 0
            eval(['loadParam.Qnegref_',num2str(qq1(x)),' = n_QRef(x)*1e6 - 10e3;']) %#ok<*EVLDOT,*EVLSEQVAR>
    end

end