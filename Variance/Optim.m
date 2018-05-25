%Optimization Script

%linear inequalities
A=ones(1,length(Y));
b=budget; %Set the public budget

%set lower and upper bounds on variables
LB=zeros(length(Y),1);
UB=b*ones(length(Y),1);

%set starting values
st=[zeros(length(y),1)];

x=fmincon(@(x)V(y,w,es,x),st,A,b,[],[],LB,UB,[],
optimoptions('fmincon','Algorithm','interior-point','UseParallel',
true,'MaxIter',5000,'MaxFunEvals',100000,'TolCon',10^(-7),'TolX',10^(-7)));