function newRoute=SpecialAdd2(Route,OptRoute,r)
%Route ���� cell(1,2)�ṹ
%OptRoute1 ��ʷ��ȫ������
% r1 �������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
% r2 ����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
E=2;
   if rand(1) <r
       R=randi(length(Route{1,1}),1)%�ұߵ�λ��
       L =randi(R,1)%���λ��
       %Lopt=find(OptRoute{1,1}==L);
       %Ropt=find(OptRoute{1,1}==R);
       
        part1 =OptRoute{1,1}(L:R);
        part2 =OptRoute{1,2}(L:R);
%         Route{1,1} = [Route{1,1}(1:L),part1,Route{1,1}(R:end)];
        remain=setdiff(Route{1,1}, part1,'stable') ;
        newRoute{1,1} = [remain(1:L-1),part1,remain(L:end)];
        newRoute{1,2} = [Route{1,2}(1:L-1),part2,Route{1,2}(R+1:end)];

   end
end
function Part=SelectPart(Tree,Target)
    %
    C=Tree{1,1}; %˳����
    P=Tree{1,2}; %˫�׽��
    %���ѡ��һ��Ŀ����
    T=Target(randi(length(Target),1));
    dividePoint =ismember(Target,Tree)
end




