function [xfinal,nbIter,err]  = falsePos_func(fun,a,b,iterMax,tol,trueValue)
% Fonction de la s�cante
% 
%   * Entr�e :
%       -> fun - handle - Pointeur de la fonction � traiter
%       -> a - Int - Borne inf�rieure de l'intervalle de recherche
%       -> b - Int - Borne sup�rieure de l'intervalle de recherche
%       -> tol - Float - crit�re d'arret
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%       -> trueValue - Float - v�ritable valeur de la racine
%   * Sortie : 
%       -> xfinal - Float - L'approximation de notre racine
%       -> nbIter - Int - Nombre d'iterations necessaire pour trouver la
%       bonne valeur approch�e
%       -> err - [Float] - Valeur de l'erreur entre l'�l�ment calcul� et la
%       v�ritable valeur

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