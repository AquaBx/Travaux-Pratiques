function [] = illustrer_data(featVect, Labels)

%%% Identification des activités - ouvTIS 2022/2023 %%%
%%% Manuel Abbas %%%

figure();
tf = find(Labels == 1); % inactif
plot3(featVect(tf,1), featVect(tf,2), featVect(tf,3), 'b.', 'MarkerSize',12);
grid on
hold on
tf = find(Labels == 2); % marcher
plot3(featVect(tf,1), featVect(tf,2), featVect(tf,3), 'r.', 'MarkerSize',12);
tf = find(Labels == 3); % jogging
plot3(featVect(tf,1), featVect(tf,2), featVect(tf,3), 'g.', 'MarkerSize',12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title('Distribution des données');
xlabel('Variable V1') 
ylabel('Variable V2')
zlabel('Variable V3')
legend('Inactif','Marcher','Jogging')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

