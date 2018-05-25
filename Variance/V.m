function  [ v ]  = V(y,w,es,x)
m=sum(w.*(es.^-1.*(y+t)))/sum(w);
yt=es.^-1.*(y+x);

S=0;

for i = 1:length(y)
    S=S+(w(i)*(yt(i)-m)^2);
end
v=S/sum(w);

end