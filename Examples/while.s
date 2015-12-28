# programa que imprime todos os valores inteiros desde 0 ate 10, inclusive
program = map() -> void [
x:int:=0;
* [ x <= 10 ->
	print_int(x);
	x := x + 1;
  ];
];
