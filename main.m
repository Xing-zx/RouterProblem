%% QoS�ಥ·�ɷ���������
%%��һ���������������˽ṹ
hold off
BorderLength=10;    %����������ı߳�����λ��km
NodeAmount=30;      %����ڵ�ĸ���
Alpha=10;           %��������������AlphaԽ�󣬶̱���Գ��ߵı���Խ��
Beta=5;            %��������������BetaԽ�󣬱ߵ��ܶ�Խ��
PlotIf=1;           %�Ƿ���������ͼ�����Ϊ1��ͼ�����򲻻�
FlagIf=0;           %�Ƿ��ע���������Ϊ1�򽫱�ע�ߵĲ�����0�� ����ע
[Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf);

%%�ڶ�����ʹ���㷨��������·�����洢���ݣ�������Ž������������
%%%%%%%%%%%%%%%%%  �� �� PSO ��  ��  ��  ��  ��  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S=[2];            %Դ�ڵ�ļ��ϣ��������洢
T=[25,27,29];       %Ŀ�Ľڵ�ļ��Σ��������洢
Alpha=1;            %��Ӧֵ����ʽ�з��õ�ϵ��
Beta=5e5;           %��Ӧֵ����ʽ����ʱ��ϵ��
Gamma=3e6;          %��Ӧֵ����ʽ����ʱ������ϵ��
Delta=1000;         %��Ӧֵ����ʽ�ж����ʵ�ϵ��
QoSD=10000;        %��ʱ��QoSԼ��
QoSDJ=100e-6;       %��ʱ������QoSԼ��
QoSPL=0.02;         %�����ʵ�QoSԼ��
% r1=0.1;             %�������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
% r2=0.3;             %����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
% r3=0.2;             %��������ζ���Ӱ��ϵ����0<=r3<=1��r3����Ϊ0����ʱ���ر�����ζ�����
P=10;               %���ӵĸ���
Q=20;               %��������

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



