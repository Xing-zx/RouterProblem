function [fitness,flag] = Fit(Route,Cost,Delay,DelayJitter,PacketLoss,QoSD,QoSDJ,QoSPL,Alpha,Beta,Gamma,Delta)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
%可加性度量：可加性度量包括延时，时延抖动，花费，转发跳数等等。
%可乘性度量：可乘性度量包括丢包率，可靠性等等
%最小性度量：最小性度量包括带宽等
% Cost	边的费用邻接矩阵
% Delay	边的时延邻接矩阵
% DelayJitter	边的延时抖动邻接矩阵
% PacketLoss	边的丢包率邻接矩阵
% QoSD	延时的  QoS 约束
% QoSDJ	延时抖动的	QoS 约束
% QoSPL	丢包率的	QoS 约束
% Alpha	适应值计算式中费用的系数
% Beta	适应值计算式中延时的系数
% Gamma	适应值计算式中延时抖动的系数
% Delta	适应值计算式中丢包率的系数
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

