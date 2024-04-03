function featVect = extraction_variables_V2(aX, aY, aZ)

%%% Identification des activit�s - ouvTIS 2022/2023 %%%
%%% Manuel Abbas %%%

%% Calcul du module de l'acc�l�ration
for i=1:size(aX,1)
    aS(i,:) = sqrt(aX(i,:).^2 + aY(i,:).^2 + aZ(i,:).^2);
end

%% Extraction des variables %%
D = size(aS,1); % nombre d'�chantillons
%%% Variable #1 : dynamique du signal %%%
for i=1:D
    Var1(i,:) = range(aS(i,:));
end

%%% Variable #2 : moyenne du signal %%%
for i=1:D
    Var2(i,:) = mean(aS(i,:));
end

%%% Variable #3 : �cart-type du signal %%%
for i=1:D
    Var3(i,:) = std(aS(i,:));
end

% Cr�er la matrice des variables
featVect = [Var1, Var2, Var3];

end

