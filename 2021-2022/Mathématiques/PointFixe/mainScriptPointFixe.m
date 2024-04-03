%Fonctions qui peuvent etre utilisées dans l'algo du point fixe
#g1=@(x)x.^3+4.*x.^2+x-10;
#g2=@(x)((-x.^3+10).^(1/2))./2;
#g3=@(x)(-4.*x.^2+10).^(1/3);
#g4=@(x)x-(x.^3+4.*x.^2-10)./(3.*x^2+8.*x);




%[a,b]=fixedPoint_func(g1,1,10000,1e-6,1.365230013414097)
%[a,b]=fixedPoint_func(g2,-1,10000,1e-16,1.365230013414097)
%[a,b]=fixedPoint_func(g3,1,10000,1e-6,1.365230013414097)
% -2.682615006707049 + 0.358259359924043i
% -2.682615006707049 - 0.358259359924043i
%  1.365230013414097

#[a,b,c]=fixedPoint_func(g4,1,100,1e-20,1.365230013414097)

alpha=0.6
alpha2=0.1

g1=@(x)alpha*(cos(x)-x)+x
g2=@(x)alpha2*(cos(x)-x)+x

[a,b,c]=fixedPoint_func(g1,pi/2,1000,1e-10,0.739);
[d,e,f]=fixedPoint_func(g2,pi/2,1000,1e-10,0.739);


figure(1)
plot(1:b,a)

figure(2)

plot(1:e,d)