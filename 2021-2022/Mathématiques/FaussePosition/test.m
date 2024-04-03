function [xfinal,nbIter,err]  = test(fun,a,b,iterMax,tol,trueValue)

i=1;
deriv=@(a,b)(fun(b)-fun(a))/(b-a);
pn=[]
err=[];
while i<iterMax && abs(a-b)/abs(a)>tol
    p=a-fun(a)/deriv(a,b);
    err=[err;abs(p-trueValue)];
    if fun(p) * fun(a) > 0
      a=p;
    else
      b=p;
    end
    pn=[pn;p];
    i=i+1;
end
xfinal=p;
nbIter=i;