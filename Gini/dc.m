function [dc] = dc(y,w,pw,es,b,lt)

%generate the relevant help variables
W=sum(w);
yes=es.^-1.*(y);
ltL=lt*length(y)-((lt+1)*lt)/2;
ltY=length(y);

%derivatives of Delta_ij inequalities wrt to transfers
dc=[];
for i=1:lt
       
    dc_temp=[];
    if i==1
        
        dc_temp=[(w(i)/es(i))*w(i+1:end);sparse(ltL-(ltY-i),1)];
        dc_temp=[dc_temp;-dc_temp];
    
    else 
    
         %derivatives in previous differences   
        for j=1:(i-1)
            
            if i==2
                dc_temp=[dc_temp;[-w(i)*w(j)/es(i);sparse(ltY-i,1)]];
            else
               dc_temp=[dc_temp;[sparse((i-1)-j,1);-w(i)*w(j)/es(i);sparse(ltY-i,1)]]; 
            end    
            
        end
        
        %derivatives in own parts
        dc_temp=[dc_temp;(w(i)/es(i))*w(i+1:end)];
        dc_temp=[dc_temp;sparse(ltL-length(dc_temp),1)];
        dc_temp=[dc_temp;-dc_temp];
        
    end 
    
    %add derivative from budget  
    dc_temp=[pw(i);dc_temp];
    dc=[dc,dc_temp];
     
end    
disp('Derivs done!')
DC=dc;
save DC.mat DC

dc=[];
parfor i = 1:ltL
    if i==1
        dc=[dc,[0;-1;sparse(ltL-1,1);-1;sparse(ltL-1,1)]];
    else
        dc=[dc,[0;sparse(i-1,1);-1;sparse(ltL-i,1);sparse(i-1,1);-1;sparse(ltL-i,1)]];
     end

end 

load('DC.mat','DC')
dc=[DC,dc];
clear DC

dc=transpose(dc);


%add the derivative for z
%constant part of the inequalities
zy = [];
spmd 
    start=round((lt/numlabs)*(labindex-1))+1;
    ende=round((lt/numlabs)*(labindex));
    D_lab=[];
    for i=start:ende
        D_lab=[D_lab;w(i)*w((i+1):length(y)).*(yes(i)-yes((i+1):length(y)))];
    end
end

for i=1:length(D_lab)
zy=[zy;D_lab{i}];
end
clear start ende D_lab;

zy=[zy;-zy];
zy=transpose(zy);
dc=[[-b,zy];dc];
clear zy

%generate the derivative for the equality constraint
K=W*(sum(w.*yes));
dceq=[K;pw(1:lt);sparse(ltL,1)];


dc=[dc,dceq];

end