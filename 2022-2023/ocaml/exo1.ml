let a = 1789 in
let quotient = a / 3 in
let reste = a mod 3 in 
(quotient;reste)
;;


let a = 1515 in
  let b = a*a in
  b-1
  ;;


let rec a n = 
  if n = 0 then 1.
  else sin(a(n-1))
;;

print_float(a 5)