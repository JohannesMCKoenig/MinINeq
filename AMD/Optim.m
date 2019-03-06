clearvars

diary AMDTime.txt
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
    
%Optimization Script

%linear inequalities
A=[transpose(PW),zeros(1,length(Y))];
b=150*2^(i-1); %Set the public budget

%set lower and upper bounds on variables
LB=[zeros(length(Y),1);-Inf(length(Y),1)];
UB=[b*ones(length(Y),1);Inf(length(Y),1)];

%set starting values
st=[zeros(length(Y)*2,1)];

pre=AM(Y,W,S,tzero)

x=fmincon(@(x)AMD(W,Y,x),st,A,b,[],[],LB,UB,@(x)cons(Y,W,S,x),...
optimoptions('fmincon','Algorithm','interior-point','UseParallel',...
false,'MaxIter',5000,'MaxFunEvals',100000,'TolCon',10^(-7),'TolX',10^(-7)));

trans=PW.*x(1:length(Y),1)
i
post=AM(Y,W,S,trans)

end






