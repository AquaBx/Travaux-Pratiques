let moyenne liste = 
  let rec aux liste2 somme longueur =
    match liste2 with
      | [] ->  (float_of_int somme)/.(float_of_int longueur)
      | t::q -> aux q (somme+t) (longueur+1)
  in aux liste 0 0
;;

print_float( moyenne [1;2;3;4;5] ) ;;

let exemple_reseau = 
  [
    ("Arthur", ["Benjamin";"Emmanuel"]);
    ("Benjamin", ["Arthur";"Chloé";"Gwenael"]);
    ("Chloé", ["Benjamin";"Gwenael"]);
    ("Delphine", ["Emmanuel";"Florian"]);
    ("Emmanuel", ["Arthur";"Delphine";"Gwenael"]);
    ("Florian", ["Delphine";"Gwenael"]);
    ("Gwenael", ["Benjamin";"Chloé";"Emmanuel";"Florian"]);
    ("Hervé", ["Inès"]);
    ("Inès", ["Hervé"])  
  ]