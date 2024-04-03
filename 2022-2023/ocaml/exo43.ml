type 'a interne = { mutable precedent : 'a maillon ; etiquette : 'a  ; mutable suivant : 'a maillon }

and 'a maillon =  | Vide 
                  | Interne of 'a interne

and 'a file = { mutable premier : 'a maillon ; mutable dernier : 'a maillon}

;;

let m1 = Interne({ precedent = Vide ; etiquette = 8 ; suivant = Vide });;


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

let create_file () = ({ premier = Vide ; dernier = Vide});;

let est_vide f = match f.premier,f.dernier with
    | Vide,Vide -> true
    | _ -> false
  ;;

let f : int file = create_file ();;

est_vide f ;;

let enfile el f = match f.premier,f.dernier with 
    | Vide,Vide -> let m = Interne({ precedent = Vide ; etiquette = el ; suivant = Vide })
                    in ( f.premier <- m; f.dernier <- m)
    | Interne(prem),Interne(dern) ->  
                    let m = Interne({ precedent = Interne(dern) ; etiquette = el ; suivant = Vide })
                    in 
                    (prem.precedent <- m
                    ;
                    dern.suivant <- m
                    ;
                    f.dernier <- m)
                    
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


enfile 3 f;;
enfile 6 f;;
enfile 2 f;;
affiche f;;

print_string("\n")

let defile f = match f.premier with
| Vide -> failwith "File Vide"
| Interne(e) -> let prec = (get_suiv e.suivant) in 
                
                e.etiquette
;;

print_int(defile f);;
print_string("\n")