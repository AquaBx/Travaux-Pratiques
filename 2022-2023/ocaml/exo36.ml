type 'a file = 'a list * 'a list;;

let print_int_liste l =
    let rec aux ll =
      match ll with
      | [] -> ()
      | [x] -> print_int(x)
      | t::q -> ( print_int(t);print_string(" , "); aux(q) )
    in print_string("[ "); aux(l); print_string(" ]"); 
  ;;

let print_couple (a,b) = 
    print_string("( ");
    print_int_liste(a) ;
    print_string(" , ");
    print_int_liste(b);
    print_string(" )");
;; 

let rec taille l = match l with 
    | [] -> 0
    | _::q -> 1+(taille q)
;;

let rec miroir l = 
    let rec aux l l2 = match l with
        | [] -> l2
        | t::q ->  aux q (t::l2)
    in aux l []
;;

let file_vide () : 'a file = ([], []);;

let est_file_vide ( l : 'a file) = l = ([],[] );;  

let ajouter a ( (l1,l2) : 'a file) = (a::l1,l2);;

let suivant ( (l1,l2) : 'a file) = match l2 with 
    | [] -> (
                match (miroir l1) with
                | [] -> failwith "vide"
                | t::q ->  t , ([],q)
            )
    | t::q -> t,(l1,q)
;;

let f1 = ajouter 4 ( ajouter 5 ( ajouter 3 ( file_vide ())));;
let (x1, f2) = suivant f1;;
let (x2, f3) = suivant ( ajouter 8 f2);;
let (x3, f4) = suivant f3;;
let (x4, f5) = suivant f4;;

print_couple(f1);;
print_newline();;

print_int(x1);;
print_newline();;

print_couple(f2);;
print_newline();;

print_int(x2);;
print_newline();;

print_couple(f3);;
print_newline();;

print_int(x3);;
print_newline();;

print_couple(f4);;
print_newline();;

print_int(x4);;
print_newline();;

print_couple(f5);;
print_newline();;


let longueur ( (l1,l2) : 'a file ) = (taille l1) + (taille l2);;

print_int(longueur f3);;

print_newline();;

let elements ( (l1,l2) : 'a file ) = 
    let rec aux_con l = match l with
        | [] -> ""
        | t::[]-> ( string_of_int t)
        | t::q-> ( string_of_int t) ^ " >>> " ^ (aux_con q)

    in
    let a = (aux_con (miroir l2)) in
    let b = (aux_con l1) in

    if a = "" && b = "" then ""
    else if a="" then b
    else if b="" then a
    else a ^ " >>> " ^ b
;;

print_string( elements f2 );;
print_newline();;
print_string( elements f1 );;
print_newline();;
print_string( elements f3 );;
print_newline();;