function [ROUTEst,FitFlag,HR,HFF,AR,AFF]=PSOUC(s,t,r1,r2,r3,P,Q,AM,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta)
%% ʹ������Ⱥ�㷨��Դ�ڵ�s��Ŀ�Ľڵ�t������QoSԼ������С����·��������Щ·�����������¼����
%% ��������б�
% s            ������Դ�ڵ�
% t            ������Ŀ�Ľڵ�
% r1           �������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
% r2           ����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
% r3           ��������ζ���Ӱ��ϵ����0<=r3<=1��r3����Ϊ0����ʱ���ر�����ζ�����
% P            ���ӵĸ���
% Q            ��������
% AM           01��ʽ�洢���ڽӾ���
% Cost         �ߵķ����ڽӾ���
% Delay        �ߵ�ʱ���ڽӾ���
% DelayJitter  �ߵ���ʱ�����ڽӾ���
% PacketLoss   �ߵĶ������ڽӾ���
% QoSD         ��ʱ��QoSԼ��
% QoSDJ        ��ʱ������QoSԼ��
% QoSPL        �����ʵ�QoSԼ��
% Alpha        ��Ӧֵ����ʽ�з��õ�ϵ��
% Beta         ��Ӧֵ����ʽ����ʱ��ϵ��
% Gamma        ��Ӧֵ����ʽ����ʱ������ϵ��
% Delta        ��Ӧֵ����ʽ�ж����ʵ�ϵ��
%% ��������б�
% ROUTEst      P��Q��ϸ���ṹ���洢�������Ӿ������Ĵ�s��t��·��
% FitFlag      P��Q��ϸ���ṹ���洢��ROUTEst��Ӧ��Fitness��Flag����
% HR           P��Q��ϸ���ṹ���洢�������ӵ���ʷ����·��
% HFF          P��Q��ϸ���ṹ���洢�������ӵ���ʷ����·����Ӧ�Ĳ���
% AR           1��Q��ϸ���ṹ���洢ȫ������·��
% AFF          1��Q��ϸ���ṹ���洢ȫ������·����Ӧ�Ĳ���
%% ����Ⱥ��ʼ��
ROUTEst=cell(P,Q);  %�洢�������Ӿ������Ĵ�s��t��·����ÿһ����Q��·��������ͬ������ÿһ����P��·��������ͬ���ӡ�
FitFlag=cell(P,Q);%�洢��ROUTEst��Ӧ��Fitness��Flag����
HR=cell(P,Q);%�����ӵ���ʷ����·��
HFF=cell(P,Q);%�����ӵ���ʷ����·����Ӧ�Ĳ���
AR=cell(1,Q);%ȫ������·��
AFF=cell(1,Q);%ȫ������·����Ӧ�Ĳ���
TRACK=Initialize(AM,s,P);% track Ӧ����һ��sΪ����P��·����δʵ�֣�
%����·����ʼ��
for p=1:P
    Route=TRACK{p};%��p��·��
    pos=find(Route==t);%�ҵ�·������t��·��
    Route=Route(1:pos(1));%��ȡs��t��·��Ƭ��
    Route=Fresh(Route); % Fresh ??�²⣺ɾ���ظ��ڵ㡣��δʵ�֣�
    ROUTEst{p,1}=Route;%�������Ӵ����·����
    HR{p,1}=Route;%������ʷ·��
    [Fitness,Flag]=Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);%������Ӧ��
    FitFlag{p,1}=[Fitness;Flag];%Flag ����
    HFF{p,1}=[Fitness;Flag];%��ʷ��������Ӧ�Ⱥͱ��
end
SYZ=Inf;
% ȫ�����ų�ʼ��
for p=1:P
    Route=HR{p,1};
    FF=HFF{p,1};
    if FF(1,1)<SYZ
        AR{1}=Route;
        SYZ=FF(1,1);
        AFF{1}=FF;
    end
end
%%
for q=2:Q
    %��������Ⱥ������ʽ����������ӵ���һ��λ��
    for p=1:P
        Route=ROUTEst{p,q-1};
        OptRoute1=HR{p,q-1};
        OptRoute2=AR{1,q-1};
        Route=SpecialAdd(Route,OptRoute1,r1,Cost);%���Լ�����ʷ����λ�ÿ��� ��δʵ�֣�
        Route=SpecialAdd(Route,OptRoute2,r2,Cost);%��ȫ����ʷ����λ�ÿ��� ��δʵ�֣�
        Route=RandMove(Route,r3,AM);%����ζ� ��δʵ�֣�
        [Fitness,Flag]=Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta);��δʵ�֣�
        ROUTEst{p,q}=Route;
        FitFlag{p,q}=[Fitness;Flag];
    end
    %���¸����ӵ���ʷ����λ��
    for p=1:P
        F1=HFF{p,q-1};
        F2=FitFlag{p,q};
        if F2(1,1)<F1(1,1)
            HR{p,q}=ROUTEst{p,q};
            HFF{p,q}=FitFlag{p,q};
        else
            HR{p,q}=HR{p,q-1};
            HFF{p,q}=HFF{p,q-1};
        end
    end
    %����ȫ����ʷ����λ��
    for p=1:P
        Route=HR{p,q};
        FF=HFF{p,q};
        if FF(1,1)<SYZ&&FF(2,1)==1
            AR{q}=Route;
            SYZ=FF(1,1);
            AFF{q}=FF;
        else
            AR{q}=AR{q-1};
            AFF{q}=AFF{q-1};
        end
    end
end
end
