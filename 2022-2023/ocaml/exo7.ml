let rec f( a, n ) = 
  if n = 0 then 1
  else if n = 1 then a
  else
    let d = n mod 2 in
    let calc = f (a,n/2) in
      calc
;;

print_int(f (3, 5 ));;

print_newline();;