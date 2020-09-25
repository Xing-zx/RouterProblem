function newTree =composeTree(paths)
%% 重构树
    %% 拼接各个路径
    temp=cell(1,2);
    for i=1:size(paths,1)
        temp{1,1}=[temp{1,1},paths{i,1}];
        temp{1,2}=[temp{1,2},paths{i,2}];
    end
    %% 去重
    C=temp{1,1};
    P=temp{1,2};
    [~,indexs]=findDuplicate(C);
    Next=true(1,length(C));
    % 去除重复的边和到达同一结点的边
    if ~isempty(indexs)
        for i=1:length(indexs)
            node1=C(indexs(i));
            del=find(C==node1);
            del(1)=[];
            Next(del)=false;
        end
    end
    newTree{1,1}=C(Next);
    newTree{1,2}=P(Next);
end