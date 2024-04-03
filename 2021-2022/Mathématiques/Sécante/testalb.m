%"format long" permet d'augmenter le nombre de chiffres significatifs. 
format long;

%On cr�� des variables globales
fun=@(x)cos(x)-x;
a=0;
b=5;
trueValue=1.365230013414097;
tol=1e-16;
iterMax=100;
iter=1000;

%On ex�cute notre script li� � la m�thode de Newton
[xfinal,nbIter,err]=secante_func(fun,a,b,iterMax,tol,trueValue)


figure(1)
plot(1:nbIter,xfinal)