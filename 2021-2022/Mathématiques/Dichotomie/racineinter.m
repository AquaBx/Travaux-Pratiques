function  [ newsol ] = racineinter(a,b,sol)
newsol=[];
for s=sol.'
   if s<=b 
       if s>=a
        newsol=[newsol,s];
       end
   end
end