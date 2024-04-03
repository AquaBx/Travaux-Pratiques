%"format long" permet d'augmenter le nombre de chiffres significatifs. 
format long;

%On créé des variables globales
fun=@(x)x.^3+4.*x.^2-10;
a=0;
b=5;
trueValue=1.365230013414097;
tol=1e-6;
iterMax=100;
iter=1000;

%On exécute notre script lié à la méthode de Newton
[xfinal,nbIter,err]=falsePos_func(fun,a,b,iterMax,tol,trueValue)

plot(1:nbIter-1,err)