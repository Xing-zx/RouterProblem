function newTree=CrossRoute(Tree1,Tree2,Target)
    % 划分目标结点路径
    paths1=decomposeTree(Tree1,Target);
    paths2=decomposeTree(Tree2,Target);
    %随机选择一个目标结点
    T=randi(length(Target),1);
    %将paths2中的该目标结点路径替换paths1的目标结点路径
    paths1{T,1}=paths2{T,1};
    paths1{T,2}=paths2{T,2};
    newTree=composeTree(paths1);
end

