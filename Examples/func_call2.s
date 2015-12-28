# programa que imprime um calculo matematico, fazendo uso de chamadas de funcoes para
# o efeito
mult = map(x, y: int) -> int [
    return x * y;
];
calc = map(x, y : int) -> int [
    return mult(3,x) + mult(4,y);
];
program = map() -> void [
    x := read_int();
    y := read_int();
    z := calc(x,y);
    print_int(z);
];
