let rec b (n, k) = 
  if k > n then 0
  else if k = 0 then 1
  else
    n * b( n-1, k-1 ) / k
  ;;
    
print_int( b( 15, 8) )