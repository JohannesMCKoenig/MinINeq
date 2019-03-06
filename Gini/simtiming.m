clear
clearvars

diary logsim.txt
diary on

%load('EX8')
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
        LT=length(Y);
        

        
tzero=zeros(length(Y),1);    
B=150*2^(i-1);
 
delete(gcp('nocreate'))
parpool;

tic
transfers=LinFrac(Y,S,W,PW,B,LT);
total=sum(transfers.*PW)

MGC(Y,W,S,tzero)
MGC(Y,W,S,transfers)

iter=[iter;i]
time=[time;toc]



end

iter 
time

diary off