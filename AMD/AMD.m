function  [ a ]  = AMD(w,x)

D=x(length(y)+1:end);

for i = 1:length(y)
    S=S+(w(i)*D(i));
end
a=S/sum(w);


end