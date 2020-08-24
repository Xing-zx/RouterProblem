function [paths]=decomposeTree(Tree,Target)
%     global Sxy;
    C=Tree{1,1};
    P=Tree{1,2};
    paths=cell(length(Target),2);
    for i=1:length(Target)
        paths{i,1}=C(1:find(Target(i)==C));
        paths{i,2}=P(1:find(Target(i)==C));
        [duplicates,~]=findDuplicate(paths{i,2});
        % 处理树的分支
%         if ~isempty(duplicates)
%             for j =1:length(duplicates)
%                 L=find(paths{i,2}==duplicates(j),1,'first');
%                 R=find(paths{i,2}==duplicates(j),1,'last');
%                 paths{i,1}=[paths{i,1}(1:L-1),paths{i,1}(R:end)];
%                 paths{i,2}=[paths{i,2}(1:L-1),paths{i,2}(R:end)];
%             end
%             
%         end
%         figure(i+3)
%         hold off
%         Net_plot2(10,30,Sxy,1,{paths{i,1},paths{i,2}});
%        pause(0.3);
    end
end
