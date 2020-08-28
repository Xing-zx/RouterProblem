function newTree=CrossRoute(Tree1,Tree2,Target)
    % 划分目标结点路径
    paths1=decomposeTree(Tree1,Target);
    paths2=decomposeTree(Tree2,Target);
    %随机选择一个目标结点
    T=randi(length(Target),1);
    Target(T)
    %将paths2中的该目标结点路径替换paths1的目标结点路径
    paths1{T,1}=paths2{T,1};
    paths1{T,2}=paths2{T,2};
    newTree=composeTree(paths1,T);
end
% function [duplicates,indexs]=findDuplicate(A)
% 
% [~,m,~] = unique(A);
% orgl_ind = 1:length(A);
% ind2get = setdiff(orgl_ind, m);
% duplicates = A(ind2get);
% [~,i]=setdiff(A,duplicates);
% indexs=setdiff(orgl_ind,i);
% end
% function [paths]=decomposeTree(Tree,Target)
%     C=Tree{1,1};
%     P=Tree{1,2};
%     paths=cell(length(Target),2);
%     for i=1:length(Target)
%         paths{i,1}=C(1:find(Target(i)==C));
%         paths{i,2}=P(1:find(Target(i)==C));
%         [duplicates,~]=findDuplicate(paths{i,2});
%         % 处理树的分支
%         if ~isempty(duplicates)
%             for j =1:length(duplicates)
%                 L=find(paths{i,2}==duplicates(j),1,'first');
%                 R=find(paths{i,2}==duplicates(j),1,'last');
%                 paths{i,1}=[paths{i,1}(1:L-1),paths{i,1}(R:end)];
%                 paths{i,2}=[paths{i,2}(1:L-1),paths{i,2}(R:end)];
%             end
%             
%         end
% %         hold off
% %         Net_plot2(10,10,Sxy,1,{paths{i,1},paths{i,2}});
% %         pause(0.3);
%     end
% end

function newTree =composeTree(paths,T)
    temp=cell(1,2);
    for i=1:size(paths,1)
        temp{1,1}=[temp{1,1},paths{i,1}];
        temp{1,2}=[temp{1,2},paths{i,2}];
    end
    %去重
    C=temp{1,1};
    P=temp{1,2};
    [~,indexs]=findDuplicate(C);
    Del=setdiff(C,[P,T]);
    while ~isempty(Del)
        Next=true(1,length(C));
        [~,index]=ismember(Del,C);
        Next(index)=false;
        C=C(Next);
        P=P(Next);
        Del=setdiff(C,[P,T]);
    end
%     if ~isempty(indexs)
%         for i=1:length(indexs)
%             node1=C(indexs(i));
% %             node2=P(indexs(i));
%             del=find(C==node1);
% %             del2=find(P==node2);
% %             del=intersect(del1,del2);
%             del(1)=[];
%             Next(del)=false;
%         end
%     end
    newTree{1,1}=C;
    newTree{1,2}=P;
end