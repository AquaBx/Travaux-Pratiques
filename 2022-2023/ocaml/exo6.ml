let rec f n =
  if n < 2 then n
  else ( f (n-1) + f (n-2))
;;

print_int(f 30);;
print_newline();;
print_int(f 40);;
print_newline();;