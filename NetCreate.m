function [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss,BandWidth]=NetCreate(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf)
%% �Ľ���Salama��ʿ������������������㷨

%% GreenSim�Ŷ�ԭ����Ʒ��ת����ע��

%% ����ԭ���߽��м����������뷢�ʼ���aihuacheng@gmail.com
%% ��������б�
% BorderLength-----����������ı߳�����λ��km
% NodeAmount-------����ڵ�ĸ���
% Alpha------------��������������AlphaԽ�󣬶̱���Գ��ߵı���Խ��
% Beta-------------��������������BetaԽ�󣬱ߵ��ܶ�Խ��
% PlotIf-----------�Ƿ���������ͼ�����Ϊ1��ͼ�����򲻻�
% FlagIf-----------�Ƿ��ע���������Ϊ1�򽫱�ע�ߵĲ��������򲻱�ע
%% ��������б�
% Sxy--------------���ڴ洢�ڵ����ţ������꣬������ľ���,��һ�д����ţ��ڶ��к����꣬������������
% AM---------------01�洢���ڽӾ���AM(i,j)=1��ʾ������i��j�������
% Cost-------------���ڴ洢�ߵķ��õ��ڽӾ��󣬷�����[2,10]֮�����ѡȡ���ޱߵ�ȡ�����
% Delay------------���ڴ洢�ߵ�ʱ�ӵ��ڽӾ���ʱ�ӵ��ڱߵľ����������֮�����٣��ޱߵ�ȡ�����
% DelayJitter------���ڴ洢�ߵ���ʱ�������ڽӾ�����5��15΢��֮�����ѡȡ���ޱߵ�ȡ�����
% PacketLoss-------���ڴ洢�ߵĶ����ʣ���0��0.01֮�����ѡȡ���ޱߵ�ȡ�����
% BandWidth--------���ڴ洢�ߵĴ����50-200kb/s֮�����������ޱߵ�ȡ�����
%% �ο���������
% [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(10,25,10,20,1,1)

%������ʼ��
NN=10*NodeAmount;
SSxy=zeros(NN,2);
%���������������������ѡȡNN���ڵ�
for i=1:NN
    SSxy(i,1)=BorderLength*rand;
    SSxy(i,2)=BorderLength*rand;
end
[IDX,C]=kmeans(SSxy,NodeAmount);
Sxy=[[1:NodeAmount]',C]';
%����������С�����˳������Ϊÿһ���ڵ���
temp=Sxy;
Sxy2=Sxy(2,:);
Sxy2_sort=sort(Sxy2); %����������������
for i=1:NodeAmount
    pos=find(Sxy2==Sxy2_sort(i)); %find()�����ҵ����Ԫ�ص��±�
    if length(pos)>1
        error('������ϣ������ԣ�');
    end
    temp(1,i)=i;
    temp(2,i)=Sxy(2,pos);
    temp(3,i)=Sxy(3,pos);
end
Sxy=temp;
%�ڽڵ����������ߣ���������ʱ����ͷ��þ���
AM=zeros(NodeAmount,NodeAmount);
Cost=zeros(NodeAmount,NodeAmount);
Delay=zeros(NodeAmount,NodeAmount);
DelayJitter=zeros(NodeAmount,NodeAmount);
PacketLoss=zeros(NodeAmount,NodeAmount);
BandWidth=zeros(NodeAmount,NodeAmount);

for i=1:(NodeAmount-1)
    for j=(i+1):NodeAmount
        Distance=((Sxy(2,i)-Sxy(2,j))^2+(Sxy(3,i)-Sxy(3,j))^2)^0.5;  %�����(x1-x2)^2+(y1-y2)^2��ƽ�������������ľ���
        P=Beta*exp(-Distance^5/(Alpha*BorderLength));
        if P>rand  && Distance<4
            AM(i,j)=1;
            AM(j,i)=1;
            Delay(i,j)=0.5*Distance/1000;
            Delay(j,i)=Delay(i,j);
            Cost(i,j)=2+8*rand;
            Cost(j,i)=Cost(i,j);
            DelayJitter(i,j)=0.000001*(5+10*rand);
            DelayJitter(j,i)=DelayJitter(i,j);
            PacketLoss(i,j)=0.01*rand;
            PacketLoss(j,i)=PacketLoss(i,j);
            BandWidth(i,j)=50+150*rand;
            BandWidth(j,i)=BandWidth(i,j);
        else
            Delay(i,j)=inf;
            Delay(j,i)=inf;
            Cost(i,j)=inf;
            Cost(j,i)=inf;
            DelayJitter(i,j)=inf;
            DelayJitter(j,i)=inf;
            PacketLoss(i,j)=inf;
            PacketLoss(j,i)=inf;
            BandWidth(i,j)=inf;
            BandWidth(j,i)=inf;
        end
    end
end
% Net_plot_text(BorderLength,NodeAmount,Sxy,Cost,Delay,DelayJitter,PacketLoss,PlotIf,FlagIf)

