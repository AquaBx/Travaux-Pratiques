%%% Identification des activites - ouvTIS 2022/2023 %%%
%%% Manuel Abbas %%%

clear all;
close all;
addpath('fonctions');

%% Charger les donnees %%
load('Data.mat')

%% Illustrer un exemple %%
idc = input('Choisir le numero du signal [1, 2290] : ');
plot(sqrt(aX(idc,:).^2 + aY(idc,:).^2 + aZ(idc,:).^2));
grid on
title(Keywords(idc));

%% Extraction des variables %%
featVect = extraction_variables_V1(aX, aY, aZ); % 1er groupe
%featVect = extraction_variables_V2(aX, aY, aZ); % 2eme groupe

%% Distribution des donnees dans un espace 3D %%
illustrer_data(featVect, Labels);

%% Evaluation des modeles %%
%%% Arbre de decision (DT) et k-plus proches voisins (KNN) %%%
[prec_DT, prec_KNN] = Evaluation(featVect, Labels);
disp(['Precision de DT : ', num2str(prec_DT), '%']);
disp(['Precision de KNN : ', num2str(prec_KNN), '%']);

%% Illustration et prediction par echantillon %%
analyse_un_fichier(aX, aY, aZ, featVect, Keywords);