function  a  = AM(y,w,es,t)
%Calculates the AMD

mean=sum(w.*(es.^-1.*(y+t)))/sum(w);
yt=es.^-1.*(y+t);

S=0;

for i = 1:length(y)
    S=S+(w(i)*abs(yt(i)-mean));
end
a=S/sum(w);


end