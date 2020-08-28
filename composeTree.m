function newTree =composeTree(paths)
%% �ع���
    %% ƴ�Ӹ���·��
    temp=cell(1,2);
    for i=1:size(paths,1)
        temp{1,1}=[temp{1,1},paths{i,1}];
        temp{1,2}=[temp{1,2},paths{i,2}];
    end
    %% ȥ��
    C=temp{1,1};
    P=temp{1,2};
    [~,indexs]=findDuplicate(C);
    Next=true(1,length(C));
    % ȥ���ظ��ıߺ͵���ͬһ���ı�
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