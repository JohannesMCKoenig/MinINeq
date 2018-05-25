function  g  = GC(y,w,es,t)
%Calculates the Gini
%   Weighted Calculation of the Gini
 
%auxiliary variables
s=2*sum(w)*(sum(w.*(es.^-1.*(y+t))));
yt=es.^-1.*(y+t);

S=0;

for i = 1:length(y)
    S=S+(w(i)*sum(w.*abs((yt(i)-yt))));
end
g=S/s;

end