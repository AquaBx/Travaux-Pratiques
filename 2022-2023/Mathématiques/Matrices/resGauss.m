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

tic()
[newA,newB] = descenteGauss(A,b);
remonteeGauss (newA,newB)
toc()
