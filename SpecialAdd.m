function Route=SpecialAdd(Route,OptRoute,r)
%Route 个体
%OptRoute1 历史或全局最优
% r1 单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
% r2 粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
    
   Lopt=[];
   Ropt=[];
   if rand(1) <r
        while isempty(Lopt) || isempty(Ropt) || L>=R
            R=randi(length(Route),1); %右边的位置
            L =randi(R,1);%左边位置
            Lopt=find(OptRoute==L);
            Ropt=find(OptRoute==R);
        end
        part =OptRoute(Lopt:Ropt);
        Route = [Route(1:L),part,Route(R:end)];
   end
end