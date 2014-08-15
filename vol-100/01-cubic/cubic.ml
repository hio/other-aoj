
open Scanf.Scanning;;

let cubic x = x * x * x in
let read_num f = Scanf.scanf "%d" f in

print_string ((string_of_int (read_num cubic)) ^ "\n")
