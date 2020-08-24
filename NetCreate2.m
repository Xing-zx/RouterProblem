function [Sxy,AM]=NetCreate2(BorderLength,NodeAmount,Alpha,Beta,PlotIf,FlagIf)
%% �Ľ���Salama��ʿ������������������㷨
%% ��������б�
% BorderLength-----����������ı߳�����λ��km
% NodeAmount-------����ڵ�ĸ���
% Alpha------------��������������AlphaԽ�󣬶̱���Գ��ߵı���Խ��
% Beta-------------��������������BetaԽ�󣬱ߵ��ܶ�Խ��
% PlotIf-----------�Ƿ���������ͼ�����Ϊ1��ͼ�����򲻻�
% FlagIf-----------�Ƿ��ע���������Ϊ1�򽫱�ע�ߵĲ��������򲻱�ע
%% ��������б�
% Sxy--------------���ڴ洢�ڵ����ţ������꣬������ľ���
% AM---------------01�洢���ڽӾ���AM(i,j)=1��ʾ������i��j�������
% Cost-------------���ڴ洢�ߵķ��õ��ڽӾ��󣬷�����[2,10]֮�����ѡȡ���ޱߵ�ȡ�����
% Delay------------���ڴ洢�ߵ�ʱ�ӵ��ڽӾ���ʱ�ӵ��ڱߵľ����������֮�����٣��ޱߵ�ȡ�����
% DelayJitter------���ڴ洢�ߵ���ʱ�������ڽӾ�����1��3΢��֮�����ѡȡ���ޱߵ�ȡ�����
% PacketLoss-------���ڴ洢�ߵĶ����ʣ���0��0.01֮�����ѡȡ���ޱߵ�ȡ�����
%% �ο���������
% [Sxy,AM,Cost,Delay,DelayJitter,PacketLoss]=NetCreate(10,25,10,20,1,1)
%%
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
Sxy2_sort=sort(Sxy2);
for i=1:NodeAmount
    pos=find(Sxy2==Sxy2_sort(i));
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