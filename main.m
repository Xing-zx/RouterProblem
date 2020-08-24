%% QoSѡ��·�ɵ�����Ⱥ�㷨����������

%%��һ���������������˽ṹ
BorderLength=10;    %����������ı߳�����λ��km
NodeAmount=30;      %����ڵ�ĸ���
Alpha=10;           %��������������AlphaԽ�󣬶̱���Գ��ߵı���Խ��
Beta=5;            %��������������BetaԽ�󣬱ߵ��ܶ�Խ��
PlotIf=1;           %�Ƿ���������ͼ�����Ϊ1��ͼ�����򲻻�
FlagIf=0;           %�Ƿ��ע���������Ϊ1�򽫱�ע�ߵĲ�����0�� ����ע
[Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf);

%%�ڶ�����ʹ������Ⱥ�㷨��������·�����洢���ݣ�������Ž������������
%%%%%%%%%%%%%%%%%  ��  ��  ��  ��  ��  ��  ��  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GreenSim�Ŷ�ԭ����Ʒ��ת����ע����http://blog.sina.com.cn/greensim��
S=[2,4];            %Դ�ڵ�ļ��ϣ��������洢
T=[25,27,29];       %Ŀ�Ľڵ�ļ��Σ��������洢
Alpha=1;            %��Ӧֵ����ʽ�з��õ�ϵ��
Beta=5e5;           %��Ӧֵ����ʽ����ʱ��ϵ��
Gamma=3e6;          %��Ӧֵ����ʽ����ʱ������ϵ��
Delta=1000;         %��Ӧֵ����ʽ�ж����ʵ�ϵ��
QoSD=100e-6;        %��ʱ��QoSԼ��
QoSDJ=100e-6;       %��ʱ������QoSԼ��
QoSPL=0.02;         %�����ʵ�QoSԼ��
r1=0.1;             %�������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
r2=0.3;             %����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
r3=0.2;             %��������ζ���Ӱ��ϵ����0<=r3<=1��r3����Ϊ0����ʱ���ر�����ζ�����
P=10;               %���ӵĸ���
Q=20;               %��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(S); %m=2
n=length(T); %n=3
AllRoutes=cell(m,1);%�����Ӿ�����ȫ��·��
AllFitness=cell(m,1);
HistoryBestRoutes=cell(m,1);%�����ӵ���ʷ����·��
HistoryBestFitness=cell(m,1);
AllBestRoutes=cell(m,1);%ȫ������·��
AllBestFitness=cell(m,1);
for i=1:m   %Դ�ڵ� 2��
%     for j=1:n  %Ŀ�Ľڵ� 3��
        s=S(i);
        [ROUTEst,FitFlag,HR,HFF,AR,AFF]=PSOUC(s,T,r1,r2,r3,P,Q,AM,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);
        AllRoutes{i}=ROUTEst;
        AllFitness{i}=FitFlag;
        HistoryBestRoutes{i}=HR;
        HistoryBestFitness{i}=HFF;
        AllBestRoutes{i}=AR;
        AllBestFitness{i}=AFF;
%     end
end



%�����������Ž��
SYZ=Inf;
FinalRoute=[];%���յ�����·��
FinalFitness=[];%���յ�����·�ɶ�Ӧ�Ĳ���
LearnCurve1=zeros(1,Q);%��������
LearnCurve2=zeros(1,Q);%��������
for q=1:Q
    TT=[];
    for i=1:m
%         for j=1:n
            ABR=HistoryBestRoutes{i}; %ΪԴ�ڵ�1��������ʷʱ�̵�·��
            ABF=HistoryBestFitness{i};%ԭΪi��j����ʷ����·����Ӧ��
            for p=1:P
                ABRq=ABR{p,q};%��q����������p�����Ӵ����������ʷ·��
                ABFq=ABF{p,q};
                TT=[TT,ABFq(1,1)];
                if ABFq(1,1)<SYZ
                    FinalRoute=ABRq;%���յ�����·����
                    FinalFitness=ABFq;
                    SYZ=ABFq(1,1);
                end
            end
%         end
    end
    figure(4)
    hold off
    Net_plot2(BorderLength,NodeAmount,Sxy,PlotIf,FinalRoute);
    LearnCurve1(q)=mean(TT);
    LearnCurve2(q)=min(TT);
end
figure(2)
plot(LearnCurve1,'bs-')
xlabel('��������')
ylabel('ƽ����Ӧֵ')
figure(3)
plot(LearnCurve2,'bs-')
xlabel('��������')
ylabel('����������Ӧֵ')

