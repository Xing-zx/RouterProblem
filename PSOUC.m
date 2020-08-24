function [ROUTEst,FitFlag,HR,HFF,AR,AFF]=PSOUC(s,t,r1,r2,r3,P,Q,AM,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta)
%% 使用粒子群算法求源节点s到目的节点t的满足QoS约束的最小费用路径，将这些路径及其参数记录下来
%% 输入参数列表
% s            单个的源节点
% t            单个的目的节点
% r1           单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
% r2           粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
% r3           粒子随机游动的影响系数，0<=r3<=1，r3可以为0，这时将关闭随机游动功能
% P            粒子的个数
% Q            迭代次数
% AM           01形式存储的邻接矩阵
% Cost         边的费用邻接矩阵
% Delay        边的时延邻接矩阵
% DelayJitter  边的延时抖动邻接矩阵
% PacketLoss   边的丢包率邻接矩阵
% QoSD         延时的QoS约束
% QoSDJ        延时抖动的QoS约束
% QoSPL        丢包率的QoS约束
% Alpha        适应值计算式中费用的系数
% Beta         适应值计算式中延时的系数
% Gamma        适应值计算式中延时抖动的系数
% Delta        适应值计算式中丢包率的系数
%% 输出参数列表
% ROUTEst      P×Q的细胞结构，存储所有粒子经历过的从s到t的路径
% FitFlag      P×Q的细胞结构，存储与ROUTEst对应的Fitness和Flag数据
% HR           P×Q的细胞结构，存储所有粒子所有时刻的历史最优路径
% HFF          P×Q的细胞结构，存储所有粒子的历史最优路径对应的参数
% AR           1×Q的细胞结构，存储全局最优路径
% AFF          1×Q的细胞结构，存储所有时刻的全局最优路径对应的参数
%% 粒子群初始化
ROUTEst=cell(P,Q);  %存储所有粒子经历过的从s到t的路径
FitFlag=cell(P,Q);%存储与ROUTEst对应的Fitness和Flag数据
HR=cell(P,Q);%各粒子的历史最优路径
HFF=cell(P,Q);%各粒子的历史最优路径对应的参数
AR=cell(1,Q);%全局最优路径
AFF=cell(1,Q);%全局最优路径对应的参数
%% 种群初始化
TRACK=Initialize(s,t,AM,P);
for p=1:P
    Route=TRACK{p}; 
    ROUTEst{p,1}=Route;
    HR{p,1}=Route;
    [Fitness,Flag]=Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);
    FitFlag{p,1}=[Fitness;Flag];
    HFF{p,1}=[Fitness;Flag];
end
%% 全局最优初始化
SYZ=Inf;
for p=1:P
    Route=HR{p,1};
    FF=HFF{p,1};
    if FF(1,1)<SYZ
        AR{1}=Route;
        SYZ=FF(1,1);
        AFF{1}=FF;
    end
end
%%
for q=2:Q
    %按照粒子群迭代公式计算各个粒子的下一个位置
    for p=1:P
        Route=ROUTEst{p,q-1};
        OptRoute1=HR{p,q-1}; %历史最优
        OptRoute2=AR{1,q-1}; %全局最优
        Route=CrossRoute(Route,OptRoute1,t);%向自己的历史最优位置靠近，Cost为费用矩阵
        Route=CrossRoute(Route,OptRoute2,t);%向全局历史最优位置靠近，Cost为费用矩阵
        Route=CrossRoute(Route,ROUTEst{randi(P,1),q-1},t);%随机游动
        [Fitness,Flag]=Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);
        ROUTEst{p,q}=Route;
        FitFlag{p,q}=[Fitness;Flag];
    end
    %更新各粒子的历史最优位置
    for p=1:P
        F1=HFF{p,q-1};
        F2=FitFlag{p,q};
        if F2(1,1)<F1(1,1)
            HR{p,q}=ROUTEst{p,q};
            HFF{p,q}=FitFlag{p,q};
        else
            HR{p,q}=HR{p,q-1};
            HFF{p,q}=HFF{p,q-1};
        end
    end
    %更新全局历史最优位置
    for p=1:P
        Route=HR{p,q};
        FF=HFF{p,q};
        if FF(1,1)<SYZ&&FF(2,1)==1
            AR{q}=Route;
            SYZ=FF(1,1);
            AFF{q}=FF;
        else
            AR{q}=AR{q-1};
            AFF{q}=AFF{q-1};
        end
    end
end
end
