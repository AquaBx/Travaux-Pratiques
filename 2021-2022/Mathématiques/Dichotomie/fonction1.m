function [ y ] = fonction1 ( x , pol )
%
%Fonction qui retoune un vecteur y correspondant aux valeurs de P(x) pour
%un vecteur x donn�

y= polyval(pol,x);
