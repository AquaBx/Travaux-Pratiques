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

let p1 = Stack.create () ;;
let p2 = Stack.create () ;;

Stack.push 2 p1; Stack.push 6 p1; Stack.push 3 p1;;
Stack.push 8 p2;;

affiche_pile p1;;
affiche_pile p1;;

let f = Queue.create ();;
Queue.add 3 f;Queue.add 6 f ; Queue.add 2 f;;

affiche_file f ;;
affiche_file f ;;


let rec taillePileRec p =
  if ( Stack.is_empty p ) then 0
  else 
    let el = (Stack.pop p) in
    ( 
      let a = (1 + (taillePileRec p)) in
      (
        (Stack.push el p);
        a
      );
    )
;;

let rec auMoins2 p =
  if ( Stack.is_empty p ) then false
  else 
    let el = Stack.pop p in
    if ( Stack.is_empty p ) then false
    else (
      (Stack.push el p);
      true
      )
;;

print_int( taillePileRec p1 );;
print_int( taillePileRec p1 );;
print_int( taillePileRec p2 );;
print_int( taillePileRec p2 );;

if (auMoins2 p1) then print_string("true") 
else print_string("false") 
;;
if (auMoins2 p1) then print_string("true") 
else print_string("false") 
;;
if (auMoins2 p2) then print_string("true") 
else print_string("false") 
;;
if (auMoins2 p2) then print_string("true") 
else print_string("false") 



let rec taillePileIt p =
  let pa = Stack.create () in
  let i = ref(0)
  in
  while not (Stack.is_empty p) do
    Stack.push ( Stack.pop p ) pa;
    i:= !i +1 ;
  done
  ;
  while not (Stack.is_empty pa) do
    Stack.push ( Stack.pop pa ) p
  done;
  !i
;;

let rec tailleFile f =
  let fa = Queue.create () in
  let i = ref(0)
  in
  while not (Queue.is_empty f) do
    Queue.add ( Queue.take f ) fa;
    i:= !i +1 ;
  done
  ;
  while not (Queue.is_empty fa) do
    Queue.add ( Queue.take fa ) f
  done;
  !i
;;

print_string("\n");;
affiche_pile p1;;
print_string("\n");;
print_int( taillePileIt p1 );;
print_string(" : ");;
affiche_pile p1;;
print_string("\n");;
print_int( taillePileIt p1 );;
print_string(" : ");;
affiche_pile p1;;


print_string("\n");;
affiche_file f;;
print_string("\n");;
print_int( tailleFile f );;
print_string(" : ");;
affiche_file f;;
print_string("\n");;
print_int( tailleFile f );;
print_string(" : ");;
affiche_file f;;


let rec reversePileIt p =
  let pa = Queue.create ()
  in
  while not (Stack.is_empty p) do
    Queue.add ( Stack.pop p ) pa;
  done
  ;
  while not (Queue.is_empty pa) do
    Stack.push ( Queue.take pa ) p
  done;
;;

let reversePileRec p =
  let rec aux2 p fa = 
    if ( Queue.is_empty fa ) then ()
    else Stack.push ( Queue.take fa ) p; aux2 p fa;
  in
  let rec aux p fa =
    if ( Stack.is_empty p ) then aux2 p fa

    else 
      let el = (Stack.pop p) in
      ( 
        (aux p) ;
        (Queue.add el fa) ;
      )
    in aux p (Queue.create ())
;;


affiche_pile p1;;

reversePileIt p1;;

affiche_pile p1;;


let rec reverseFileIt f =
  let pa = Stack.create ()
  in
  while not (Queue.is_empty f) do
    Stack.push ( Queue.take f ) pa;
  done
  ;
  while not (Stack.is_empty pa) do
    Queue.add ( Stack.pop pa ) f
  done;
;;

let rec reverseFileRec f =
  if ( Queue.is_empty f ) then ()

  else 
    let el = (Queue.take f) in
    ( 
      (reverseFileRec f) ;
      (Queue.add el f) ;
    )
;;

affiche_file f;;
reverseFileRec f;;
affiche_file f;;

print_string("\n");;

affiche_file f;;
reverseFileRec f;;
affiche_file f;;
