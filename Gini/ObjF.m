function [f,gradf] = ObjF(x,y,w,es,lt,lL)

z=x(1);
t=[x(2:lt+1);zeros(length(y)-lt,1)];
L=x(lt+2:end);
yt=es.^-1.*(y+t);

G=L;
   
S=sum(G);

e=0;
for i = (lt+1):length(y)
    e=e+sum(w(i)*w((i+1):length(y)).*abs(yt(i)-yt((i+1):length(y))));
end

%objective function 
f=S+z*e;

%gradient
gradf=[e;sparse(lt,1);ones(lL,1)];

end



