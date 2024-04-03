%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Complement de mathematiques 1 - CMA1
%%    Groupe : 1
%%    NOMS - Prenoms : Chauvel Tom ; Bornert Jean-Eudes
%%    Date : 04/02/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-- 04/02/2022 09:07 --%

5+8

%-- 04/02/2022 09:13 --%
%% Exercice 1
% mainScriptTP1
11
ans
7
ans
a=11
b=12;
x=[1,2,3,4,5]
y=[1;2;3;4;5]
x1=[1:5]
y2=[1:5]'
A= [1 2 3 ; 2 3 1 ; 3 1 2]
A2= [A;A]
%A3=[A; 2 3]

%% Exercice 2
x3= [1:0.25:5]
qu2=magic(100)
qu3=randn(1,50)
qu4=repmat([1:5]',1,10)

%% Exercice 3
    %qu1
mat1=[1,2;3,4]
mat2=[4,5;7,2]
vect1=[5,6]
mat12=mat1.*mat2
mat1vect1=vect1*mat1    
    %qu2
A4=[2 1 -3 ; 1 -2 1]
rank(A4)
A5=A4*A4.'
detA5=det(A5)
traA5=trace(A5)
%detA4t=det(A4.')
%traA4t=trace(A4.')
    %qu3
xrand=rand(1,10)
moyenne=mean(xrand)
ecarttype=std(xrand)
mediane=median(xrand)
sort(xrand)

%% Exercice 4
    %qu1
zrand=2*randn(1,8000)+4
    %qu2&3
figure(1)
plot(1:8000,zrand)
figure(2)
hist(zrand,100)
    %qu7,8&9
figure(3)
subplot(2,1,1)
plot(zrand)
title('Valeur de l''experience aleatoire - zrand')
xlabel('Realisation')
ylabel('Valeurs')
subplot(2,1,2)
hist(zrand,100)
title('histogramme de zrand')
xlabel('valeurs')
ylabel('Frequence')

%% Exercice 5 

xBin(8)

