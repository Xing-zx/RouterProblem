function [multicastTree]=InitializeTree(S,E,AM)
T=length(E);  %目的节点个数
N=size(AM,1);       %节点数
code=S;          %已经访问的节点
multicastTree=cell(1,2);
k=1;
while ~isempty(E)
    if k==1
        W=S;             %当前节点初始化为起始点 %状态初始化
        Path=S;          
        u=floor(T*rand+1); % 随机选择一个目标结点
        multicastTree{1,1}=S;                
        multicastTree{1,2}=0;
        while W~=E(u)
            WW=AM(W,:);% W结点的行向量 W 为之前的结点
            WW1=find(WW==1); %WW1为相邻结点序号
            if isempty(WW1) || all(ismember(WW1,Path)==1)  %考虑为空的情况
                % 为空代表W结点为孤立结点
%                  disp(['从源节点到并没有到达目标节点：目前结点已经为死路, 或者成环',num2str(W)]);
                break;
            end
            Visit=WW1(floor(length(WW1)*rand())+1); %随机选择一条边。可在出现环路时改进，不取p1,p2之间的节点
            while ~isempty(find(Visit==Path, 1))
                Visit=WW1(floor(length(WW1)*rand())+1);
            end
            AM(W,Visit)=0;
            AM(Visit,W)=0;
            Path=[Path,Visit];%路径
            multicastTree{1,1}=[multicastTree{1,1},Visit];
            multicastTree{1,2}=[multicastTree{1,2},W];
            W=Visit;

        end
        code=Path;
        k=0;
    else
        u=floor(length(E)*rand+1); 
        W=E(u);      %依次访问目的节点 W为下一个结点
        Path=W;
        if isempty(find(W==code, 1))                       %考虑不为1的情况
            WW=AM(W,:);
            WW1=find(WW==1, 1);                      %要考虑为空的情况
            if isempty(WW1)   %考虑为空的情况
                % 为空代表W结点为孤立结点
%                   disp('当前目标节点没有路可走');
                  E(find(W==E,1))=[];
                continue;
            end
%             Visit=WW1(floor(length(WW1)*rand())+1);
% %             while ~isempty(find(Visit==Path, 1)) 
% %                 Visit=WW1(floor(length(WW1)*rand())+1);
% %             end
%             AM(W,Visit)=0;
%             AM(Visit,W)=0;
%             Path=[Path,Visit];
%             %code=[code,Visit];
%             W=Visit;
            stack=W;
            while isempty(find(W==code, 1))             %判断w是否存在code中,空的话表示不存在
                WW=AM(W,:);
                WW1=find(WW==1);

                if isempty(WW1) || all(ismember(WW1,Path)==1) %考虑为空的情况
               
%                  disp('当前节点的路走完了，当没有与源节点树相连,后退一步');
                 if isempty(stack) 
                     break;
                 end
                 W=stack(end);
                 stack(end)=[];
                 continue;
                end
                Visit=WW1(floor(length(WW1)*rand())+1);
                while ~isempty(find(Visit==Path, 1))
                    Visit=WW1(floor(length(WW1)*rand())+1);
                end
                AM(W,Visit)=0;
                AM(Visit,W)=0;
                Path=[Path,Visit];
                %code=[code,Visit];
                W=Visit;
                stack=[stack,W];
            end % while
            code=[code,Path(1:length(Path)-1)];
            Path =fliplr(Path);
            multicastTree{1,1}=[multicastTree{1,1},Path(2:end)];
            multicastTree{1,2}=[multicastTree{1,2},Path(1:end-1)];            
        end
    end
            E=setdiff(E,code);
            
end

