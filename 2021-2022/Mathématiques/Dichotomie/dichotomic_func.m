function  [ xfinal , nbIter , err ] = dichotomic_func(a,b,tol,iterMax,trueValue,f)
%Fonction de dichotomie qui ex�cute l'algorithme de dichotomie sur l'
%intervalle [a,b] pour trouver la racine pr�sente dans cet intervalle
%
%   * Entr�e : 
%       -> a - Int - Borne inf�rieure de l'intervalle
%       -> b - Int - Borne sup�rieure de l'intervalle
%       -> tol - Float - Crit�re d'arr�t
%       -> iterMax - Int - Maximum d'iterations de notre algorithme
%   * Sortie : 
%       -> xFinal - Float - L'approximation de notre racine

i=0;
err=[];
cold=1e15;
c=a+(b-a)/2;
while i<iterMax && abs(c-cold)/abs(c)>tol
    
    fa=f(a);
    fc=f(c);
    if fa*fc<0
        b=c;
    else
        a=c;
    end
    cold=c;
    c=a+(b-a)/2;
    
    err=[err,abs(trueValue-c)];
    i=i+1;
end 
xfinal=c;
nbIter=i;
err=err;