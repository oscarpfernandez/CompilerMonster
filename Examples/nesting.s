# este programa testa o "nesting" de funcoes com utilizacao de variaveis
# locais e globais
a:int:=0;  # variavel global
nesting = map () -> () [
    x:bool:=false;  # x variavel local
    nesting2 = map(x:int) -> bool [
      ? [  x <= 10 -> print_int(x);  # x argumento da funcao
	              return false;
          |    *   -> return true;
        ]
    ];
    * [not x ->
	 x := nesting2(a);
	 a:= a + 1;
      ];
];
program = map () -> () [
    nesting();
]
