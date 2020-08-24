function [Sxy,AM]=NetCreate2(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf)
%% 改进的Salama博士的网络拓扑随机生成算法
%% 输入参数列表
% BorderLength-----正方形区域的边长，单位：km
% NodeAmount-------网络节点的个数
% Alpha------------网络特征参数，Alpha越大，短边相对长边的比例越大
% Beta-------------网络特征参数，Beta越大，边的密度越大
% PlotIf-----------是否画网络拓扑图，如果为1则画图，否则不画
% FlagIf-----------是否标注参数，如果为1则将标注边的参数，否则不标注
%% 输出参数列表
% Sxy--------------用于存储节点的序号，横坐标，纵坐标的矩阵
% AM---------------01存储的邻接矩阵，AM(i,j)=1表示存在由i到j的有向边
% Cost-------------用于存储边的费用的邻接矩阵，费用在[2,10]之间随机选取，无边的取无穷大
% Delay------------用于存储边的时延的邻接矩阵，时延等于边的距离除以三分之二光速，无边的取无穷大
% DelayJitter------用于存储边的延时抖动的邻接矩阵，在1～3微秒之间随机选取，无边的取无穷大
% PacketLoss-------用于存储边的丢包率，在0～0.01之间随机选取，无边的取无穷大
%% 参考参数设置
% [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(10,25,10,20,1,1)
%%
%参数初始化
NN=10*NodeAmount;
SSxy=zeros(NN,2);
%在正方形区域内随机均匀选取NN个节点
for i=1:NN
    SSxy(i,1)=BorderLength*rand;
    SSxy(i,2)=BorderLength*rand;
end
[IDX,C]=kmeans(SSxy,NodeAmount);
Sxy=[[1:NodeAmount]',C]';
%按横坐标由小到大的顺序重新为每一个节点编号
temp=Sxy;
Sxy2=Sxy(2,:);
Sxy2_sort=sort(Sxy2);
for i=1:NodeAmount
    pos=find(Sxy2==Sxy2_sort(i));
    if length(pos)>1
        error('仿真故障，请重试！');
    end
    temp(1,i)=i;
    temp(2,i)=Sxy(2,pos);
    temp(3,i)=Sxy(3,pos);
end
Sxy=temp;
%在节点间随机产生边，并构造延时矩阵和费用矩阵
AM=zeros(NodeAmount,NodeAmount);
Cost=zeros(NodeAmount,NodeAmount);
Delay=zeros(NodeAmount,NodeAmount);
DelayJitter=zeros(NodeAmount,NodeAmount);
PacketLoss=zeros(NodeAmount,NodeAmount);
for i=1:(NodeAmount-1)
    for j=(i+1):NodeAmount
        Distance=((Sxy(2,i)-Sxy(2,j))^2+(Sxy(3,i)-Sxy(3,j))^2)^0.5;
        P=Beta*exp(-Distance^5/(Alpha*BorderLength));
        if P>rand
            AM(i,j)=1;
            AM(j,i)=1;
            Delay(i,j)=0.5*Distance/100000;
            Delay(j,i)=Delay(i,j);
            Cost(i,j)=2+8*rand;
            Cost(j,i)=Cost(i,j);
            DelayJitter(i,j)=0.000001*(1+2*rand);
            DelayJitter(j,i)=DelayJitter(i,j);
            PacketLoss(i,j)=0.01*rand;
            PacketLoss(j,i)=PacketLoss(i,j);
        else
            Delay(i,j)=inf;
            Delay(j,i)=inf;
            Cost(i,j)=inf;
            Cost(j,i)=inf;
            DelayJitter(i,j)=inf;
            DelayJitter(j,i)=inf;
            PacketLoss(i,j)=inf;
            PacketLoss(j,i)=inf;
        end
    end
end
end