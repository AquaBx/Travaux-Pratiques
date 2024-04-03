%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auteur : Sandie Cabon
% But : Segmentation � partir de la fft
% Description :
% Date : 13/03/2018
% Version : 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [signal_sortie] = segmentation_fft(signal_entree,vecteur_logique,FS)
    seuil = 145;
    N = 4096;
    f =(0:N-1)*FS/N;
    num_fft=0;
    % Positions des segments
    diff_logical_vector = diff(vecteur_logique);
    fronts_montants = find(diff_logical_vector == 1);
    fronts_descendants = find(diff_logical_vector == -1);
    positions = [fronts_montants fronts_descendants];

    signal_sortie = signal_entree;

    for i=1:length(positions)
        segment = signal_entree(positions(i,1):positions(i,2));
        L = length(segment);
        figure()
        subplot(211)
        plot(segment)

        segment_fft = fftshift(fft(segment, N));
        moyenne = mean(segment_fft);

        subplot(212)
        plot(abs(segment_fft));hold on;
        plot(ones(size(segment_fft))*abs(moyenne),'r')

        passage = 0;

        % compter le nombre de fois ou le signal segment_fft passe par la
        % moyenne
        for j = 1:length(segment_fft)-1
            if abs( segment_fft(j) ) < abs( moyenne ) && abs( segment_fft(j+1) ) > abs( moyenne )
                passage = passage+1
            elseif abs( segment_fft(j) ) > abs( moyenne ) && abs( segment_fft(j+1) ) < abs( moyenne )
                passage = passage+1
            end
        end
        title(sprintf('Segment %i ,value %i',i,passage))

        %Definir la valeur qui permet de diff�rencier les deux classes
        if passage < 580
           signal_sortie(positions(i,1):positions(i,2)) = 0;
        end
    end
end
