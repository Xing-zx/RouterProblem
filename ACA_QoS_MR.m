function [MRT,EDGES,cost]=ACA_QoS_MR(C,D,S,E,Dmax,K,M,Alpha,Beta,Gamma,Rho,Q)
%% Ant Colony Algorithm for QoS Multicast Routing
%  QoS组播路由蚁群算法
%% 输入参数列表
%  C            费用邻接矩阵（N×N）
%  D            延时邻接矩阵（N×N）
%  S            源节点
%  E            组播目的节点（行向量）
%  Dmax         延时约束
%  K            迭代次数（指蚂蚁出动多少波）
%  M            蚂蚁个数（每一波蚂蚁有多少个）
%  Alpha        表征信息素重要程度的参数
%  Beta         表征启发式因子（费用）重要程度的参数
%  Gamma        表征启发式因子（延时）重要程度的参数
%  Tau          初始信息素矩阵
%  Rho          信息素蒸发系数
%  Q            信息素增加强度系数
%% 输出参数列表
%  MRT          最优组播树（01邻接矩阵表示）
%  EDGES        最优组播树所有的边
%  cost         最优组播树的费用
%%
%% 第一步：变量初始化
M=18;
Alpha=1;
Beta=5;
Gamma=5;
Rho=0.5;
Q=1;
N=size(C,1);%网络节点个数为N
P=length(E);%目的节点个数为M
MRT=zeros(N,N);
cost=inf;
ROUTES=cell(P,K,M);%用细胞结构存储到每一个目的节点的每一代的每一只蚂蚁的爬行路线
DELAYS=inf*ones(P,K,M);%用三维数组存储每代每个蚂蚁爬行到各个目的节点的延时
COSTS=inf*ones(P,K,M);%用三维数组存储每代每个蚂蚁爬行到各个目的节点的费用
%% 第二步：启动到P个目的节点的K轮蚂蚁觅食活动，每轮派出M只蚂蚁
for p=1:P
    Tau=ones(N,N);
    for k=1:K
        for m=1:M
%%        第三步：状态初始化
            W=S;%当前节点初始化为起始点
            Path=S;%爬行路线初始化
            PD=0;%爬行路线延时初始化
            PC=0;%爬行路线费用初始化
            TABU=ones(1,N);%禁忌表初始化
            TABU(S)=0;%S已经在初始点了，因此要排除
            CC=C;%费用邻接矩阵备份
            DD=D;%延时邻接矩阵备份
%%        第四步：下一步可以前往的节点
            DW=DD(W,:);
            DW1=find(DW<inf);
            for j=1:length(DW1)
                if TABU(DW1(j))==0
                    DW(j)=inf;
                end
            end
            LJD=find(DW > 0 & DW < Inf);%可选节点集
            Len_LJD=length(LJD);%可选节点的个数
%%        觅食停止条件：蚂蚁遇到食物或者陷入死胡同
            while (W~=E(p))&&(Len_LJD>=1)
%%            第五步：转轮赌法选择下一步怎么走
                PP=zeros(1,Len_LJD);
                for i=1:Len_LJD
                    PP(i)=(Tau(W,LJD(i))^Alpha)*(C(W,LJD(i))^Beta)*(D(W,LJD(i))^Gamma);
                end
                PP=PP/(sum(PP));%建立概率分布
                Pcum=cumsum(PP);
                Select=find(Pcum>=rand);
                to_visit=LJD(Select(1));%下一步将要前往的节点
