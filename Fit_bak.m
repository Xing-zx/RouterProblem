function [fitness,flag] = Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%�ɼ��Զ������ɼ��Զ���������ʱ��ʱ�Ӷ��������ѣ�ת�������ȵȡ�
%�ɳ��Զ������ɳ��Զ������������ʣ��ɿ��Եȵ�
%��С�Զ�������С�Զ������������
% Cost	�ߵķ����ڽӾ���
% Delay	�ߵ�ʱ���ڽӾ���
% DelayJitter	�ߵ���ʱ�����ڽӾ���
% PacketLoss	�ߵĶ������ڽӾ���
% QoSD	��ʱ��  QoS Լ��
% QoSDJ	��ʱ������	QoS Լ��
% QoSPL	�����ʵ�	QoS Լ��
% Alpha	��Ӧֵ����ʽ�з��õ�ϵ��
% Beta	��Ӧֵ����ʽ����ʱ��ϵ��
% Gamma	��Ӧֵ����ʽ����ʱ������ϵ��
% Delta	��Ӧֵ����ʽ�ж����ʵ�ϵ��
     all_cost = 0;
     obj_delay = zeros(1,size(length(Route)));
     obj_delayjitter = zeros(1,size(length(Route)));
     obj_packetloss = zeros(1,size(length(Route)));
     for i = 1:length(Route)
         delay = 0;
         packetloss = 1;
         delayjitter = 0;
         for j = 1:length(Route{i})-1
             if ~isinf(Cost(Route{i}(j),Route{i}(j+1))) 
                 all_cost = all_cost+ Cost(Route{i}(j),Route{i}(j+1));
             end
             
             if ~isinf(Delay(Route{i}(j),Route{i}(j+1))) 
               delay = delay+ Delay(Route{i}(j),Route{i}(j+1));
             end
             if ~isinf(DelayJitter(Route{i}(j),Route{i}(j+1))) 
               delayjitter = delayjitter+ DelayJitter(Route{i}(j),Route{i}(j+1));
             end
             if ~isinf(PacketLoss(Route{i}(j),Route{i}(j+1))) 
               packetloss = packetloss* PacketLoss(Route{i}(j),Route{i}(j+1));
             end
         end
         obj_delay(i) = delay;
         obj_delayjitter(i) = delayjitter;
         obj_packetloss(i) = packetloss;
     end
     
         
     part_delay = penality(obj_delay,QoSD);
         
     part_delayjitter = penality(obj_delayjitter,QoSDJ);
         
     part_packetloss = penality(obj_PacketLoss,QoSPL);
         
         
     
     part_delay = Beta * prod(part_delay);
     
     part_delayjitter = Gamma * prod(part_delayjitter);
     
     part_packetloss = Delta * prod(part_packetloss);
     
     fitness = Alpha / all_cost * part_delay * part_delayjitter * part_packetloss;
    
     return;
        

end

function n = penality(parm,penal)

    len = length(parm);
    m = parm - penal;
    for i = 1: len
        n(i) = fun_z(m(i));
    end

end
function z = fun_z(a)

    if a>0
        z = 0.7;
    else
        z = 1;
    end
end

