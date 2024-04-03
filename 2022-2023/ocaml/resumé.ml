type 'a tree = Leaf of 'a | Node of 'a tree * 'a tree;;

let rec print_int_tree a = match a with
    | Leaf(b) -> print_int(b);
    | Node(c,d) -> print_string("N( ") ; print_int_tree(c);print_string(" , "); print_int_tree(d);print_string(" )");
;;

let rec print_str_tree a = match a with
    | Leaf(b) -> print_string(b);
    | Node(c,d) -> print_string("N( ") ; print_str_tree(c);print_string(" , "); print_str_tree(d);print_string(" )");
;;


(* truc compliqué *)

type 'a interne = { mutable precedent : 'a maillon ; etiquette : 'a  ; mutable suivant : 'a maillon }

and 'a maillon =  | Vide 
                  | Interne of 'a interne

and 'a file = { mutable premier : 'a maillon ; mutable dernier : 'a maillon}

;;

let get_suiv m1 = match m1 with 
  | Vide -> failwith "Vide"
  | Interne(e) -> e.suivant             
;;

let get_et m1 = match m1 with 
  | Vide -> failwith "Vide"
  | Interne(e) -> e.etiquette             
;;

let get_prec m1 = match m1 with 
  | Vide -> failwith "Vide"
  | Interne(e) -> e.precedent         
;;

let affiche f = match f.premier,f.dernier with
    | Vide,Vide -> ()
    | Interne(prem),Interne(dern) -> (

      print_int(prem.etiquette);
      let i = ref(prem.suivant) in
      while !i <> Vide do
        print_string(" < ");
        print_int(get_et !i);
        i := (get_suiv (!i));
      done

    )
    ;;

(* affiche pile *)

let rec affiche_pile p = 
  
  if ( Stack.is_empty p ) then print_string(" | Fin \n")
  else 
    let el = (Stack.pop p) in
    ( 
      print_string(" | ") ;
      print_int(el) ;
      (affiche_pile p) ;
      (Stack.push el p) ;
      )
    ;;
    
(* affiche file *)

    let affiche_file p = 
  let rec aux2 p pa = 
    if ( Queue.is_empty pa ) then ()
    else (let el = (Queue.take pa) in (Queue.add el p);aux2 p pa)
  in
  let rec aux p pa = 
    (
      if ( Queue.is_empty p ) then (
        aux2 p pa ; 
        print_string("\n")
      )
    else 
      let el = (Queue.take p) in
      ( 
        print_int(el) ;
        print_string(" <- ") ;
        (Queue.add el pa) ;
        (aux p pa) ;
      ))
    in aux p (Queue.create ())
;;

(* exponentielle rapide *)

let rec expo_rapide x n = match n with
  | 0 ->  1
  | 1 ->  x
  | _ ->  if n mod 2 = 0 then (expo_rapide (x*x) (n/2))
          else x*(expo_rapide (x*x) (n/2))

(* Affiche int liste *)

let print_int_liste l =
    let rec aux ll =
      match ll with
      | [] -> ()
      | [x] -> print_int(x)
      | t::q -> ( print_int(t);print_string(" , "); aux(q) )
    in print_string("[ "); aux(l); print_string(" ]"); 
  ;;

(* Affiche unit liste *)

let print_unit_liste l =
  let rec aux ll =
    match ll with
    | [] -> ()
    | [()] -> print_string("()")
    | t::q -> ( print_string("()");print_string(" , "); aux(q) )
  in print_string("[ "); aux(l); print_string(" ]"); print_newline();
;;

(* affiche couple *)

let print_couple (a,b) = 
  print_string("( ");
  print_int_liste(a) ;
  print_string(" , ");
  print_int_liste(b);
  print_string(" )");
;; 

(* taille liste *)

let rec taille l = match l with 
    | [] -> 0
    | _::q -> 1+(taille q)
;;

(* mirroir liste *)

let rec miroir l = 
    let rec aux l l2 = match l with
        | [] -> l2
        | t::q ->  aux q (t::l2)
    in aux l []
;;


(* arbres *)

(* Exo30 *)

(* 

print_newline();;
print_string();;
print_int();;
print_float();;



*)

print_float(float_of_int(5));;
print_newline();;
print_int(int_of_float(5.));;
print_newline();;

let tab=[|1;2;3;4;5|] in
for i=0 to (Array.length tab)-1 do 
    print_int(tab.(i));
done;;

print_newline();;

let r = ref 5
in
while (!r != -1) do
  print_int(!r);
  r := !r - 1;
done;

