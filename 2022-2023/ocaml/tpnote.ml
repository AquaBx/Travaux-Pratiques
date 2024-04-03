type 'a tree = Leaf of 'a | Node of 'a tree * 'a tree;;

let rec print_int_tree a = match a with
    | Leaf(b) -> print_int(b);
    | Node(c,d) -> print_string("N( ") ; print_int_tree(c);print_string(" , "); print_int_tree(d);print_string(" )");
;;

let rec print_str_tree a = match a with
    | Leaf(b) -> print_string(b);
    | Node(c,d) -> print_string("N( ") ; print_str_tree(c);print_string(" , "); print_str_tree(d);print_string(" )");
;;


let a0 = Leaf(0);; 
let a1 = Node(Node(Leaf(0),Leaf(1)),Leaf(2)) ;;
let a2 = Node(Node(Node(Leaf(0),Leaf(1)),Leaf(2)),Node(Leaf(3),Leaf(4))) ;;

print_int_tree(a2);;
print_string("\n");;

(* 1.2 *)

let rec sub_tree a l = match l,a with 
| [],_ -> a
| _,Leaf(l) -> failwith("ce mot n'existe pas")
| t::q,Node(b,c) -> if t then (sub_tree c q)
else (sub_tree b q)
;;

print_int_tree( sub_tree a2 [false; false]);;
print_string("\n");;
(* print_int_tree( sub_tree a2 [false; true; false]);;
print_string("\n");; *)

(* 1.3 *)

let rec read a l = match l,a with 
| [],Node(_,_) -> failwith("on atteint pas une feuille")
| t,Leaf(l) -> l,t
| t::q,Node(b,c) -> if t then (read c q)
                    else (read b q)
;;

let (b,c) = read a2 [false; false; true];;
print_int(b);;
print_string("\n");;

let (b,c) = read a2 [false; true; ];;
print_int(b);;
print_string("\n");;


(* 1.4 *)

let rec decode a bl =
  if bl = [] then ""
  else
    (let b,c = (read a bl) in
    b ^ (decode a c))
;;

(* 1.5 *)


let arbre = Node(Node(Node(Leaf("a"),Leaf("e")),Leaf("n")),Leaf("t"));;
let m = [true;false;false;true;false;true;true;false;false;false;false;true;true];;

print_string(decode arbre m ^ "\n")
;;
(* 1.6 *)

let rec insert el l = match l with
  | [] -> el::l
  | t::q when t < el -> t::(insert el q)
  | t::q when t >= el -> el::l
;;

(* 1.7 *)

let merge cl = 
  let rec aux cl2 a =
    match cl2,a with
      | [],_ -> a
      | (_,t)::q, Leaf(f) -> aux q (Node(Leaf(f),Leaf(t)))
      | (_,t)::q, a -> aux q (Node(a,Leaf(t)))
  in
    match cl with
    | [] -> failwith("pas bon")
    | (_,t)::q -> aux q (Leaf(t))

;;

(* 1.8 *)

let huffman a = merge a;;

print_str_tree (huffman [(1,"a");(1,"e");(2,"n");(3,"t")]);;
print_string("\n");;
print_str_tree (arbre);;
print_string("\n");;

(* 1.9 *)

let rec extract a = 
    match a with
    | Leaf(b) -> (b,[])
    | Node(b,c) ->  