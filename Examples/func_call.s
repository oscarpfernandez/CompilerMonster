# programa que chama a funcao "plus" (que soma dois inteiros) e
# imprime o resultado que esta devolve
plus = map (x,y : int) -> int [
   return x + y;
];
program = map() -> void [
   x:int;
   x := plus(2, 3);
   print_int(x);
];
