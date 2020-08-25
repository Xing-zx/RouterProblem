%% QoS选播路由的粒子群算法仿真主函数

%%第一步：产生网络拓扑结构
BorderLength=10;    %正方形区域的边长，单位：km
NodeAmount=30;      %网络节点的个数
Alpha=10;           %网络特征参数，Alpha越大，短边相对长边的比例越大
Beta=5;            %网络特征参数，Beta越大，边的密度越大
PlotIf=1;           %是否画网络拓扑图，如果为1则画图，否则不画
FlagIf=0;           %是否标注参数，如果为1则将标注边的参数，0是 不标注
[Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf);

%%第二步：使用粒子群算法搜索最优路径，存储数据，输出最优结果和收敛曲线
%%%%%%%%%%%%%%%%%  以  下  是  参  数  设  置  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GreenSim团队原创作品，转载请注明（http://blog.sina.com.cn/greensim）
S=[2,4];            %源节点的集合，用向量存储
T=[25,27,29];       %目的节点的几何，用向量存储
Alpha=1;            %适应值计算式中费用的系数
Beta=5e5;           %适应值计算式中延时的系数
Gamma=3e6;          %适应值计算式中延时抖动的系数
Delta=1000;         %适应值计算式中丢包率的系数
QoSD=100e-6;        %延时的QoS约束
QoSDJ=100e-6;       %延时抖动的QoS约束
QoSPL=0.02;         %丢包率的QoS约束
r1=0.1;             %单个粒子的历史最优个体对当前粒子的影响系数，0<r1<=1
r2=0.3;             %粒子群的全局最优个体对当前粒子的影响系数，0<r2<=1
r3=0.2;             %粒子随机游动的影响系数，0<=r3<=1，r3可以为0，这时将关闭随机游动功能
P=10;               %粒子的个数
Q=20;               %迭代次数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(S); %m=2
n=length(T); %n=3
AllRoutes=cell(m,1);%各粒子经过的全部路径
AllFitness=cell(m,1);
HistoryBestRoutes=cell(m,1);%各粒子的历史最优路径
HistoryBestFitness=cell(m,1);
AllBestRoutes=cell(m,1);%全局最优路径
AllBestFitness=cell(m,1);
Rho =0.7;
for i=1:m   %源节点 2个
%     for j=1:n  %目的节点 3个
        s=S(i);
%         [ROUTEst,FitFlag,HR,HFF,AR,AFF]=PSOUC(s,T,r1,r2,r3,P,Q,AM,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);
        [MRT,EDGES,cost]=ACA_QoS_MR(Cost,Delay,s,T,QoSD,Q,P,5,5,5,0.7,0.7);
       
%         AllRoutes{i}=ROUTEst;
%         AllFitness{i}=FitFlag;
%         HistoryBestRoutes{i}=HR;
%         HistoryBestFitness{i}=HFF;
%         AllBestRoutes{i}=AR;
%         AllBestFitness{i}=AFF;
%     end
end


figure(4)
Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,0,MRT);

%下面整理最优结果
% SYZ=Inf;
% FinalRoute=[];%最终的最优路由
% FinalFitness=[];%最终的最优路由对应的参数
% LearnCurve1=zeros(1,Q);%收敛曲线
% LearnCurve2=zeros(1,Q);%收敛曲线
% for q=1:Q
%     TT=[];
%     for i=1:m
% %         for j=1:n
%             ABR=HistoryBestRoutes{i}; %为源节点1的所有历史时刻的路径
%             ABF=HistoryBestFitness{i};%原为i到j的历史最优路径适应度
%             for p=1:P
%                 ABRq=ABR{p,q};%第q个迭代，第p个粒子代表的最优历史路径
%                 ABFq=ABF{p,q};
%                 TT=[TT,ABFq(1,1)];
%                 if ABFq(1,1)<SYZ
%                     FinalRoute=ABRq;%最终的最优路径。
%                     FinalFitness=ABFq;
%                     SYZ=ABFq(1,1);
%                 end
%             end
% %         end
%     end
%     figure(4)
%     hold off
%     Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,FinalRoute);
%     LearnCurve1(q)=mean(TT);
%     LearnCurve2(q)=min(TT);
% end
% figure(2)
% plot(LearnCurve1,'bs-')
% xlabel('迭代次数')
% ylabel('平均适应值')
% figure(3)
% plot(LearnCurve2,'bs-')
% xlabel('迭代次数')
% ylabel('最优粒子适应值')




