let f n = 
  let c = float_of_int(n) in
  int_of_float(c ** 8.);;

print_int(f 2);;

print_newline();;

let g n = 
  let a = n * n in
    let b = a * a in
      b*b
;;

print_int(g 2);;

print_newline();;
