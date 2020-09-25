function Offspring = GA_route(Parent,T)
    %% Genetic operators for permutation based encoding
    % Order crossover
    % 划分目标结点路径
    Parent1 = Parent(1:floor(end/2),:);
    Parent2 = Parent(floor(end/2)+1:floor(end/2)*2,:);
    [N,D]   = size(Parent1);
    Offspring = [Parent1;Parent2];
    %% 交叉
    for i = 1 : N
        Offspring(i,:)   =CrossRoute(Parent1(i,:),Parent2(i,:),T);
        Offspring(i+N,:) =CrossRoute(Parent2(i,:),Parent1(i,:),T);
     end
    %% 变异
    
end