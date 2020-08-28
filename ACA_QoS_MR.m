function [MRT,EDGES,cost]=ACA_QoS_MR(C,D,S,E,Dmax,K,M,Alpha,Beta,Gamma,Rho,Q)
%% Ant Colony Algorithm for QoS Multicast Routing
%  QoS�鲥·����Ⱥ�㷨
%% ��������б�
%  C            �����ڽӾ���N��N��
%  D            ��ʱ�ڽӾ���N��N��
%  S            Դ�ڵ�
%  E            �鲥Ŀ�Ľڵ㣨��������
%  Dmax         ��ʱԼ��
%  K            ����������ָ���ϳ������ٲ���
%  M            ���ϸ�����ÿһ�������ж��ٸ���
%  Alpha        ������Ϣ����Ҫ�̶ȵĲ���
%  Beta         ��������ʽ���ӣ����ã���Ҫ�̶ȵĲ���
%  Gamma        ��������ʽ���ӣ���ʱ����Ҫ�̶ȵĲ���
%  Tau          ��ʼ��Ϣ�ؾ���
%  Rho          ��Ϣ������ϵ��
%  Q            ��Ϣ������ǿ��ϵ��
%% ��������б�
%  MRT          �����鲥����01�ڽӾ����ʾ��
%  EDGES        �����鲥�����еı�
%  cost         �����鲥���ķ���
%%
%% ��һ����������ʼ��
M=18;
Alpha=1;
Beta=5;
Gamma=5;
Rho=0.5;
Q=1;
N=size(C,1);%����ڵ����ΪN
P=length(E);%Ŀ�Ľڵ����ΪM
MRT=zeros(N,N);
cost=inf;
ROUTES=cell(P,K,M);%��ϸ���ṹ�洢��ÿһ��Ŀ�Ľڵ��ÿһ����ÿһֻ���ϵ�����·��
DELAYS=inf*ones(P,K,M);%����ά����洢ÿ��ÿ���������е�����Ŀ�Ľڵ����ʱ
COSTS=inf*ones(P,K,M);%����ά����洢ÿ��ÿ���������е�����Ŀ�Ľڵ�ķ���
%% �ڶ�����������P��Ŀ�Ľڵ��K��������ʳ���ÿ���ɳ�Mֻ����
for p=1:P
    Tau=ones(N,N);
    for k=1:K
        for m=1:M
%%        ��������״̬��ʼ��
            W=S;%��ǰ�ڵ��ʼ��Ϊ��ʼ��
            Path=S;%����·�߳�ʼ��
            PD=0;%����·����ʱ��ʼ��
            PC=0;%����·�߷��ó�ʼ��
            TABU=ones(1,N);%���ɱ��ʼ��
            TABU(S)=0;%S�Ѿ��ڳ�ʼ���ˣ����Ҫ�ų�
            CC=C;%�����ڽӾ��󱸷�
            DD=D;%��ʱ�ڽӾ��󱸷�
%%        ���Ĳ�����һ������ǰ���Ľڵ�
            DW=DD(W,:);
            DW1=find(DW<inf);
            for j=1:length(DW1)
                if TABU(DW1(j))==0
                    DW(j)=inf;
                end
            end
            LJD=find(DW > 0 & DW < Inf);%��ѡ�ڵ㼯
            Len_LJD=length(LJD);%��ѡ�ڵ�ĸ���
%%        ��ʳֹͣ��������������ʳ�������������ͬ
            while (W~=E(p))&&(Len_LJD>=1)
%%            ���岽��ת�ֶķ�ѡ����һ����ô��
                PP=zeros(1,Len_LJD);
                for i=1:Len_LJD
                    PP(i)=(Tau(W,LJD(i))^Alpha)*(C(W,LJD(i))^Beta)*(D(W,LJD(i))^Gamma);
                end
                PP=PP/(sum(PP));%�������ʷֲ�
                Pcum=cumsum(PP);
                Select=find(Pcum>=rand);
                to_visit=LJD(Select(1));%��һ����Ҫǰ���Ľڵ�
%%            ��������״̬���ºͼ�¼
                Path=[Path,to_visit];%·������
                PD=PD+DD(W,to_visit);%·����ʱ�ۼ�
                PC=PC+CC(W,to_visit);%·�������ۼ�
                W=to_visit;%�����Ƶ���һ���ڵ�
                for kk=1:N
                    if TABU(kk)==0
                        CC(W,kk)=inf;
                        CC(kk,W)=inf;
                        DD(W,kk)=inf;
                        DD(kk,W)=inf;
                    end
                end
                TABU(W)=0;%�ѷ��ʹ��Ľڵ�ӽ��ɱ���ɾ��
                DW=DD(W,:);
                DW1=find(DW<inf);
                for j=1:length(DW1)
                    if TABU(DW1(j))==0
                        DW(j)=inf;
                    end
                end
                LJD=find(DW<inf & DW >0);%��ѡ�ڵ㼯
                Len_LJD=length(LJD);%��ѡ�ڵ�ĸ���
%%
            end
%%         ���߲�������ÿһ��ÿһֻ���ϵ���ʳ·�ߺ�·�߳���
            ROUTES{p,k,m}=Path;
            if Path(end)==E(p)&&PD<=Dmax
                DELAYS(p,k,m)=PD;
                COSTS(p,k,m)=PC;
            else
                DELAYS(p,k,m)=inf;
                COSTS(p,k,m)=inf;
            end
        end
%%     �ڰ˲���������Ϣ��
        Delta_Tau=zeros(N,N);%��������ʼ��
        for m=1:M
            if COSTS(p,k,m)<inf&&DELAYS(p,k,m)<Dmax
                ROUT=ROUTES{p,k,m};
                TS=length(ROUT)-1;%����
                Cpkm=COSTS(p,k,m);
                for s=1:TS
                    x=ROUT(s);
                    y=ROUT(s+1);
                    Delta_Tau(x,y)=Delta_Tau(x,y)+Q/Cpkm;
                    Delta_Tau(y,x)=Delta_Tau(y,x)+Q/Cpkm;
                end
            end
        end
        Tau=(1-Rho).*Tau+Delta_Tau;%��Ϣ�ػӷ�һ���֣�������һ����
    end
end
%% �ھŲ�������������
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
%% ����������
figure(3)
%M ���ϸ���
%K ��������
%p Ŀ��ڵ����
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
legend('����','��ʱ')
title('·���ķ�����ʱ�仯���')
figure(2)
plot(allcost,'b-')
title('�鲥��������������')
