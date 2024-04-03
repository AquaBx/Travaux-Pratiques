clear all
close all
clc

%On cr�� des variables globales : 
a=0;
b=5;
tol=1e-6;
iterMax=100;
iter=1000;


%"format long" permet d'augmenter le nombre de chiffres significatifs. 
format long;

% On cherche les racines du polyn�me x^3 +4x^2-10
pol=[1 4 0 -10];
sol=roots(pol);
newsol=racineinter(0,5,sol);

%On appelle notre fonction "fonction1" qui calcule les valeurs de P(x). 
valx=[0,1];
valy=fonction1(valx,pol);

%On appelle notre fonction "dichotomic_func" qui permet de trouver la
%racine d'un polyn�me
[xfinal1 , nbIter1,err1]=dichotomic_func(a,b,tol,iterMax,newsol,pol);
%xfinal1 = 1.365228891372681

%On appelle notre fonction "dichotomic2_func" qui permet de trouver la
%racine d'un polyn�me plus rapidement
[xfinal2 , nbIter2,err2]=dichotomic2_func(a,b,tol,iterMax,newsol,pol);
%xfinal2 = 1.365229769765739

% On observe que notre 1er programme trouve une solution au bout de 21
% it�rations alors que le 2e programme trouve une solution au bout de 14
% it�rations

%On test le temps que met nos 2 programmes � r�aliser le calcul. 
t1=temps(iter,@dichotomic_func,newsol,pol); %Permet de trouver le temps moyen de dichotomic_func
%Temps trouv� : 1.7255e-04 secondes
t2=temps(iter,@dichotomic2_func,newsol,pol); %Permet de trouver le temps moyen de dichotomic2_func
%Temps trouv� : 1.5327e-04 secondes 
%Donc la diff�rence de temps est tr�s faible et quasiment n�gligeable. 






% On cherche maintenant une racine du polyn�me x^2 -1 entre 0 et 5
pol=[1 0 -1];
sol=roots(pol);
newsol=racineinter(0,5,sol);
[xfinal1 , nbIter1,err1]=dichotomic_func(a,b,tol,iterMax,newsol,pol);
[xfinal2 , nbIter2,err2]=dichotomic2_func(a,b,tol,iterMax,newsol,pol);
