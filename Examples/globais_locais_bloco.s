# programa que demonstra o uso de variaveis e constantes globais e locais,
# bem como a definicao de blocos
a:int:=5;  # variavel global
b:int=10;  # constante global
program = map() -> void [
   print_char(65);
   print_char(71);
   print_char(58);
   print_int(a);    # imprime 'a' global
   print_char(66);
   print_char(71);
   print_char(58);
   print_int(b);    # imprime 'b' global
   [
     a:int:=25; # variavel local
     b:int=30;  # constante local
     print_char(65);
     print_char(76);
     print_char(58);
     print_int(a);    # imprime 'a' local
     print_char(66);
     print_char(76);
     print_char(58);
     print_int(b);    # imprime 'b' local
   ]
];
