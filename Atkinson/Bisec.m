function [ minAI ] = Bisec(y,es,w,u,l,e,b,pw)
i=0;
%starting while loop over interval
while u-l > e
k=(u+l)/2;

%set starting values
st=zeros(length(y),1);

%set lower and upper bounds on variables
LB=zeros(length(y),1);
UB=b*ones(length(y),1);


%optimization
x=fmincon(@(x)0,st,[],[],[],[],LB,UB,@(x)cons(y,w,es,x,k,b,pw),optimoptions('fmincon','Algorithm',...
'interior-point','Display','off','UseParallel',false,'ScaleProblem','obj-and-constr','MaxIter',5000,'MaxFunEvals',100000,...
'TolFun',10^(-7),'TolCon',10^(-7),'TolX',10^(-7)));

%read in new transfer schedule
trans=x(1:length(y));

%calculate candidate value for the AI with new transfer schedule
cand=double(AI(y,w,es,trans));

%decide whether k is upper or lower bound
    if cand <= k
        u=k;
        soln=trans;
    else
        l=k;
    end
 i=i+1;
 k;
end

[k;soln]
minAI=(soln);
end