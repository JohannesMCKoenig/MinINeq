function [ minGini ] = LinFrac(y,es,w,pw,b,lt)
%Linear Fractional Program

%generate derivatives of constraints
Dc=dc(y,w,pw,es,b,lt);
save('DC.mat','Dc');
clear Dc;
%number of new variables Delta_ij
lL=lt*length(y)-((lt+1)*lt)/2;

%starting values and bounds
st=[1;zeros(lt,1);zeros(lL,1)];
LB=[0;zeros(lt,1);-Inf(lL,1)];
UB=[Inf;Inf(lt,1);Inf(lL,1)];

%load derivatives of constraints
load DC.mat;
DC=Dc(:,1:end-1);
DCEQ=Dc(:,end);
clear Dc

%optimization options
opts=optimoptions('fmincon','Algorithm','interior-point','GradObj','on','GradConstr','on',...
'Hessian','user-supplied','HessFcn',@(x,lambda)HessF(x,lambda),'UseParallel',true,...
'Display','final','MaxIter',5000,'MaxFunEvals',1000000,...
'ScaleProblem','none',...
'TolFun',10^(-20),'TolCon',10^(-15),'TolX',10^(-20));

%optimization
x=fmincon(@(x)ObjF(x,y,w,es,lt,lL),st,[],[],[],[],LB,UB,@(x)cons(y,w,pw,es,x,b,lt,DC,DCEQ),opts);

%backing out transfers
z=x(1);
trans=[z^(-1)*x(2:lt+1);zeros(length(y)-lt,1)];
postdist=es.^-1.*(y+trans);

%optimal values of Gini
cand=double(MGC(y,w,es,trans))


minGini=cand;

end