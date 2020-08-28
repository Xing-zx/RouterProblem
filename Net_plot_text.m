function Net_plot_text(BorderLength,NodeAmount,Sxy,Cost,Delay,DelayJitter,PacketLoss,PlotIf,FlagIf)
%% 用于绘制网络拓扑的函数

%% 画节点
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
%% 画边，并给边标注费用和延时
if PlotIf==1
    for i=1:(NodeAmount-1)
        for j=(i+1):NodeAmount
            if isinf(Cost(i,j))==0
                plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);  %画边
                if FlagIf==1
                    xx=0.5*(Sxy(2,i)+Sxy(2,j));
                    yy=0.5*(Sxy(3,i)+Sxy(3,j));
                    Str1=num2str(Cost(i,j));
                    Str2=num2str(1000000*Delay(i,j));
                    Str3=num2str(1000000*DelayJitter(i,j));
                    Str4=num2str(100*PacketLoss(i,j));
                    Str1=Str1 (1:3);
                    Str2=Str2(1:3);
                    Str3=Str3(1:3);
                    Str4=Str4(1:3);
                    text(xx,yy,['(',Str1,',',Str2,',',Str3,',',Str4,',',')'],'FontSize',9);
                end
                hold on
            end
        end
    end
end