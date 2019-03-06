function  [ a ]  = AMD(w,y,x)

D=x(length(y)+1:end);

S=0;
for i = 1:length(y)
    S=S+(w(i)*D(i));
end
a=S/sum(w);


end