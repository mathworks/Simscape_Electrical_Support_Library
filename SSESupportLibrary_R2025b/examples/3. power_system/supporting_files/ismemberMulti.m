function [idx,M] = ismemberMulti(qq,ww)

idx = [];

for x = 1:numel(ww)

    idxa = find(ismember(qq,ww(x)))';

    idx = [idx;idxa]; %#ok<*AGROW>

end

M = zeros(numel(idx),numel(ww));

for x = 1:numel(ww)

    idxa = find(ismember(qq,ww(x)))';

    M(idxa,x) = 1; %#ok<*AGROW>

end
