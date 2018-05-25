function [c,ceq,dc,dceq] = cons(y,w,pw,es,x,b,lt,DC,DCEQ)
%Constraints for the optimization

%parse optimization variables
z=x(1);
t=[x(2:lt+1);zeros(length(y)-lt,1)];
L=x(lt+2:end);


%generate auxiliary variables
K=sum(w)*(sum(w.*(es.^-1.*(y))));
T=sum(w)*(sum(w.*(es.^-1.*(t))));
yes=es.^-1.*(y);
tes=es.^-1.*(t);


%initialize all the new variables and constraints
D = [];
spmd 
    start=round((lt/numlabs)*(labindex-1))+1;
    ende=round((lt/numlabs)*(labindex));
    D_lab=[];
    for i=start:ende
        D_lab=[D_lab;z*w(i)*w((i+1):length(y)).*(yes(i)-yes((i+1):length(y)))...
        +w(i)*w((i+1):length(y)).*(tes(i)-tes((i+1):length(y)))];
    end
end

for i=1:length(D_lab)
D=[D;D_lab{i}];
end
clear start ende D_lab;

%set up constraints
c=[transpose(pw)*t-b*z];
c=[c;-L+D;-L-D];
c=sparse(c);
ceq=(z*K+T)-1;

%read in gradient of the constraints
dc=DC;
dceq=DCEQ;

end