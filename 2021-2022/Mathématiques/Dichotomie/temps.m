function  [ moyenne ] = temps(iter,func,newsol,pol)

vector=[];
for i=[1:iter]
    tic;
    func(0,5,1e-6,100,newsol,pol);
    temps=toc;
    vector=[vector,temps];
end

moyenne=sum(vector)/iter;
