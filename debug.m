Route=[9    21     2    17    12    16    14];
OptRoute=[ 9     5     2     8    19    18    12    23    14];
B=rand(10,10);
AM=round(B);
Track=Initialize(AM,1,10,100);
for i=1:100 
    RandMove(Track{1},0.8,Track);
end