let rec h n = 
  if n = 1 then 1.
  else 1. /. float_of_int(n) +. h(n-1)
;;

print_float(h 15);;

print_newline();;