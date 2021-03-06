function m = compute_entropy(M,T)

% compute_entropy - compute the entropy of a signal
%
%   m = compute_entropy(M);
% OR if you need quantization
%   m = compute_entropy(M,T)
%
%   Copyright (c) 2004 Gabriel Peyr?

if nargin<2
    T = -1;
end

if iscell(M)
   m = 0;
   for i=1:length(M)
       m = m + compute_entropy(M{i},T);
   end
   return;
end

if T>0
    [y, M] = perform_quantization(M, T);
end

M = M(:);
n = length(M);

L = unique(M)';
if length(L)>1000 && length(L)>n/4
    error('The data seems to be unquantized.');
end 

h = []; % histogram
for p = L;
    h = [h, length(find(M==p))];
end
h = h/n;
m = - sum( h.*log2(h) );