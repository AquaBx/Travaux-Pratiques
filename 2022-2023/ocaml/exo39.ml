let eratosthene n = 
    let i = ref 2
    in
    let t = (Array.make (n+1) true)
    in
    t.(0) <- false;
    t.(1) <- false;
    while !i * !i <= n do
      if t.(!i) then
         for y=2 to n/(!i) do
            t.(!i*y) <- false
         done;
      i:=!i+1;
    done;
    t
;;

let x = eratosthene 1000 in for u=0 to 1000 do 
  if x.(u) then ( print_int(u); print_string(" true") ;print_newline(); )
  
done;;