function [c,ceq] = cons(y,w,es,x,k,b,pw)
%Constraints for the optimization

%generate the mean and the vector with transfers
m=sum(w.*(es.^-1.*(y+x)))/sum(w);
yt=es.^-1.*(y+x);

S=0;
for i = 1:length(y)
S=S+w(i)*(yt(i))*log((yt(i)/m));
end

%sublevel set constraint
c=S-k*m;
%budget constraint
c=[c;sum(pw.*x)-b];
ceq=[];

end

