function Route=SpecialAdd(Route,OptRoute,r)
%Route ����
%OptRoute1 ��ʷ��ȫ������
% r1 �������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
% r2 ����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
    
   Lopt=[];
   Ropt=[];
   if rand(1) <r
        while isempty(Lopt) || isempty(Ropt) || L>=R
            R=randi(length(Route),1); %�ұߵ�λ��
            L =randi(R,1);%���λ��
            Lopt=find(OptRoute==L);
            Ropt=find(OptRoute==R);
        end
        part =OptRoute(Lopt:Ropt);
        Route = [Route(1:L),part,Route(R:end)];
   end
end