clearvars

diary VarTime.txt
diary on



load('EX9')

time=0;
iter=0;
Y=y;
S=sqrt(n); %es
N=n;



for i = 1:5

    Y=repmat(y,2^(i-1),1);
    N=repmat(n,2^(i-1),1);
    S=repmat(sqrt(n),2^(i-1),1); 
    PW=repmat(pw,2^(i-1),1);
    W=N.*PW;
    
 
tzero=zeros(length(Y),1);    

B=150*2^(i-1);

%ineqs
A=transpose(PW);
b=B;

LB=zeros(length(Y),1); 
UB=b*ones(length(Y),1);
    
pre=VR(Y,W,S,LB)

tic
x=fmincon(@(x)VR(Y,W,S,x),tzero,A,b,[],[],LB,UB,[],optimoptions('fmincon','Algorithm','interior-point','UseParallel',false,'ScaleProblem','obj-and-constr','MaxIter',5000,'MaxFunEvals',500000,'TolCon',10^(-7),'TolX',10^(-7)));

trans=sum(PW.*x)
post=VR(Y,W,S,x)

time=[time;toc];
iter=[iter;i];
end

iter
time

diary off