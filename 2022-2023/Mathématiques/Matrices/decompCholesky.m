function [ S ] = decompCholesky (matA)
  %Fonction utilisee pour realiser la decomposition de Choleski

  S = zeros(size(matA));

  for i=1:length(matA)

    S(i,i) = sqrt( matA(i,i) - S(:,i)' * S(:,i) );

    y=i+1;
    S(i,y:end) = ( matA(i,y:end) - S(:,i)' * S(:,y:end) ) / S(i,i);

  end
end
