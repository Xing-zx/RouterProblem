function Route=RandMove(Route,r,Routes)

    if rand(1)<r
      R=randi(length(Route),1); %ÓÒ±ßµÄÎ»ÖÃ
      L =randi(R,1);%×ó±ßÎ»ÖÃ
      if R==L
          if R==1
              R=R+1;
          else
              L=L-1;
          end
      end
      selectRoute={};
      for i =1:size(Routes,1)
         selectL =find(Routes{i}==L);
         selectR =find(Routes{i}==R);
         if ~isempty(selectL) && ~isempty(selectR) && selectL<selectR
             selectRoute{1:end}
             Routes{i}(selectL:selectR)
             selectRoute=[selectRoute;Routes{i}(selectL:selectR)];
         end
      end
      if length(selectRoute)~=0
      part =selectRoute{randi(length(selectRoute),1)};
      Route = [Route(1:L),part,Route(R:end)];
      end
    end

end