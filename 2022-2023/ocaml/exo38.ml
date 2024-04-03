type arbreGN = Zero | N of arbreGN * arbreGN

let rec expo_rapide x n = match n with
  | 0 ->  1
  | 1 ->  x
  | _ ->  if n mod 2 = 0 then (expo_rapide (x*x) (n/2))
          else x*(expo_rapide (x*x) (n/2))

let expo2 n = expo_rapide 2 n;;

print_int( expo2 8 )

let rec evalue arbreGN = match arbreGN with
        | Zero -> 0
        | N(g,d) -> expo2(evalue g) + evalue(d)
;;

let arbre = N (
  N(
    
  ),
  N(

  )
)

print_newline();;
print_int( evalue arbreGN );;