function [prec_DT, prec_KNN] = Evaluation(Features, Labels)

%%% Identification des activités - ouvTIS 2022/2023 %%%
%%% Manuel Abbas %%%

%% Diviser en deux sous-ensembles (validation croisée) %%
%indices = crossvalind('Kfold', Labels, 10);
load('indices.mat')

for i = 1:10
    test = (indices == i); 
    train = ~test;
    %%% Arbre de décision %%%
    DT_MDL = fitctree(Features(train,:),Labels(train));
    %%% k-plus proches voisins %%%
    KNN_MDL = fitcknn(Features(train,:),Labels(train),'NumNeighbors',5);
    
    %%% performance %%%
    pred_DT = predict(DT_MDL,Features(test,:));
    pred_KNN = predict(KNN_MDL,Features(test,:));
    ConfMat_DT = confusionmat(Labels(test),pred_DT);
    ConfMat_KNN = confusionmat(Labels(test),pred_KNN);
    Accuracy_DT(i) = 100*sum(diag(ConfMat_DT))./sum(ConfMat_DT(:));
    Accuracy_KNN(i) = 100*sum(diag(ConfMat_KNN))./sum(ConfMat_KNN(:));
end

%%% Précision finale %%%
prec_DT = mean(Accuracy_DT);
prec_KNN = mean(Accuracy_KNN);

save('fonctions\models.mat', 'DT_MDL', 'KNN_MDL');

end

