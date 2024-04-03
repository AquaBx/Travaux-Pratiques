function [ xfinal , nbIter,err ] = dichotomic2_func(a,b,tol,iterMax,trueValue,pol)
%Fonction de trichotomie qui exécute l'algorithme de dichotomie sur
%l'intervalle [a,b] pour trouver la racine présente dans cet intervalle
%
%   * Entrée : 
%       -> a - Int - Borne inférieure de l'intervalle
%       -> b - Int - Borne supérieure de l'intervalle
%       -> tol - Float - Critère d'arrêt
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%   * Sortie : 
%       -> xFinal - Float - L'approximation de notre racine

i=0;
err=[];
cold1=1e15;
cold2=1e15;
c1=a+(b-a)/3;
c2=a+(b-a)/3*2;
while i<iterMax && ( abs(c1-cold1)/abs(c1)>tol || abs(c2-cold2)/abs(c2)>tol )
    
    fa=fonction1(a,pol);
    fc1=fonction1(c1,pol);
    fc2=fonction1(c2,pol);
    if fa*fc1<0
        b=c1;
    elseif fc2*fc1<0
        a=c1;
        b=c2;
    else
        a=c2;
    end
    cold1=c1;
    cold2=c2;
    c1=a+(b-a)/3;
    c2=a+(b-a)/3*2;
    
    err=[err,abs(trueValue-c1)];
    i=i+1;
end 
xfinal=c1;
nbIter=i;