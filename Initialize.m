function [Routes] = Initialize(S,E,AM,P)
    %INITIALIZE ��ʼ����Ⱥ
    %   �˴���ʾ��ϸ˵��
    Routes=cell(P,1);
    for i=1:P
        tree=InitializeTree(S,E,AM);
        Routes{i,1} = tree;
    end
end

