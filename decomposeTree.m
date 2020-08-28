function [paths]=decomposeTree(Tree,Target)
     global Sxy;
    C=Tree{1,1};
    P=Tree{1,2};
    paths=cell(length(Target),2);
    for i=1:length(Target)
        paths{i,1}=C(1:find(Target(i)==C));
        paths{i,2}=P(1:find(Target(i)==C));
%         [duplicates,~]=findDuplicate(paths{i,2});
        % 处理树的分支
        Ci=paths{i,1};
        Pi=paths{i,2};
        Ti=Target(i);
        Del=setdiff(Ci,[Pi,Ti]);
        while ~isempty(Del)
            Next=true(1,length(Ci));
            [~,index]=ismember(Del,Ci);
            Next(index)=false;
            Ci=Ci(Next);
            Pi=Pi(Next);
            Del=setdiff(Ci,[Pi,Ti]);
        end
        paths{i,1}=Ci;
        paths{i,2}=Pi;
%         figure(i)
%         hold off
%         Net_plot(10,30,Sxy,1,1,{paths{i,1},paths{i,2}});
%        pause(0.3);
    end
end
