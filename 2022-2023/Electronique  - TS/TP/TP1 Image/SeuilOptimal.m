function [ bestseuil ] = SeuilOptimal(Im)
% recherche le seuil optimal à partir de l'image Im (en entrée) afin de binariser
% une image

% Calcul manuel de l'histogramme pour 100 bins
hi=zeros(1,100);
delta=(max(max(Im))-min(min(Im)))/100;
I=min(min(Im)):delta:max(max(Im))-delta;
for i=1:length(I)
    hi(i)=nnz((Im>I(i))&(Im<I(i)+delta));
end

% Recherche automatique du seuil
bestseuil=1;
best_sigma=0;
sigma=0;  % métrique 
mu1=0;  % moyenne classe 1
mu2=0;  % moyenne classe 2
for seuil=1:length(hi)-1
    q1=sum(hi(1:seuil));
    q2=sum(hi(seuil+1:end));
    mu1=sum(hi(1:seuil).*(1:seuil))/q1;
    mu2=sum(hi(seuil+1:end).*(seuil+1:length(hi)))/q2;
    sigma=q1*q2*(mu1-mu2)^2; 
    if sigma>=best_sigma
        best_sigma=sigma;
        bestseuil=seuil;
    end
end
bestseuil=bestseuil/100;

end


