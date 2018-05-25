function [c,ceq] = cons(y,w,es,x)
%Constraints for the optimization


% seperate t and Delta_i
t=x(1:length(y));
D=x(length(y)+1:end);

%generate the mean
m=sum(w.*(es.^-1.*(y+t)))/sum(w)
yt=es.^-1.*(y+t);

%generate income differences
L = [];

for i = 1:length(y)

    L=[L;w(i)(yt(i)-m)];

end

%absolute value constraints
c=[-D+L;-D-L];
ceq=[];