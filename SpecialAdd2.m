function newRoute=SpecialAdd2(Route,OptRoute,r)
%Route 个体 cell(1,2)结构
%OptRoute1 历史或全局最优
% r1 单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
% r2 粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
E=2;
   if rand(1) <r
       R=randi(length(Route{1,1}),1)%右边的位置
       L =randi(R,1)%左边位置
       %Lopt=find(OptRoute{1,1}==L);
       %Ropt=find(OptRoute{1,1}==R);
       
        part1 =OptRoute{1,1}(L:R);
        part2 =OptRoute{1,2}(L:R);
%         Route{1,1} = [Route{1,1}(1:L),part1,Route{1,1}(R:end)];
        remain=setdiff(Route{1,1}, part1,'stable') ;
        newRoute{1,1} = [remain(1:L-1),part1,remain(L:end)];
        newRoute{1,2} = [Route{1,2}(1:L-1),part2,Route{1,2}(R+1:end)];

   end
end
function Part=SelectPart(Tree,Target)
    %
    C=Tree{1,1}; %顺序结点
    P=Tree{1,2}; %双亲结点
    %随机选择一个目标结点
    T=Target(randi(length(Target),1));
    dividePoint =ismember(Target,Tree)
end




