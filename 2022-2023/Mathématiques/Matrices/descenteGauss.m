function [ matA,matB ] = descenteGauss (matA,matB)

      n = length(matA);

      for i = 1:n

        P = eye(n); %matrice identité%
        P(i:end,i) = -matA(i:end,i)./matA(i,i);

        matA = P*matA;
        matB = P*matB;

  end
end
