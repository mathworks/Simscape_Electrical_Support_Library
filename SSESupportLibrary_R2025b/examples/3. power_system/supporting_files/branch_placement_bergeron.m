function branch_placement_bergeron(model,data)
%
% This function places the branches and connects them to the buses
%
% Copyright 2025 The MathWorks, Inc.
%

% place the lines

nld = numel(data.branch(:,1));

dd = data.branch(:,[1 2]);

[uniqueRows, ~, idx] = unique(dd, 'rows');

% Initialize the numbering array
numDuplicates = zeros(size(dd, 1), 1);

% Initialize a counter for each unique row
rowCounters = zeros(size(uniqueRows, 1), 1);

% Loop through each row in the original matrix
for i = 1:size(dd, 1)
    % Increment the counter for the corresponding unique row
    rowCounters(idx(i)) = rowCounters(idx(i)) + 1;
    
    % Assign the counter value to the numbering array
    numDuplicates(i) = rowCounters(idx(i));
end



for ll = 1:nld
    
    pc = 1;

    % 
    f_t = [data.branch(ll,1) data.branch(ll,2)];
    
    nf = num2str(f_t(1));
    nt = num2str(f_t(2));
    
    h1a = find_system(model,'Name',['node_',nf]);
    h1b = get_param(h1a,'Handle');
    h1 = h1b{1};
    
    h2a = find_system(model,'Name',['node_',nt]);
    h2b = get_param(h2a,'Handle');
    h2 = h2b{1};
    
    ph1 = get(h1,'Position');
    ph2 = get(h2,'Position');
    
    ppx = abs(ph1(1)-ph2(1));
    ppy = abs(ph1(2)-ph2(2));
    
    mid_point = (max([ph1;ph2]) - min([ph1;ph2]))/2+min([ph1;ph2]);

    h = add_block('network_components/branch_bergeron',[model,'/branch_',nf,'_',nt,'_',num2str(numDuplicates(ll))]);

    hb = find_system(h,'FindAll','on','LookUnderMasks','all','RegExp','on','Name','pos_seq_bergeron_branch');

    set(hb,'R',['lineParam.R_',nf,'_',nt,'_',num2str(numDuplicates(ll))]);
    set(hb,'X',['lineParam.X_',nf,'_',nt,'_',num2str(numDuplicates(ll))]);
    set(hb,'B',['lineParam.B_',nf,'_',nt,'_',num2str(numDuplicates(ll))]);
    set(hb,'Pnom_Fnom',['[',num2str(data.baseMVA*1e6),' 60]']);
    
    if data.fV(ll) == data.tV(ll)

        set(hb,'Tx','off')

    else

        set(hb,'Tx','on')

    end

    evalin('base',['lineParam.R_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.branch(ll,3)),';']);
    evalin('base',['lineParam.X_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.branch(ll,4)),';']);
    evalin('base',['lineParam.B_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.branch(ll,5)),';']);
    evalin('base',['lineParam.V2_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.tV(ll)*1e3),';']);
     
    if (data.branch(ll,9) == 0)
        evalin('base',['lineParam.V1_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.fV(ll)*1e3),';']);
        set(hb,'Vnom1',num2str(data.fV(ll)));
    else
        evalin('base',['lineParam.V1_',nf,'_',nt,'_',num2str(numDuplicates(ll)),' = ',num2str(data.fV(ll)*data.branch(ll,9)*1e3),';']);
        set(hb,'Vnom1',num2str(data.fV(ll)*data.branch(ll,9)*1e3));
    end

    set(hb,'Vnom2',num2str(data.tV(ll)*1e3));
    

    hI = find_system(h,'LookUnderMasks','all','RegExp','on','Name','IabcLine');

    no1 = get(h,'Name');
    no = strsplit(no1,'branch_');

    set(hI,'GotoTag',['Iabc_',no{2}]);


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
    posa = get(h,'Position');
    
    pos = posa - [posa(1) posa(2) posa(1) posa(2)];
    
    mp = [mid_point(1) mid_point(2) mid_point(1) mid_point(2)]-[pos(3)/2 0 pos(3)/2 0]; 
    
    set(h,'Position',pos + mp)
    
    %set(h,'Name',[nf,'_',nt,'_',num2str(numDuplicates(ll))])
    
    if ppx < ppy
        
        set(h,'Orientation','up') % flip the line
          
    end
    
    % add the lines
    
    
    hp = get(h,'Porthandles');
    hp1 = get(h1,'Porthandles');
    hp2 = get(h2,'Porthandles');
    
    lhp = numel(hp.LConn);
    lhp1 = numel(hp1.LConn);
    lhp2 = numel(hp2.LConn);
    
    if lhp < lhp1
        
        il1 = find(pc);
       
        il1(il1 > lhp1) = il1(il1 > lhp1) - 1;
        
    else
        
        il1 = 1:lhp1;
        
    end
    
    if lhp < lhp2
        
        il2 = find(pc);
       
        il2(il2 > lhp2) = il2(il2 > lhp2) - 1;
        
    else
        
        il2 = 1:lhp2;
        
    end
    
    % determine which side of the line is closest to which bus
    
    Lpp = get(hp.LConn(1),'Position');
    
    Lpp1 = get(hp1.LConn(1),'Position');
    Lpp2 = get(hp2.LConn(1),'Position');
  
    LL1 = sqrt((Lpp(1) - Lpp1(1))^2 + (Lpp(2) - Lpp1(2))^2);
    LL2 = sqrt((Lpp(1) - Lpp2(1))^2 + (Lpp(2) - Lpp2(2))^2);
      
    [~,idx]=min([LL1 LL2]);
    
        if idx == 2  % flip the branch the other way so that current flows positive from the lowest bus number,
            % but take account of OLTC lines and their connection profile
            
            if strcmp(get(h,'Orientation'),'right')
                
                set(h,'Orientation','left');
                
            elseif strcmp(get(h,'Orientation'),'left')
                
                set(h,'Orientation','right');
                
            elseif strcmp(get(h,'Orientation'),'up')
                
                set(h,'Orientation','down');
                
            elseif strcmp(get(h,'Orientation'),'down')
                
                set(h,'Orientation','up');
                
            end
            
        end
        
        

       
        
        if (numel(hp.LConn) == numel(hp1.LConn))
            
            %flip the bus
            set(h1,'Orientation',get(h,'Orientation'))
            
        end
        
        if (numel(hp.LConn) == numel(hp2.LConn))
            
            %flip the bus
            set(h2,'Orientation',get(h,'Orientation'))
            
        end
        
        
        
    for l = 1:numel(hp.LConn)
        
            add_line(model,hp.LConn(l),hp1.LConn(il1(l)));
            
            add_line(model,hp.RConn(l),hp2.LConn(il2(l)));

    end
    
    pause(0.01)
    
 
end
    
    
end

