function [] = analyse_un_fichier(aX, aY, aZ, featVect, Keywords)

load('models.mat');
bContinuer = 1;

while bContinuer
    idc = input('Choisir le numéro de l échantillon [1, 2290] : ');
    pred_DT = predict(DT_MDL,featVect(idc,:));
    out_DT = labeling(pred_DT);
    pred_KNN = predict(KNN_MDL,featVect(idc,:));
    out_KNN = labeling(pred_KNN);
    
    figure();
    plot(sqrt(aX(idc,:).^2 + aY(idc,:).^2 + aZ(idc,:).^2));
    grid on
    titre_ = ['Activité : ', Keywords(idc), ' - DT : ', out_DT, ' - KNN : ', out_KNN];
    titre = '';
    for i=1:size(titre_,2)
        titre = strcat(titre, titre_(i));
    end
    title(titre);
    bContinuer = input('Voulez-vous tester un autre échantillon ? [1/0] ');
    close all
end

end

function output = labeling(prediction)

switch prediction
    case 1
        output = 'Inactif';
    case 2
        output = 'Marcher';
    case 3
        output = 'Jogging';
    otherwise
        output = 'Erreur';
        disp('Erreur');
end

end

