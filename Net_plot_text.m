function Net_plot_text(BorderLength,NodeAmount,Sxy,Cost,Delay,DelayJitter,PacketLoss,PlotIf,FlagIf)
%% ���ڻ����������˵ĺ���

%% ���ڵ�
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
%% ���ߣ������߱�ע���ú���ʱ
if PlotIf==1
    for i=1:(NodeAmount-1)
        for j=(i+1):NodeAmount
            if isinf(Cost(i,j))==0
                plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);  %����
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