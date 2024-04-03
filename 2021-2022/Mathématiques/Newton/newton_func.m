function [xfinal,nbIter,err]  = newton_func(fun,deriv,p0,iterMax,tol,trueValue)
% Fonction de Newton
%
%   * Entr�e :
%       -> fun - handle - Pointeur de la fonction � traiter
%       -> deriv - handle - Pointeur sur la d�riv�e de fonction � traiter
%       -> p0 - Float - premi�re approximation
%       -> tol - Float - crit�re d'arret
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%       -> trueValue - Float - v�ritable valeur de la racine
%   * Sortie : 
%       -> xfinal - Float - L'approximation de notre racine
%       -> nbIter - Int - Nombre d'iterations necessaire pour trouver la
%       bonne valeur approch�e
%       -> err - [Float] - Valeur de l'erreur entre l'�l�ment calcul� et la
%       v�ritable valeur
i=2;
pn=p0-fun(p0)/deriv(p0);
p=[p0;pn];
err=[];
while i<iterMax && abs(p(i)-p(i-1))/abs(p(i))>tol
    pn=p(i)-fun(p(i))/deriv(p(i));
    err=[err;abs(pn-trueValue)];
    p=[p;pn];
    i=i+1;

end
xfinal=p(i);
nbIter=i;