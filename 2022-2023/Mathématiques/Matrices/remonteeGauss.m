function [ sol ] = remonteeGauss ( x,b )
    n=length(x);

    sol = zeros(n,1);
    for i = n:-1:1
          sol(i) = ( b(i) - x(i,i+1:n) * sol(i+1:n) )/ x(i,i);
    end

end
