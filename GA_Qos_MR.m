function [Offspring,Fitness] = GA_Qos_MR(s,T,AM,P)
MaxIter=20;
Track=Initialize(s,T,AM,P);
%% ��Ⱥ��ʼ��
for p=1:P
    Route=Track{p,1}; 
    Population(p,:)=Route;
end
    save('initialPop','Population');
    for t=1:MaxIter
        Fitness=Fit(Population);
        %% ѡ��
          MatingPool = TournamentSelection(2,P/2,Fitness);
         %% �������
          Offspring  = GA_route(Population(MatingPool,:),T);
          Population =Offspring;
    end   
end