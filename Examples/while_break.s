# programa que imprime todos os valores inteiros desde 0 ate y, inclusive,
# utilizando ciclos, ifs e breaks
# (o valor de y e dado pelo utilizador)
escreve_valor = map () -> () [
   print_char(86);
   print_char(65);
   print_char(76);
   print_char(79);
   print_char(82);
   print_char(58);
];
program = map() -> void [
x:int:=0;
y:int;
escreve_valor();
y:=read_int();
* [ true  ->
	print_int(x);
	x := x + 1;
	? [ x > y -> break];
  ];
];
