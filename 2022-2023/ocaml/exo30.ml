type 'a arbre = V | N of 'a arbre * 'a * 'a arbre;;

let arbre_ex = N(
                    N(
                      N( V , 41 , V),
                      15,
                      N( V , 22 , V)
                    ) , 
                    28 ,
                    N(
                      V,
                      41,
                      V
                    ) 
                )
;;

let rec taille a = match a with
  | V -> 0
  | N( V, _ , V) -> 1
  | N( b, _ , c) -> (taille c) + (taille b) + 1
;;

let rec nb_feuille a = match a with
  | V -> 0
  | N( V, _ , V) -> 1
  | N( b, _ , c) -> (nb_feuille c) + (nb_feuille b)
;;

let rec hauteur a = match a with
  | V -> -1
  | N( V, _ , V) -> 0
  | N( b, _ , c) -> (max (hauteur c) (hauteur b) ) + 1
;;

let rec somme a = match a with
  | V -> 0
  | N( b, e , c) -> (somme b) + (somme c) + e
;;

let rec appartient a el = match a with
  | V -> false
  | N( b, e , c) -> if el = e then true
                    else (appartient b el) || (appartient c el)
;;

let rec appartient_et_compte a el = match a with
  | V -> (false , 0)
  | N( b, e , c) -> match (appartient_et_compte b el ),(appartient_et_compte c el ) with 
                    | ( boole1 , comp1 ) , ( boole2 , comp2 ) ->  if el = e then ( true, 1+comp1+comp2 )
                                                                  else (boole1||boole2 , comp1 + comp2)
;;

print_string("hauteur : ");;
print_int( hauteur arbre_ex );;
print_newline();;
print_string("nb_feuille : ");;
print_int( nb_feuille arbre_ex );;
print_newline();;
print_string("taille : ");;
print_int( taille arbre_ex );;
print_newline();;
print_string("somme : ");;
print_int( somme arbre_ex );;
print_newline();;


if ( appartient arbre_ex 41 ) then print_string("true")
else print_string("false")
;;
print_newline();;

if ( appartient arbre_ex 37 ) then print_string("true")
else print_string("false")
;;
print_newline();;

let print_couple (a,b) =
    (
      if a then print_string("true") 
      else print_string("false");
      print_int(b);
    )
;;

let print_int_liste l =
  let rec aux ll =
    match ll with
    | [] -> ()
    | [x] -> print_int(x)
    | t::q -> ( print_int(t);print_string(" , "); aux(q) )
  in print_string("[ "); aux(l); print_string(" ]"); print_newline();
;;

print_couple (appartient_et_compte arbre_ex 37)

let rec parents a el = match a with
  | V -> []
  | N( b, et , c) -> match b,c with 
                  | N(_,et1,_),N(_,et2,_) when (et1 = el || et2 = el) -> et::(parents b el)@(parents c el)
                  | _,_ -> (parents b el)@(parents c el)
;;

print_int_liste( parents arbre_ex 41 );;

print_int_liste( parents arbre_ex 22 );;

print_int_liste( parents arbre_ex 28 );;
print_int_liste( parents arbre_ex 15 );;



