function  [ a ]  = AI(y,w,es,x)
m=sum(w.*(es.^-1.*(y+x)))/sum(w);
yt=es.^-1.*(y+x);

%inequality aversion
eps=0.5;

S=0;

for i = 1:length(y)
     S=S+(w(i)*(yt(i))^(1-eps))/sum(w);
end

a=1-(S)^(1/(1-eps))/m;

end