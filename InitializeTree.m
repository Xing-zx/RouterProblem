function [multicastTree]=InitializeTree(S,E,AM)
T=length(E);  %Ŀ�Ľڵ����
N=size(AM,1);       %�ڵ���
code=S;          %�Ѿ����ʵĽڵ�
multicastTree=cell(1,2);
k=1;
while ~isempty(E)
    if k==1
        W=S;             %��ǰ�ڵ��ʼ��Ϊ��ʼ�� %״̬��ʼ��
        Path=S;          
        u=floor(T*rand+1); % ���ѡ��һ��Ŀ����
        multicastTree{1,1}=S;                
        multicastTree{1,2}=0;
        while W~=E(u)
            WW=AM(W,:);% W���������� W Ϊ֮ǰ�Ľ��
            WW1=find(WW==1); %WW1Ϊ���ڽ�����
            if isempty(WW1) || all(ismember(WW1,Path)==1)  %����Ϊ�յ����
                % Ϊ�մ���W���Ϊ�������
%                  disp(['��Դ�ڵ㵽��û�е���Ŀ��ڵ㣺Ŀǰ����Ѿ�Ϊ��·, ���߳ɻ�',num2str(W)]);
                break;
            end
            Visit=WW1(floor(length(WW1)*rand())+1); %���ѡ��һ���ߡ����ڳ��ֻ�·ʱ�Ľ�����ȡp1,p2֮��Ľڵ�
            while ~isempty(find(Visit==Path, 1))
                Visit=WW1(floor(length(WW1)*rand())+1);
            end
            AM(W,Visit)=0;
            AM(Visit,W)=0;
            Path=[Path,Visit];%·��
            multicastTree{1,1}=[multicastTree{1,1},Visit];
            multicastTree{1,2}=[multicastTree{1,2},W];
            W=Visit;

        end
        code=Path;
        k=0;
    else
        u=floor(length(E)*rand+1); 
        W=E(u);      %���η���Ŀ�Ľڵ� WΪ��һ�����
        Path=W;
        if isempty(find(W==code, 1))                       %���ǲ�Ϊ1�����
            WW=AM(W,:);
            WW1=find(WW==1, 1);                      %Ҫ����Ϊ�յ����
            if isempty(WW1)   %����Ϊ�յ����
                % Ϊ�մ���W���Ϊ�������
%                   disp('��ǰĿ��ڵ�û��·����');
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
            while isempty(find(W==code, 1))             %�ж�w�Ƿ����code��,�յĻ���ʾ������
                WW=AM(W,:);
                WW1=find(WW==1);

                if isempty(WW1) || all(ismember(WW1,Path)==1) %����Ϊ�յ����
               
%                  disp('��ǰ�ڵ��·�����ˣ���û����Դ�ڵ�������,����һ��');
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

