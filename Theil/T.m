function  [ th ]  = T(y,w,es,x)

m=sum(w.*(es.^-1.*(y+x)))/sum(w);
yt=es.^-1.*(y+x);


S=0;

for i = 1:length(y)
     S=S+(w(i)*(yt(i)/m)*log((yt(i)/m)));
end

th=S/sum(w);
end