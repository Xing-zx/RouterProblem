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
Rho =0.7;
for i=1:m   %Դ�ڵ� 2��
%     for j=1:n  %Ŀ�Ľڵ� 3��
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

%�����������Ž��
% SYZ=Inf;
% FinalRoute=[];%���յ�����·��
% FinalFitness=[];%���յ�����·�ɶ�Ӧ�Ĳ���
% LearnCurve1=zeros(1,Q);%��������
% LearnCurve2=zeros(1,Q);%��������
% for q=1:Q
%     TT=[];
%     for i=1:m
% %         for j=1:n
%             ABR=HistoryBestRoutes{i}; %ΪԴ�ڵ�1��������ʷʱ�̵�·��
%             ABF=HistoryBestFitness{i};%ԭΪi��j����ʷ����·����Ӧ��
%             for p=1:P
%                 ABRq=ABR{p,q};%��q����������p�����Ӵ����������ʷ·��
%                 ABFq=ABF{p,q};
%                 TT=[TT,ABFq(1,1)];
%                 if ABFq(1,1)<SYZ
%                     FinalRoute=ABRq;%���յ�����·����
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
% xlabel('��������')
% ylabel('ƽ����Ӧֵ')
% figure(3)
% plot(LearnCurve2,'bs-')
% xlabel('��������')
% ylabel('����������Ӧֵ')




