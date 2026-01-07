function [n1,n2,idxn1a,idxn2a,boundaryBuses,nb1,nb2,n1a,n2a,idxB,idx1a,idx2a] = splitNetwork02(G,cc)
%
% This function uses graph theory to split a network
%
% Copyright 2018 The MathWorks, Inc

L = laplacian(G);
[V,~] = eigs(L,2,'smallestabs');
w = V(:,2);

idx = w == max(abs(w));
ss = sign(w(idx)); % if the sign is positive, flip the sign of w. This helps this calculation be consistent as the eigenvalues can flip signs easily

if ss == 1
    
    w = -w;
    
end

w_med = w - cc*median(w);
 
n1a = find(w_med >= 0);
n2a = find(w_med <  0);

%%

line_data.I = cellfun(@str2double,G.Edges.EndNodes(:,1));
line_data.J = cellfun(@str2double,G.Edges.EndNodes(:,2));

idx1a = ismember(line_data.I,n1a);
idx2a = ismember(line_data.J,n2a);

idxa = idx1a & idx2a;

idx1b = ismember(line_data.I,n2a);
idx2b = ismember(line_data.J,n1a);

idxb = idx1b & idx2b;

idxB = idxa | idxb;

nB = unique([line_data.I(idxB);line_data.J(idxB)]);

n1b = find(ismember(n1a,nB));
n2b = find(ismember(n2a,nB));




%%

idx1c = ismember(line_data.I,n1a);
idx2c = ismember(line_data.J,n1a);

idxn1 = idx1c & idx2c & ~idxB;

idx1d = ismember(line_data.I,n2a);
idx2d = ismember(line_data.J,n2a);

idxn2 = idx1d & idx2d & ~idxB;

idxn1a = find(idxn1);
idxn2a = find(idxn2);
idxBa = find(idxB);

%%

lineD.I = line_data.I(idxBa);
lineD.J = line_data.J(idxBa);

for lll = 1:numel(idxBa)
    
    idxI1 = ismember(n1a,lineD.I(lll));
    idxI2 = ismember(n2a,lineD.I(lll));
    idxJ1 = ismember(n1a,lineD.J(lll));
    idxJ2 = ismember(n2a,lineD.J(lll));
    
    
    if sum(idxI1) 
      
    boundary.n1(lll,1) = n1a(idxI1);
    
    end
    
    if sum(idxJ1) 
      
    boundary.n1(lll,1) = n1a(idxJ1);
    
    end
    
    if sum(idxI2)
      
    boundary.n2(lll,1) = n2a(idxI2);
    
    end
    
    if sum(idxJ2) 
      
    boundary.n2(lll,1) = n2a(idxJ2);
    
    end
    
    
end

%%


x1 = 0;
x2 = 0;

clearvars nb1 nb2

for lb = 1:numel(boundary.n1)
    
    b1 = boundary.n1(lb);
    b2 = boundary.n2(lb);
    
    idxb1 = ismember(boundary.n1,b1);
    idxb2 = ismember(boundary.n2,b2);
    
    if sum(idxb1) > 1
 
        x1 = x1 + 1;
        
        nb2(x1,1) = b1; %#ok<*SAGROW>
    
    elseif sum(idxb2) > 1
        
        x2 = x2 + 1;
        
        nb1(x2,1) = b2;
        
    else
        
        x1 = x1 + 1;
        
        nb2(x1,1) = b1;
        
    end
        
    
end

if ~exist('nb1','var')
    nb1 = [];
end

if ~exist('nb2','var')
    nb2 = [];
end


nb1 = unique(nb1);
nb2 = unique(nb2);

n1 = [n1a;nb1];
n2 = [n2a;nb2];

boundaryBuses = [nb1;nb2];

%%

idx1c = ismember(line_data.I,n1);
idx2c = ismember(line_data.J,n1);

idxn1 = idx1c & idx2c;

idx1d = ismember(line_data.I,n2);
idx2d = ismember(line_data.J,n2);

idxn2 = idx1d & idx2d;

idxn1a = find(idxn1);
idxn2a = find(idxn2);


