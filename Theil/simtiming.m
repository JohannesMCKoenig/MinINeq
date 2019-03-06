clearvars

diary TheilTiming.txt
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
upper=double(TI(Y,W,S,tzero));
B=150*2^(i-1);
    
tic
trans=Bisec(Y,S,N,upper,0,10^(-7),B,PW)

sum(PW.*trans(2:end,1))

time=[time;toc]
iter=[iter;i]
end


iter
time

diary off