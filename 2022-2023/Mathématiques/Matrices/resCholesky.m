% Jean-Eudes BORNERT
% Tom CHAUVEL
% CUPGE 2 ESIR
% TP3 MATH-S4 : Resolution de systèmes linéaires
% Mardi 04 avril 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
load("./matlab_medium.mat","-mat");


tic();
newA_1=decompCholesky(A);
x=resolCholesky(newA_1',b)
toc()