% function [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf)
% %% �Ľ���Salama��ʿ������������������㷨
% %% ��������б�
% % BorderLength-----����������ı߳�����λ��km
% % NodeAmount-------����ڵ�ĸ���
% % Alpha------------��������������AlphaԽ�󣬶̱���Գ��ߵı���Խ��
% % Beta-------------��������������BetaԽ�󣬱ߵ��ܶ�Խ��
% % PlotIf-----------�Ƿ���������ͼ�����Ϊ1��ͼ�����򲻻�
% % FlagIf-----------�Ƿ��ע���������Ϊ1�򽫱�ע�ߵĲ��������򲻱�ע
% %% ��������б�
% % Sxy--------------���ڴ洢�ڵ����ţ������꣬������ľ���
% % AM---------------01�洢���ڽӾ���AM(i,j)=1��ʾ������i��j�������
% % Cost-------------���ڴ洢�ߵķ��õ��ڽӾ��󣬷�����[2,10]֮�����ѡȡ���ޱߵ�ȡ�����
% % Delay------------���ڴ洢�ߵ�ʱ�ӵ��ڽӾ���ʱ�ӵ��ڱߵľ����������֮�����٣��ޱߵ�ȡ�����
% % DelayJitter------���ڴ洢�ߵ���ʱ�������ڽӾ�����1��3΢��֮�����ѡȡ���ޱߵ�ȡ�����
% % PacketLoss-------���ڴ洢�ߵĶ����ʣ���0��0.01֮�����ѡȡ���ޱߵ�ȡ�����
% %% �ο���������
% % [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(10,25,10,20,1,1)
% %%
% %������ʼ��
% NN=10*NodeAmount;
% SSxy=zeros(NN,2);
% %���������������������ѡȡNN���ڵ�
% for i=1:NN
%     SSxy(i,1)=BorderLength*rand;
%     SSxy(i,2)=BorderLength*rand;
% end
% [IDX,C]=kmeans(SSxy,NodeAmount);
% Sxy=[[1:NodeAmount]',C]';
% %����������С�����˳������Ϊÿһ���ڵ���
% temp=Sxy;
% Sxy2=Sxy(2,:);
% Sxy2_sort=sort(Sxy2);
% for i=1:NodeAmount
%     pos=find(Sxy2==Sxy2_sort(i));
%     if length(pos)>1
%         error('������ϣ������ԣ�');
%     end
%     temp(1,i)=i;
%     temp(2,i)=Sxy(2,pos);
%     temp(3,i)=Sxy(3,pos);
% end
% Sxy=temp;
% %�ڽڵ����������ߣ���������ʱ����ͷ��þ���
% AM=zeros(NodeAmount,NodeAmount);
% Cost=zeros(NodeAmount,NodeAmount);
% Delay=zeros(NodeAmount,NodeAmount);
% DelayJitter=zeros(NodeAmount,NodeAmount);
% PacketLoss=zeros(NodeAmount,NodeAmount);
% for i=1:(NodeAmount-1)
%     for j=(i+1):NodeAmount
%         Distance=((Sxy(2,i)-Sxy(2,j))^2+(Sxy(3,i)-Sxy(3,j))^2)^0.5;
%         P=Beta*exp(-Distance^5/(Alpha*BorderLength));
%         if P>rand
%             AM(i,j)=1;
%             AM(j,i)=1;
%             Delay(i,j)=0.5*Distance/100000;
%             Delay(j,i)=Delay(i,j);
%             Cost(i,j)=2+8*rand;
%             Cost(j,i)=Cost(i,j);
%             DelayJitter(i,j)=0.000001*(1+2*rand);
%             DelayJitter(j,i)=DelayJitter(i,j);
%             PacketLoss(i,j)=0.01*rand;
%             PacketLoss(j,i)=PacketLoss(i,j);
%         else
%             Delay(i,j)=inf;
%             Delay(j,i)=inf;
%             Cost(i,j)=inf;
%             Cost(j,i)=inf;
%             DelayJitter(i,j)=inf;
%             DelayJitter(j,i)=inf;
%             PacketLoss(i,j)=inf;
%             PacketLoss(j,i)=inf;
%         end
%     end
% end
% Net_plot(BorderLength,NodeAmount,Sxy,Cost,Delay,DelayJitter,PacketLoss,PlotIf,FlagIf);
% 
% end