%%            第六步：状态更新和记录
                Path=[Path,to_visit];%路径增加
                PD=PD+DD(W,to_visit);%路径延时累计
                PC=PC+CC(W,to_visit);%路径费用累计
                W=to_visit;%蚂蚁移到下一个节点
                for kk=1:N
                    if TABU(kk)==0
                        CC(W,kk)=inf;
                        CC(kk,W)=inf;
                        DD(W,kk)=inf;
                        DD(kk,W)=inf;
                    end
                end
                TABU(W)=0;%已访问过的节点从禁忌表中删除
                DW=DD(W,:);
                DW1=find(DW<inf);
                for j=1:length(DW1)
                    if TABU(DW1(j))==0
                        DW(j)=inf;
                    end
                end
                LJD=find(DW<inf & DW >0);%可选节点集
                Len_LJD=length(LJD);%可选节点的个数
%%
            end
%%         第七步：记下每一代每一只蚂蚁的觅食路线和路线长度
            ROUTES{p,k,m}=Path;
            if Path(end)==E(p)&&PD<=Dmax
                DELAYS(p,k,m)=PD;
                COSTS(p,k,m)=PC;
            else
                DELAYS(p,k,m)=inf;
                COSTS(p,k,m)=inf;
            end
        end
%%     第八步：更新信息素
        Delta_Tau=zeros(N,N);%更新量初始化
        for m=1:M
            if COSTS(p,k,m)<inf&&DELAYS(p,k,m)<Dmax
                ROUT=ROUTES{p,k,m};
                TS=length(ROUT)-1;%跳数
                Cpkm=COSTS(p,k,m);
                for s=1:TS
                    x=ROUT(s);
                    y=ROUT(s+1);
                    Delta_Tau(x,y)=Delta_Tau(x,y)+Q/Cpkm;
                    Delta_Tau(y,x)=Delta_Tau(y,x)+Q/Cpkm;
                end
            end
        end
        Tau=(1-Rho).*Tau+Delta_Tau;%信息素挥发一部分，新增加一部分
    end
end
%% 第九步：整理输出结果
MINCOSTS=NaN*ones(1,K);
allcost=zeros(1,0);
for k=1:K
    for m=1:M
        COSTkm=COSTS(:,k,m);
        DELAYkm=DELAYS(:,k,m);
        if sum(COSTkm)<inf&&sum(DELAYkm)<inf
            Tree=zeros(N,N);
            for p=1:P
                path=ROUTES{p,k,m};
                RLen=length(path);
                for i=1:(RLen-1)
                    Tree(path(i),path(i+1))=1;
                    Tree(path(i+1),path(i))=1;
                end
            end
            TC=Tree.*C;
            for ii=1:N
                for jj=1:N
                    if isnan(TC(ii,jj))
                        TC(ii,jj)=0;
                    end
                end
            end
            mincost=0.5*sum(sum(TC));
            if mincost<cost
                MINCOSTS(1,k)=mincost;
                MRT=Tree;
                cost=mincost;
            end
            allcost=[allcost,cost];
        end
    end
end
MM=triu(MRT);
T1=find(MM==1);
T2=ceil(T1/N);
T3=mod(T1,N);
EDGES=[T3,T2];
%% 绘收敛曲线
figure(3)
%M 蚂蚁个数
%K 迭代次数
%p 目标节点个数
COSTS2=zeros(M,K,P);
DELAYS2=zeros(M,K,P);
for p=1:P
    for k=1:K
        for m=1:M
            if COSTS(p,k,m)<inf
                COSTS2(m,k,p)=COSTS(p,k,m);
                DELAYS2(m,k,p)=DELAYS(p,k,m);
            end
        end
    end
end
LC1=zeros(1,K);
LC2=zeros(1,K);
for k=1:K
    costs=COSTS2(:,k,1);
    delays=DELAYS2(:,k,1);
    pos1=find(costs>0);
    pos2=find(delays>0);
    len1=length(pos1);
    len2=length(pos2);
    LC1(k)=sum(costs)/len1;
    LC2(k)=sum(delays)/len2*10000;
end
plot(LC1,'ko-');
hold on
plot(LC2,'bs-');
legend('费用','延时')
title('路径的费用延时变化情况')
figure(2)
plot(allcost,'b-')
title('组播树费用收敛曲线')
