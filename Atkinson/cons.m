function [c,ceq] = cons(y,w,es,x,k,b)
%Constraints for the optimization

%generate the mean and the vector with transfers
m=sum(w.*(es.^-1.*(y+x)))/sum(w)
yt=es.^-1.*(y+x);

%inequality aversion
eps=0.5;

S=0;

for i = 1:length(y)
     S=S+(w(i)*(yt(i))^(1-eps))/sum(w);
end

%sublevel set constraint
c=[c;-(S)^(1/(1-eps)-(k-1)*m];
%budget constraint
c=[c;sum(t)-b];
ceq=[];

end