function Net_plot(BorderLength,NodeAmount,Sxy,PlotIf,TreeIf,Tree)
%画节点
if PlotIf==1
    plot(Sxy(2,:),Sxy(3,:),'k.')  %画点
    %设置图形显示范围
    xlim([0,BorderLength]);  %坐标
    ylim([0,BorderLength]);
    hold on
    %为节点标序号
    for i=1:NodeAmount
        Str=int2str(i);
        text(Sxy(2,i)+BorderLength/100,Sxy(3,i)+BorderLength/100,Str,'FontSize',12); %标记
        hold on
    end
end
%画边，并给边标注费用和延时
if PlotIf==1
    if TreeIf==1
        for k=1:length(Tree{1,1})
         i=Tree{1,1}(k);
         j=Tree{1,2}(k);
         if(Tree{1,2}(k)==0)
             continue;
         end
         plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);  %画边             
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