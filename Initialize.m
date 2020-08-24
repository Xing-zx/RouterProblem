function [Routes] = Initialize(S,E,AM,P)
    %INITIALIZE 初始化种群
    %   此处显示详细说明
    Routes=cell(P,1);
    for i=1:P
        tree=InitializeTree(S,E,AM);
        Routes{i,1} = tree;
    end
end

