%% ·����ʼ��
% ���� cell{p}
B=rand(10,10);
AM=round(B);


function Track=Initialize(AM,s,P)
    global Paths;% ·����
    global maxPathNum;%���·������
    global pathNum;
    
    Paths =cell(P,1);
    maxPathNum=P; 
    pathNum=0;
    nextNode = find(AM(s,:) ==1);
    for j =nextNode
        Paths{i}=[ Paths{i},j];
        Paths(cur) =dfs(AM,i,Paths);
        cur++;
    end


end
function path=dfs(AM,s,t)
    if s==t || pathNum ==maxPathNum
        return;
    end
    nextNode = find(AM(s,:)==1);
    for i =nextNode
        cur++;
    end
end


%% ·��ȥ��
function Route=Fresh(Route)



end







%% �����������
function Route=SpecialAdd(Route,OptRoute)
%Route ����
%OptRoute1 ��ʷ��ȫ������
% r1 �������ӵ���ʷ���Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r1<=1
% r2 ����Ⱥ��ȫ�����Ÿ���Ե�ǰ���ӵ�Ӱ��ϵ����0<r2<=1
    R=randi(length(Route),1); %�ұߵ�λ��
    L =randi(R,1);%���λ��
    Lopt=find(OptRoute==L);
    Ropt=find(OptRoute==R);
    if isempty(Lopt) && isempty(Ropt)
        return;
    end
    part =OptRoute(Lopt:Ropt);
    Route = [Route(1:L),part,Route(R,end)];
end



%% ���Ѱ��
function Route=RandMove(Route,r3,AM)



end