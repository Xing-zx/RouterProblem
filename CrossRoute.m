function newTree=CrossRoute(Tree1,Tree2,Target)
    % ����Ŀ����·��
    paths1=decomposeTree(Tree1,Target);
    paths2=decomposeTree(Tree2,Target);
    %���ѡ��һ��Ŀ����
    T=randi(length(Target),1);
    %��paths2�еĸ�Ŀ����·���滻paths1��Ŀ����·��
    paths1{T,1}=paths2{T,1};
    paths1{T,2}=paths2{T,2};
    newTree=composeTree(paths1);
end

