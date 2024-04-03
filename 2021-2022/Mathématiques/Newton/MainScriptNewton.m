%"format long" permet d'augmenter le nombre de chiffres significatifs. 
format long;

%On créé des variables globales
fun=@(x)x.^3+4.*x.^2-10;
deriv=@(x)3.*x.^2+8.*x;
p0=1;
trueValue=1.365230013414097;
tol=1e-6;
iterMax=100;
iter=1000;

%On exécute notre script lié à la méthode de Newton
[xfinal,nbIter,err]=newton_func(fun,deriv,p0,iterMax,tol,trueValue)


