function [ x ] = resolCholesky (L, b)
    % Résolution du système Ax = b en utilisant la factorisation de Cholesky
    n = length(L);

    % Résolution de L*y = b par substitution avant
    y = zeros(n,1);
    for i = 1:n
        y(i) = ( b(i) - L(i,1:i-1) * y(1:i-1) )/ L(i,i);
    end

    % Résolution de L^T*x = y par substitution arrière
    x = zeros(n,1);
    LT = L';
    for i = n:-1:1
          x(i) = ( y(i) - LT(i,i+1:n) * x(i+1:n) )/ LT(i,i);
    end
end
