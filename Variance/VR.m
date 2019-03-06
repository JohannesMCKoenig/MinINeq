function  v  = VR(y,w,es,t)
%Calculates the Variance

mean=sum(w.*(es.^-1.*(y+t)))/sum(w);
yt=es.^-1.*(y+t);

S=0;

for i = 1:length(y)
    S=S+(w(i)*(yt(i)-mean)^2);
end
v=S/sum(w);

clear s S i yt ytw w

end

