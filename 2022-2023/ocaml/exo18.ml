
let print_int_liste l =
  let rec aux ll =
    match ll with
    | [] -> ()
    | [x] -> print_int(x)
    | t::q -> ( print_int(t);print_string(" , "); aux(q) )
  in print_string("[ "); aux(l); print_string(" ]"); print_newline();
;;

let print_unit_liste l =
  let rec aux ll =
    match ll with
    | [] -> ()
    | [()] -> print_string("()")
    | t::q -> ( print_string("()");print_string(" , "); aux(q) )
  in print_string("[ "); aux(l); print_string(" ]"); print_newline();
;;

(* Exo 18 *)

let m = int_of_float(2.0**15. -. 1.0);;

let f k = (123 * k + 15) mod m;;

let rec alea n u0 = 
  if n = 0 then []  
  else u0::( alea (n-1) (f(u0)) )
;;

let l = alea 10 1594;;
print_int_liste(l)

(* Exo 19 *)


let rec map f l = 
  match l with
  | [] -> []
  | t::q -> (f(t))::(map f q)

;;


print_int_liste(map (let f x = x mod 3 in f) l)


(* Exo 20 *)


let rec conc a b = match a with
  | [] -> b
  | t::q -> t::(conc q b)
;;

print_int_liste((conc [1;2] [3;4]));;

(* Exo 21 *)


 let rev l = 
  let rec aux l l2 = match l with
    | [] -> l2
    | t::q ->  aux q (t::l2)
  in aux l []
;;

print_int_liste(rev l)


(* Exo 22 *)

let rec filtre p l = match l with 
  | [] -> []
  | t::q -> if p t then t::(filtre p q)
            else (filtre p q)
;;

let p x = x mod 2 = 1;;

print_int_liste(filtre p l);;


(* Exo 23 *)

let rec fibogen y f0 f1 n = 
  if n = 0 then f0
  else if n = 1 then f1
  else fibogen y f1 ( y f1 f0 ) (n-1)
;;

let fibo_usuel n = fibogen (+) 0 1 n;;

let fiboword n = fibogen (^) "b" "a" n;;

let fibolist n = fibogen (@) [1] [0] n;;


print_int(fibo_usuel 3);;
print_newline();;

print_string(fiboword 5);;
print_newline();;

print_int_liste(fibolist 5);;
print_newline();;

(* Exo 24 *)

let rec nb_occ a l = match l with
  | [] -> 0
  | t::q -> if a=t then 1 + (nb_occ a q)
            else (nb_occ a q)
;;

print_int( nb_occ 0 (fibolist 5)  );;
print_newline();;
print_int( fibo_usuel 5 );;
print_newline();;

(* Exo 25 *)

let tronque n l = 
  let rec aux nl i = 
    if i=n then rev(nl)
    else (aux (List.tl(nl)) (i+1))
  in (aux (rev l) 0)
;;

print_int_liste( tronque 2 (fibolist 3) );;
print_newline();;
print_int_liste( tronque 2 (fibolist 4) );;
print_newline();;
print_int_liste( tronque 2 (fibolist 5) );;
print_newline();;
print_int_liste( tronque 2 (fibolist 6) );;
print_newline();;
print_int_liste( tronque 2 (fibolist 7) );;
print_newline();;
print_int_liste( tronque 2 (fibolist 8) );;
print_newline();;


(* Exo 26 *)

let rec remplace a lx l = match l with
  | [] -> []
  | t::q -> if t=a then lx @ (remplace a lx q)
            else t::(remplace a lx q)
;;

print_int_liste( remplace 0 [2;4] [0;1;0;0;1] );;
print_int_liste( remplace 5 [0;1] (remplace 1 [0] (remplace 0 [5] (fibolist 3))));;
print_int_liste( (fibolist 4) );;

print_string("\nExo 27 \n\n");;

let successeur nb_baton = ()::nb_baton;;

let rec entier_vers_baton n = if n=0 then []
                              else ()::(entier_vers_baton (n-1));;

let rec baton_vers_entier l = match l with
                              | [] -> 0
                              | t::q -> 1 + (baton_vers_entier q)
;;

print_unit_liste(successeur (entier_vers_baton 3));;

print_int(baton_vers_entier(successeur (entier_vers_baton 3)));;

let rec inferieur l1 l2 = match l1, l2 with
  | _ , [] -> false
  | [], _  -> true
  | ()::q1, ()::q2 -> inferieur q1 q2
;;

if inferieur [();();()] [();();()] = true then 
    print_string("true") 
else print_string("false");;


let somme l1 l2 = l1 @ l2;;

let rec difference l1 l2 = match l1,l2 with
                          | _,[] -> l1
                          | [],_ -> []
                          | _::a,_::b -> (difference a b)
;;

print_unit_liste ( difference [();] [();()] );;
print_newline();;

let rec produit l1 l2 = match l1,l2 with
                          | _,[] -> []
                          | _,[()] -> l1
                          | l,_::q -> l@(produit l q)
;;

print_unit_liste( produit [();();();();();] [();();();()])

let rec division l1 l2 =
  let rec aux a b count =  
    if (inferieur a b) then 
      ( count , a )
    else 
      aux (difference a b) b (()::count)
  in aux l1 l2 []
;;

let print_couple (c,d) = ( 
                  print_unit_liste(c);
                  print_string(" | ");
                  print_unit_liste(d) )
;; 

print_couple ( (division [();();()] [();();()]  ) )