global Sxy
[Sxy,AM]=NetCreate2(10,30,10,100,1,0);
 hold off
S=1;
E=[25,27,29];
multicastTrees=cell(100,1);
for i=1:100
    tree=InitializeTree(S,E,AM);
    multicastTrees{i,1} = tree;
%     multicastTrees{i,1} = [length(tree{1,1}),length(tree{1,2})];
end
    route=multicastTrees{floor(100*rand)+1};

for i=1:100
    OptRoute = multicastTrees{floor(100*rand)+1};
    newTree = CrossRoute(route,OptRoute,E);
    decomposeTree(route,E);
    figure(1)
    hold off
    Net_plot2(10,30,Sxy,1,route);
    pause(0.5);
    
    figure(2)
    hold off
    Net_plot2(10,30,Sxy,1,OptRoute);
    pause(0.5);  
    figure(3)
    hold off
    Net_plot2(10,30,Sxy,1,newTree);
    pause(0.5);
    route=newTree;
 end 
for i=1:20
    tree= ROUTEst{9,i};
%     Net_plot2(10,10,Sxy,1,tree);
    Net_plot2(BorderLength,NodeAmount,Sxy,PlotIf,tree);
    hold off
    pause(0.5);
end
% tree=InitializeTree(S,E,AM);
% tree{1,1}
% Net_plot2(10,10,Sxy,1,tree);
% hold off