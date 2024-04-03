function [xfinal,nbIter,err]  = falsePos_func(fun,a,b,iterMax,tol,trueValue)
% Fonction de la sécante
% 
%   * Entrée :
%       -> fun - handle - Pointeur de la fonction à traiter
%       -> a - Int - Borne inférieure de l'intervalle de recherche
%       -> b - Int - Borne supérieure de l'intervalle de recherche
%       -> tol - Float - critère d'arret
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%       -> trueValue - Float - véritable valeur de la racine
%   * Sortie : 
%       -> xfinal - Float - L'approximation de notre racine
%       -> nbIter - Int - Nombre d'iterations necessaire pour trouver la
%       bonne valeur approchée
%       -> err - [Float] - Valeur de l'erreur entre l'élément calculé et la
%       véritable valeur

i=1;
deriv=@(a,b)(fun(b)-fun(a))/(b-a);
pn=a-fun(a)/deriv(a,b);
err=[];

if fun(a)*fun(pn)<0
  b=pn
else
  a=pn;
end
p=[pn]

while i<iterMax && abs(a-b)/abs(a)>tol
    pn=a-fun(a)/deriv(a,b);
    err=[err;abs(pn-trueValue)];
    if fun(a)*fun(pn)<0
      b=pn
    else
      a=pn;
    end
    p=[p;pn];
    i=i+1;
end
xfinal=p;
nbIter=i;