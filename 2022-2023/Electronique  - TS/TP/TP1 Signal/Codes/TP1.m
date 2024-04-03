%   SIG - Initiation Traitement Signal - TP1    %
clear all;  % efface toutes les variables déjà créées 
close all;  % ferme toutes les figures
clc;        % efface l'historique des commandes

%% Partie 1 : Convolution et Transformee de Fourier

%% 1/
% Initialisation
fe = ...;                            % Frequence d'echantillonage en Hz
D = ...;                                % Durée du signal en s
t = ...;     % Creation de l'axe temporel
T = ...;                               % Largeur de la porte en nb d'echantillons

% Création du signal s
s = ones(size(t));
s(t > ...)=0;
s(t < ...)=0;

% Affichage du signal
figure(1);
plot(..., ...);
title('Signal s');
xlabel('temps (s)');
ylabel('amplitude');

%% 2/
f = ...; % Creation de l'axe des frequences
S = fft(s);                                % TF du signal s

% Affichage
figure(2);
subplot(2, 1, 1); plot(..., ...);
xlabel('fréquences (Hz)');
ylabel('spectre de s');
title('Module et phase de la TF de s');
subplot(2, 1, 2); plot(..., ...);
xlabel('fréquences (Hz)');
ylabel('phase');

%% 3/
Y = fftshift(S);    % Permutation a l'aide de fftshift
figure(3);
subplot(2, 1, 1); plot(...);
xlabel('fréquences (Hz)');
ylabel('spectre de y');
title('Module et phase de Y');
subplot(2, 1, 2); plot(...);
xlabel('fréquences (Hz)');
ylabel('phase');

%% 4/
y_prime = ...;  % TF inverse de Y
s_prime = ...;  % TF inverse de S
figure(4);
subplot(1, 2, 1); plot(..., ...);
xlabel(...);
ylabel(...);
title(...);
subplot(..., ..., ...); plot(..., ...);
xlabel(...);
ylabel(...);
title(...);

%% 5/
x = conv(..., ..., 'same'); % Produit de convolution, l'argument 'same' permet 
                        % de retourner la convolution sur le meme nombre de 
                        % points que le signal de depart.
figure(5);
plot(...);
xlabel(...);
ylabel(...);
title(...);

%% 6/
X = fft(...);         % TF de x
S_carre = ...;     % Elevation au carre de S

figure(6);
plot(..., ...); hold on;
plot(..., ..., '--');
xlabel(...);
ylabel(...);
title(...);

%% Partie 2 : TF d'un signal carre

%% 1/
% Initialisation
fe = ...;                      % Fréquence d'echantillonage en Hz
F = ...;                        % Fréquence du signal en Hz
N = ...;                         % Nombre de périodes
D = ...;                % Duree du signal en s
t = ...;     % Creation de l'axe temporel

s = square(...);
figure(7);
plot(...);
xlabel(...);
ylabel(...);
title(...);

%% 2/
nb_points_fft = ...;  % Nombre de points de la FFT
f = ...;  % creation du vecteur frequentiel associe

S = fft(..., ...);  % FFT de s
figure(8);
plot(..., ...);
xlabel(...);
ylabel(...);
title(...);

%% Partie 3 : Debruitage d'un signal par FFT

% TF et TF inverse
% Initialisation
fe = ...;                      % Frequence d'echantillonnage en Hz
F = ...;                         % Frequence du signal en Hz
D = ...;                          % Duree du signal en s
A = ...;                          % Amplitude du signal
t = ...;    % Creation de l'axe temporel

s = ...;
figure(9);
plot(..., ...);
xlabel(...);
ylabel(...);
title(...);

%% 1/
f = ...; % Creation de l'axe des frequences
S = ...;  % FFT de s
figure(10);
plot(..., ...);
xlabel(...);
ylabel(...);
title(...);

%% 2/
s = ...;
figure(11);
plot(..., ...);
xlabel(...);
ylabel(...);
title(...);

%% Bruit Blanc
%3/
bruit = ... * rand(1,...) - ...;  % Creation d'un bruit blanc centre d'ampitude 1
figure(12);
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);
title(...);
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);

%% Bruitage du signal
% 4/
signal_bruite = ...;
SIGNAL_BRUITE = ...;
figure(13);
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);
title(...);
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);

%% Filtrage par FFT
%5/ et 6/

M = ...;  % Amplitude maximale de la TF du signal bruite
seuil = ...;                 % Seuil à 10%
H = zeros(...);
for n = 1:...
   if ... > seuil*M
       H(n) = ...;
   end
end

SIGNAL_BRUITE_FILTRE = ...;
signal_bruite_filtre = ...;
figure(14); 
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);
title(...);
subplot(2, 1, ...); plot(..., ...);
xlabel(...);
ylabel(...);

%% Etude parametrique
% 7/

% A vous de jouer
