%% QoS多播路由仿真主函数
%%第一步：产生网络拓扑结构
hold off
BorderLength=10;    %正方形区域的边长，单位：km
NodeAmount=30;      %网络节点的个数
Alpha=10;           %网络特征参数，Alpha越大，短边相对长边的比例越大
Beta=5;            %网络特征参数，Beta越大，边的密度越大
PlotIf=1;           %是否画网络拓扑图，如果为1则画图，否则不画
FlagIf=0;           %是否标注参数，如果为1则将标注边的参数，0是 不标注
[Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf);

%%第二步：使用算法搜索最优路径，存储数据，输出最优结果和收敛曲线
%%%%%%%%%%%%%%%%%  以 下 PSO 是  参  数  设  置  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S=[2];            %源节点的集合，用向量存储
T=[25,27,29];       %目的节点的几何，用向量存储
Alpha=1;            %适应值计算式中费用的系数
Beta=5e5;           %适应值计算式中延时的系数
Gamma=3e6;          %适应值计算式中延时抖动的系数
Delta=1000;         %适应值计算式中丢包率的系数
QoSD=10000;        %延时的QoS约束
QoSDJ=100e-6;       %延时抖动的QoS约束
QoSPL=0.02;         %丢包率的QoS约束
% r1=0.1;             %单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
% r2=0.3;             %粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
% r3=0.2;             %粒子随机游动的影响系数，0<=r3<=1，r3可以为0，这时将关闭随机游动功能
P=10;               %粒子的个数
Q=20;               %迭代次数

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% algorithms=['NSGAII','MOPSO'];
% for name=algorithms   
%    algorithm=str2func(char(name));
%    algorithm();
%    
% end
%    [Pop,Fitness]=GA_Qos_MR(S,T,AM,P);
%    Best=Pop(find(Fitness==min(Fitness),1),:);
%    figure(2)
%    Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,1,Best)
M=18;
Dmax=100e-2;
Alpha=1;
Beta=5;
Gamma=5;
Rho=0.5;
Q=1;
[MRT,EDGES,cost]=ACA_QoS_MR(Cost,Delay,S,T,QoSD,Q);
figure(2)
 Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,0,MRT)



