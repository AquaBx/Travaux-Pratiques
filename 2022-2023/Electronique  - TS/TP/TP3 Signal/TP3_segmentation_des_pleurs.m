%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auteur : Sandie Cabon               
% But :  Segmentation et caractérisation des pleurs
% Description : Energie, fft
% Date : 09/03/2018                
% Version : 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear

%% Chargement du fichier
[signal_entree,FS] = audioread('crying_beeps.wav');

N = 30;       % Taille du vecteur
t = ((0:1:length(signal_entree)-1)*(1/FS));       % Echelle temporelle

%Affichage du signal

figure(1); 
plot(t,signal_entree);
xlabel('Temps (s)'); ylabel('Amplitude (mV)'); title('Signal original')

%% 1. Segmentation à partir de l'energie du signal

seuil = 0.0021;
[signal_sortie_1,vecteur_logique] = segmentation_energie_glissante(signal_entree,FS,N,seuil);

% enregistrement de l'extrait

%% 2. Segmentation à partir de la FFT
[signal_sortie_2] = segmentation_fft(signal_sortie_1,vecteur_logique,FS);

%Donner la 1ere et la dernière figure

% enregistrement de l'extrait


% Affichage
figure()
plot(t,signal_sortie_2);
xlabel('Temps (s)'); ylabel('Amplitude (mV)'); title('Signal final')

% Calcul de la durée moyenne des pleurs

% m=11026;
% signal_sortie_3 = zeros(length(signal_sortie_2),1);
% 
% for l = m/2+1:length(signal_sortie_2)-m/2-1
%     signal_sortie_3(l) = sum(signal_sortie_2(l-m/2:l+m/2))/length(signal_sortie_2(l-m/2:l+m/2));
% end
% 
% vl = abs(signal_sortie_3)>0;
% figure()
% plot(vl)


% somme = 0;
% indice = 0;
% count = 0;
% for k = 1:length(signal_sortie_2)-1
%     if not( signal_sortie_2(k) == 0 )
%         count = count + 1;
%     elseif not(count==0)
%         somme = somme + count/FS;
%         indice = indice + 1;
%         count = 0;
%     end
% end

count = 0;

for k = 1:length(signal_sortie_2)-1
    if not( signal_sortie_2(k) == 0 )
        count = count + 1;
    end
end

count/FS/7

load('donnees_bebe.mat');
grp1 = data(1:10,2);

grp2 = data(11:20,2);

figure();
boxplot([grp1,grp2]);