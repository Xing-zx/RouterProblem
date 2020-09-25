function [fitness,flag] = Fit(Routes)
    fitness=zeros(size(Routes,1),1);
    for i =1:size(Routes,1)
    fitness(i)=length(Routes{1,1});
    end
end
