function [xfinal,nbIter,err]=fixedPoint_func(fun,p0,iterMax,tol,trueValue)
% Fonction d'itération du point fixe (fixed point iteration)
%
%   * Entrée :
%       -> fun - handle - Pointeur de la fonction à traiter
%       -> p0 - Float - initial approximation
%       -> tol - Float - critère d'arret
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%       -> trueValue - Float - véritable valeur de la racine
%   * Sortie : 
%       -> xfinal - Float - L'approximation de notre racine
%       -> nbIter - Int - Nombre d'iterations
%       -> err - [Float] - Valeur de l'erreur entre l'élément calculé et la
%       véritable valeur

i=1;
pn=p0;
err=[];
while i < iterMax && abs(pn - fun(pn))>tol
    err=[err;abs(pn-trueValue)];
    pn = [pn;fun(pn(i))];
    i=i+1;
end
xfinal = pn;
nbIter=i;