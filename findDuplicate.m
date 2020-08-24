function [duplicates,indexs]=findDuplicate(A)

[~,m,~] = unique(A);
orgl_ind = 1:length(A);
ind2get = setdiff(orgl_ind, m);
duplicates = A(ind2get);
[~,index]=sort(ind2get,'descend');
duplicates=duplicates(index);
[~,i]=setdiff(A,duplicates);
indexs=setdiff(orgl_ind,i);
duplicates=unique(duplicates,'stable');
end