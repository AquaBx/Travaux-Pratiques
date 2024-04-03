(* $file ="tpfinal" ;cls; wsl ocamlc ./$file.ml -o ./$file ;  wsl ./$file *)



type token = Entier of int | Operation of char;;
type calcul = N of calcul * char * calcul | F of int;;


let rec print_calc a = match a with
    | F(n) -> print_int(n);
    | N(ng,op,nd) -> print_string("N( ") ; print_calc(ng); print_char(op); print_calc(nd);print_string(" )");
;;


let dictionnaire = [(let f x y = x+y in ('+', f));
  (let f x y = x-y in ('-', f));
  (let f x y = x*y in ('*', f));
  (let f x y = x/y in ('/', f));
  (let f x y = x mod y in ('%', f))]
;;

let recherche_operation c = 
    let rec aux c liste =
      match liste with
      | [] -> failwith "recherche_operation"
      | (op,f)::_ when op = c -> f 
      | (op,f)::q -> aux c q 
    in aux c dictionnaire
;;

let rec evalue cal = match cal with 
    | F(n) -> n
    | N(F(nog),op,F(nod)) -> let f = recherche_operation op in f nog nod
    | N( ng , op, F(nod) ) -> let f = recherche_operation op in f (evalue ng) nod
    | N( F(nog) , op , nd) -> let f = recherche_operation op in f nog (evalue nd)
    | N(ng,op,nd) -> let f = recherche_operation op in f (evalue ng) (evalue nd)
;;

let rec verif_div_par_zero cal = match cal with
    | F(n) -> true
    | N(F(nog),op,F(nod)) -> if nod=0 && op = '/' then true else false
    | N( ng , op, F(nod) ) -> if nod=0 && op = '/' then true else verif_div_par_zero ng
    | N( F(nog) , op , nd) -> if verif_div_par_zero nd then true else if evalue nd = 0 && op = '/' then true else false 
    | N(ng,op,nd) -> if verif_div_par_zero nd || verif_div_par_zero ng then true else if (evalue nd = 0 && op = '/') then true else false 
;;

let rec i_calcul cal = match cal with
  | F(n) -> string_of_int(n);
  | N(ng,op,nd) -> "( " ^ i_calcul(ng) ^ " " ^ (String.make 1 op) ^ " " ^  i_calcul(nd) ^  " )";
;;

let polonaise_inversee l = 
  let rec aux li laux =
    match li,laux with
    | [],[n] -> n
    | Operation(a)::nli , b::c::nlaux -> if (b=0 && a = '/') then (failwith "division par zéro")
    else (aux nli ((evalue (N(F(c),a,F(b))))::nlaux))
    | Entier(a)::nli , laux -> (aux nli (a::laux))
    
  in aux l []
  
;;



(* let reconstitue_arbre l =
  let rec aux lis a ret = 
    match lis with 
    | [] -> a
    | Entier(n1)::Operation(op)::reste -> aux reste (N(a,op,F(n1))) ret
    | Entier(n1)::reste -> aux reste a (n1::ret)
    | Operation(op)::reste -> match a,ret with
                              | a1::a2::restea, [] -> aux reste (N(a2,op,a1))::resta []
                              | [] , ret1::ret2::rester -> aux reste [N(F(ret2,op,ret1))] rester

  in aux (List.tl l ) [(F(List.hd l))] []
;;

(print_calc (reconstitue_arbre [Entier(34);Entier(52);Operation('+');Entier(19);Entier(12);Entier(3);Operation('*');Operation('-');Operation('-')]))

*)










(* 

let f = recherche_operation '+' in print_int(f 6 9);;

let a2 = N(F(6), '/', N(F(6),'-',N(F(2),'*',F(3))));;

if verif_div_par_zero a2 then print_string("true")
else print_string("false")
print_string(i_calcul a2);;
print_int(polonaise_inversee [Entier(34);Entier(52);Operation('+');Entier(19);Entier(12);Entier(3);Operation('*');Operation('-');Operation('-')]) *)


(*

(* Tests *)

let a1 = N (N (F 2,'+', F 22), '*', F 41);;
let a2 = N (F 6, '/', N (F 6,'-', N(F 2,'*',F 3)));;

let l1 = [Entier(67);Entier(18);Operation('-')];;
let l2 = [Entier(34);Entier(52);Operation('+');Entier(19);Entier(12);Entier(3);Operation('*');Operation('-');Operation('-')];; *)