function  T  = TI(y,w,es,t)
%Calculates the Theil
 
m=sum(w.*(es.^-1.*(y+t)))/sum(w);
yt=es.^-1.*(y+t);
S=0;
for i = 1:length(y)
S=S+w(i)*(yt(i)/m)*log((yt(i)/m));
end
T=S/sum(w);

end

