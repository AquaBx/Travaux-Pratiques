function [xfinal,nbIter,err]  = newton_func(fun,deriv,p0,iterMax,tol,trueValue)
% Fonction de Newton
%
%   * Entrée :
%       -> fun - handle - Pointeur de la fonction à traiter
%       -> deriv - handle - Pointeur sur la dérivée de fonction à traiter
%       -> p0 - Float - première approximation
%       -> tol - Float - critère d'arret
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%       -> trueValue - Float - véritable valeur de la racine
%   * Sortie : 
%       -> xfinal - Float - L'approximation de notre racine
%       -> nbIter - Int - Nombre d'iterations necessaire pour trouver la
%       bonne valeur approchée
%       -> err - [Float] - Valeur de l'erreur entre l'élément calculé et la
%       véritable valeur
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