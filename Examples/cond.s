# Este programa le um inteiro do input e
# escreve no output o valor correspondente,
# de acordo com a instrucao condicional.
program = map() -> void [
x:int;
x:=read_int();
? [  x < 1 -> print_int(0);
   | x = 1 -> print_int(1);
   | x = 2 -> print_int(2);
   | x = 3 -> print_int(3);
   | x = 4 -> print_int(4);
   | x = 5 -> print_int(5);
   | x = 6 -> print_int(6);
   | x = 7 -> print_int(7);
   | x = 8 -> print_int(8);
   | x = 9 -> print_int(9);
   | * -> print_int(10);];
];
