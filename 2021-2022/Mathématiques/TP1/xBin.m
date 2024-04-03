function [ xBinaire ] = xBin( x )
%
%Fonction qui prend un entier x et le divise 
%consecutivement par 2 pour obtenir son ecriture binaire
%
% * Entree : 
%       -> x - Int - L'entier a binariser
% 
% * Sortie : 
%       -> xBinaire - [char] - chaine de caracteres
%       representant lequivalent binaire de x

q=floor(x/2);
r=mod(x,2);


xBinaire = num2str(r);
while q > 1
    r=mod(q,2);
    q=floor(q/2);
    xBinaire = xBinaire + num2str(r);
    end
xBinaire = xBinaire + num2str(q);
end