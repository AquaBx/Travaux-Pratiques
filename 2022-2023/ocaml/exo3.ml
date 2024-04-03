
let rec u n =
  if n = 0 then 1
  else 3*u(n-1) - 1
;;

print_int(u 15);;

print_newline();;