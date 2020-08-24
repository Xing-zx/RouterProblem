%% 路径初始化
% 返回 cell{p}
B=rand(10,10);
AM=round(B);


function Track=Initialize(AM,s,P)
    global Paths;% 路径集
    global maxPathNum;%最大路径条数
    global pathNum;
    
    Paths =cell(P,1);
    maxPathNum=P; 
    pathNum=0;
    nextNode = find(AM(s,:) ==1);
    for j =nextNode
        Paths{i}=[ Paths{i},j];
        Paths(cur) =dfs(AM,i,Paths);
        cur++;
    end


end
function path=dfs(AM,s,t)
    if s==t || pathNum ==maxPathNum
        return;
    end
    nextNode = find(AM(s,:)==1);
    for i =nextNode
        cur++;
    end
end


%% 路径去重
function Route=Fresh(Route)



end







%% 特殊相加算子
function Route=SpecialAdd(Route,OptRoute)
%Route 个体
%OptRoute1 历史或全局最优
% r1 单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
% r2 粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
    R=randi(length(Route),1); %右边的位置
    L =randi(R,1);%左边位置
    Lopt=find(OptRoute==L);
    Ropt=find(OptRoute==R);
    if isempty(Lopt) && isempty(Ropt)
        return;
    end
    part =OptRoute(Lopt:Ropt);
    Route = [Route(1:L),part,Route(R,end)];
end



%% 随机寻游
function Route=RandMove(Route,r3,AM)



end