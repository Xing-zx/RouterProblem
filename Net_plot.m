function Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,TreeIf,Tree)
%���ڵ�
if PlotIf==1
    plot(Sxy(2,:),Sxy(3,:),'k.')  %����
    %����ͼ����ʾ��Χ
    xlim([0,BorderLength]);  %����
    ylim([0,BorderLength]);
    hold on
    %Ϊ�ڵ�����
    for i=1:NodeAmount
        Str=int2str(i);
        text(Sxy(2,i)+BorderLength/100,Sxy(3,i)+BorderLength/100,Str,'FontSize',12); %���
        hold on
    end
end
%���ߣ������߱�ע���ú���ʱ
if PlotIf==1
    if TreeIf==1
        for k=1:length(Tree{1,1})
         i=Tree{1,1}(k);
         j=Tree{1,2}(k);
         if(Tree{1,2}(k)==0)
             continue;
         end
         plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);  %����             
                    hold on
        end
    else
        for i=1:(NodeAmount-1)
            for j=(i+1):NodeAmount
                if Tree(i,j)==1
                    plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);
                end
            end
        end
    end
end
% hold off