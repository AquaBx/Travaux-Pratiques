function featVect = extraction_variables_V1(aX, aY, aZ)

%%% Identification des activités - ouvTIS 2022/2023 %%%
%%% Manuel Abbas %%%

%% Calcul du module de l'accélération
for i=1:size(aX,1)
    aS(i,:) = sqrt(aX(i,:).^2 + aY(i,:).^2 + aZ(i,:).^2);
end

%% Extraction des variables %%
N = size(aS,2); % longueur du signal
L = N/2; % moitié du signal
D = size(aS,1); % nombre d'échantillons
%%% Variable #1 : somme des moyennes des trois composantes %%%
for i=1:D
    Var1(i,:) = mean(aX(i,:)) + mean(aY(i,:)) + mean(aZ(i,:));
end

%%% Variable #2 : moyenne du module %%%
for i=1:D
    Var2(i,:) = mean(aS(i,:));
end

%%% Variable #3 : moyenne de la somme cumulative %%%
for i=1:D
    Var3(i,:) = mean(cumsum(aS(i,:)));
end

% Créer la matrice des variables
featVect = [Var1, Var2, Var3];

end

