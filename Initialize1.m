function out_path = Initialize(AM,s,d,p)

%AM伴随矩阵
%s 为源节点
%d为目的节点
%out_path为源节点到目的节点所查找的所有路径，所过你只想查找n条，直接写个判断就可以了到时候

global out_path;
out_path = cell(p,1);
 global tag ;
 tag = 1;
global initMatrix;
global maxPathNum;%最大路径条数
initMatrix = AM;
maxPathNum =p;
 n = size(initMatrix,1);
 global visitedFlag;
 visitedFlag = zeros(n,1);
 global top;
 top = 1;
 global pathStack;
 pathStack(top) = s;%栈顶元素等于源节点
 getPathOfTwoNode(s,d);

end
 
 function getPathOfTwoNode(startNode ,endNode)
     
      global visitedFlag;
      visitedFlag(startNode) = 1;
      findPath(startNode ,endNode);
     
 end
 
 function findPath(startNode,endNode)
 
       global top;
       global pathStack;
       global visitedFlag;
       global initMatrix;
       global out_path;
       global tag ;
       global maxPathNum;
       if tag == maxPathNum
           return;
       end
      if startNode == endNode
         out_path{tag,1} = pathStack;
         tag = tag + 1;
         visitedFlag(pathStack(top)) = 0;
         pathStack(top)=[]; %栈顶节点出栈
         top=top-1;
         
      else
          for i = 1:size(initMatrix,1)
             if initMatrix(startNode,i) && visitedFlag(i) ~= 1
                visitedFlag(i) = 1;
                top = top + 1;
                pathStack(top) = i;
                findPath(i,endNode)
             end
          end
         visitedFlag(pathStack(top)) = 0;
         pathStack(top)=[]; %栈顶节点出栈
         top=top-1;
      end
 end


