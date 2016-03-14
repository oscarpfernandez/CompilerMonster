:-initialization(main).
:-dynamic(while/1).
:-include('apt.pl').

%-------------------------------------------------------%
%              predicados principais                    %
%-------------------------------------------------------%
main:- 
	open('erros.pl',write, Stream),
	set_output(Stream), 
	write(' ------------------- ERROS DO PROGRAMA --------------------------'), nl,nl, 
	close(Stream),	
	program(X),
	insere_pred(ST),	read_program(X, ST), !, 
	file_property('erros.pl', size(67)),
	insert_offset(ST), 
	print_main(ST),
	gc(ST, Cod, []),
	print_sim(Cod),
	retractall(while(_)).
    
	

read_program([], _).
read_program([X|Xs], ST):-  
	anal_sem(X, ST),
	read_program(Xs, ST).


%-------------------------------------------------------%
%        ANALISE SEMANTICA (criacao das ST's )          %
%-------------------------------------------------------%

% declaracao de variavel
%-----------------------
anal_sem(var_def([],_), _).

anal_sem(var_def([name(Id)|Ids], Tipo), ST):- 
	lookup_simples(ST, args, STargs),
	lookup_lista(STargs, Id, _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' --> Argumento com o mesmo nome ja foi declarado!') , nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo), ST)
	);
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(STids, n(Id), _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' --> Identificador ja declarado!') , nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo), ST)
	);
	anal_tipos(Tipo, Tipo1, _) ->
	(
	    insert(STvar, pai, STids),
	    insert(STvar, nome, Id),
	    insert(STvar, classe, decl(var_def)),
	    insert(STvar, const, false),
	    insert(STvar, lado_e, false),
	    insert(STvar, tipo, Tipo1),
	    insert(STvar, valor, _),
	    lookup_simples(ST, lista_ids, STids),
	    insert(STids, n(Id), STvar),
	    anal_sem(var_def(Ids, Tipo), ST)
	);
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' --> Tipo incorrecto!'), nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo), ST)
	).

    

% declaracao de variavel com inicializacao
%-----------------------------------------
anal_sem(var_def([],_, _), _).

anal_sem(var_def([name(Id)|Ids], Tipo, Exp), ST):- 
	lookup_simples(ST, args, STargs),
	lookup_lista(STargs, Id, _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Argumento com o mesmo nome ja foi declarado!') , nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo, Exp), ST)
	);
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(STids, n(Id), _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Identificador ja declarado!') , nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo, Exp), ST)
	);
	anal_tipos(Tipo, Tipo1,_),
	anal_tipos(Exp, Tipo2,_) ->
	(
	    Tipo1 = Tipo2 ->
	    (
		insert(STexp, pai, STvar),
		insert(STvar, pai, STids),
		insert(STvar, nome, Id),
		insert(STvar, classe, decl(var_def)),
		insert(STvar, const, false),
		insert(STvar, lado_e, false),
		insert(STvar, tipo, Tipo1),
		insert(STvar, valor, STexp),
		lookup_simples(ST, lista_ids, STids),
		insert(STids, n(Id), STvar),
		anal_sem(Exp, STexp),
		anal_sem(var_def(Ids, Tipo, Exp), ST)
	    );
	    (
		open('erros.pl', append, Stream),
		set_output(Stream),
		write('Erro na declaracao da variavel '),
		write(Id), write(' : '), write(Tipo), 
		write(' := '), write('exp...'), 
		write(' --> Tipos diferentes!'), nl,
		close(Stream),
		anal_sem(var_def(Ids, Tipo, Exp), ST)
	    )
	);
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da variavel '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Tipos diferentes na expressao!'), nl,
	    close(Stream),
	    anal_sem(var_def(Ids, Tipo, Exp), ST)
	).


% declaracao de constante com tipo explicito
%-------------------------------------------
anal_sem(cnst_def([], _, _), _).

anal_sem(cnst_def([name(Id)|Ids], Tipo, Exp), ST):- 
	lookup_simples(ST, args, STargs),
	lookup_lista(STargs, Id, _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Argumento com o mesmo nome ja foi declarado!') , nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Tipo, Exp), ST)
	);
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(STids, n(Id), _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Identificador ja declarado!') , nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Tipo, Exp), ST)
	);
	anal_tipos(Tipo, Tipo1,_),
	anal_tipos(Exp, Tipo2,_) ->
	(
	    Tipo1 = Tipo2 ->
	    (
		insert(STexp, pai, STconst),
		insert(STconst, pai, STids),
		insert(STconst, nome, Id),
		insert(STconst, classe, decl(cnst_def)),
		insert(STconst, const, true),
		insert(STconst, lado_e, false),
		insert(STconst, tipo, Tipo1),
		insert(STconst, valor, STexp),
		lookup_simples(ST, lista_ids, STids),    
		insert(STids, n(Id), STconst),
		anal_sem(Exp, STexp),    
		anal_sem(cnst_def(Ids, Tipo, Exp), ST)  
	    );
	    (
		open('erros.pl', append, Stream),
		set_output(Stream),
		write('Erro na declaracao da constante '),
		write(Id), write(' : '), write(Tipo), 
		write(' := '), write('exp...'), 
		write(' --> Tipos diferentes!'), nl,
		close(Stream),
		anal_sem(cnst_def(Ids, Tipo, Exp), ST)
	    )
	);
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' : '), write(Tipo), 
	    write(' := '), write('exp...'), 
	    write(' --> Tipos diferentes na expressao!'), nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Tipo, Exp), ST)
	).


% declaracao de constante com tipo implicito
%-------------------------------------------
anal_sem(cnst_def([], _), _).

anal_sem(cnst_def([name(Id)|Ids],  Exp), ST):- 
	lookup_simples(ST, args, STargs),
	lookup_lista(STargs, Id, _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' = '), write('exp...'), 
	    write(' --> Argumento com o mesmo nome ja foi declarado!') , nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Exp), ST)
	);
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(STids, n(Id), _) ->
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' = '), write('exp...'), 
	    write(' --> Identificador ja declarado!') , nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Exp), ST)
	);
	anal_tipos(Exp, Tipo1,_) ->
	(
	    insert(STexp, pai, STconst),
	    insert(STconst, pai, STids),
	    insert(STconst, nome, Id),
	    insert(STconst, classe, decl(cnst_def)),
	    insert(STconst, const, true),
	    insert(STconst, lado_e, false),
	    insert(STconst, tipo, Tipo1),
	    insert(STconst, valor, STexp),
	    lookup_simples(ST, lista_ids, STids),    
	    insert(STids, n(Id), STconst),    
	    anal_sem(Exp, STexp),    
	    anal_sem(cnst_def(Ids, Exp), ST)
	);
	(
	    open('erros.pl', append, Stream),
	    set_output(Stream),
	    write('Erro na declaracao da constante '),
	    write(Id), write(' = '), write('exp...'), 
	    write(' --> Tipos diferentes na expressao!'), nl,
	    close(Stream),
	    anal_sem(cnst_def(Ids, Exp), ST)
	).

	

% literais de inteiro
%--------------------
anal_sem(X, ST):-
	X = lit(int, Valor),
	insert(ST, classe, lit(int)),
	insert(ST, tipo, int),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, valor, Valor).


% literais de real
%-----------------
anal_sem(X, ST):-
	X = lit(real, Valor),
	insert(ST, classe, lit(real)),
	insert(ST, tipo, real),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, valor, Valor).


% literais de booleano
%---------------------
anal_sem(X, ST):-
	X = lit(bool, Valor),
	insert(ST, classe, lit(bool)),
	insert(ST, tipo, bool),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, valor, Valor).

% literais de tuplo
%------------------

% literais de array
%------------------
anal_sem(X, ST):-
	X = lit(array, Valores),
	anal_tipos(X, Tipo, _),
	insert(ST, classe, lit(array)),
	insert(ST, tipo, Tipo),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, valores, _),
	anal_sem(lista_val(Valores), ST).

anal_sem(lista_val([]), _).
anal_sem(lista_val([X|Xs]), ST):-
	anal_sem(X, STvalor),
	insert(STvalor, pai, ST),
	lookup_simples(ST, valores, ListaValores),
	insert_lista(ListaValores, STvalor),
	anal_sem(lista_val(Xs), ST).


% literais de funcao
%-------------------
anal_sem(X, ST):-
	X = lit(map, par(Par), Stats),
	insert(ST, classe, lit(map)),
	insert(ST, const, true),
	insert(ST, tipo, _),
	insert(ST, lado_e, false),
	insert(ST, args, _),
	insert(STlista_ids, pai, ST),
	insert(ST, lista_ids, STlista_ids),
	insert(ST, lista_stats, _),
	anal_sem(par(Par), ST),
	anal_sem(Stats, ST).


anal_sem(X, ST):-
	X = lit(map, par(Par), Tipo, Stats),
	anal_tipos(Tipo, Tipo1,_),
	insert(ST, classe, lit(map)),
	insert(ST, const, true),
	insert(ST, tipo, Tipo1),
	insert(ST, lado_e, false),
	insert(ST, args, _),
	insert(STlista_ids, pai, ST),
	insert(ST, lista_ids, STlista_ids),
	insert(ST, lista_stats, _),
	anal_sem(par(Par), ST),
	anal_sem(Stats, ST).


% operadores unarios
%-------------------
anal_sem(X,ST):-
	X = op(Op, name(Id)),
	(Op = not; Op = menos),
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(op(Op, name(Id)), ST).


anal_sem(X,ST):-
	X = op(Op, name(Id)),
	(Op = not; Op = menos),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid), 
	lookup_simples(STid, tipo, Tipo),
	lookup_simples(STid, const, Const),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, Const),
	insert(ST, lado_e, false),
	insert(ST, termo, STid).

anal_sem(X,ST):-
	X = op(Op, name(Id)),
	(Op = not; Op = menos),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo),
	lookup_simples(STid, const, Const),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, Const),
	insert(ST, lado_e, false),
	insert(ST, termo, STid).


anal_sem(X,ST):-
	(Op = not; Op = menos),
	X = op(Op, X1),
	X1 \= nome(_),
	anal_tipos(X1, Tipo,_),
	insert(ST1, pai, ST),
	anal_sem(X1, ST1),
	lookup_simples(ST1, const, Const),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, Const),
	insert(ST, lado_e, false),
	insert(ST, termo, ST1).


% OPERADORES BINARIOS
%--------------------------------
anal_sem(op(Op, name(Id), X2), ST):-
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(op(Op, name(Id), X2), ST).

anal_sem(op(Op, X2, name(Id)), ST):-
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(op(Op, X2, name(Id)), ST).


% operadores binarios aritmeticos
%--------------------------------
anal_sem(op(Op, name(Id), X2), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	X2 \= name(_),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid),
	insert(ST, termo_dir, ST2).

anal_sem(op(Op, name(Id), X2), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	X2 \= name(_),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid),
	insert(ST, termo_dir, ST2).

anal_sem(op(Op, X2, name(Id)), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	X2 \= name(_),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST2),
	insert(ST, termo_dir, STid).


anal_sem(op(Op, X2, name(Id)), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	X2 \= name(_),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST2),
	insert(ST, termo_dir, STid).

anal_sem(op(Op, name(Id1), name(Id2)), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id1), STid1), 
	lookup(STids, n(Id2), STid2),
	lookup_simples(STid1, tipo, Tipo),
	lookup_simples(STid2, tipo, Tipo),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid1),
	insert(ST, termo_dir, STid2).

anal_sem(op(Op, name(Id1), name(Id2)), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id1), STid1) -> 
	(
	    lookup(ST, args, ListaArgs),
	    lookup_lista(ListaArgs, Id2, STid2),
	    lookup_simples(STid1, tipo, Tipo),	    
	    lookup_simples(STid2, tipo, Tipo),
	    insert(ST, classe, op(Op)),
	    insert(ST, tipo, Tipo),
	    insert(ST, const, false),
	    insert(ST, lado_e, false),
	    insert(ST, termo_esq, STid1),
	    insert(ST, termo_dir, STid2)
	);
	(
	    lookup(ST, lista_ids, STids),
	    lookup(STids, n(Id2), STid2) ->
	    (
		lookup(ST, args, ListaArgs),
		lookup_lista(ListaArgs, Id1, STid1),
		lookup_simples(STid1, tipo, Tipo),
		lookup_simples(STid2, tipo, Tipo),
		insert(ST, classe, op(Op)),
		insert(ST, tipo, Tipo),
		insert(ST, const, false),
		insert(ST, lado_e, false),
		insert(ST, termo_esq, STid1),
		insert(ST, termo_dir, STid2)
	    );
	    (
		lookup(ST, args, ListaArgs),
		lookup_lista(ListaArgs, Id1, STid1),
		lookup_lista(ListaArgs, Id2, STid2),
		lookup_simples(STid1, tipo, Tipo),
		lookup_simples(STid2, tipo, Tipo),
		insert(ST, classe, op(Op)),
		insert(ST, tipo, Tipo),
		insert(ST, const, false),
		insert(ST, lado_e, false),
		insert(ST, termo_esq, STid1),
		insert(ST, termo_dir, STid2)
	    )
	).	
	    

anal_sem(op(Op, X1, X2), ST):-
	Op \= menor, Op \= menor_i, Op \= igual, Op\= maior, Op \= maior_i,
	Op \= dif, Op \= and, Op \= or,
	X1 \== name(_),
	X2 \== name(_),
	anal_tipos(op(Op, X1, X2), Tipo, ST),
	insert(ST1, pai, ST),
	insert(ST2, pai, ST),
	anal_sem(X1, ST1),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, Tipo),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST1),
	insert(ST, termo_dir, ST2).


% operadores binarios booleanos e de comparacao
%----------------------------------------------
anal_sem(op(Op, name(Id), X2), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div, 
	Op \= {mod},
	X2 \= name(_),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid),
	insert(ST, termo_dir, ST2).

anal_sem(op(Op, name(Id), X2), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div,  
	Op \= {mod},
	X2 \= name(_),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid),
	insert(ST, termo_dir, ST2).

anal_sem(op(Op, X2, name(Id)), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div,  
	Op \= {mod},
	X2 \= name(_),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST2),
	insert(ST, termo_dir, STid).


anal_sem(op(Op, X2, name(Id)), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div,  
	Op \= {mod},
	X2 \= name(_),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo),
	anal_tipos(X2, Tipo, ST), 
	insert(ST2, pai, ST),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST2),
	insert(ST, termo_dir, STid).

anal_sem(op(Op, name(Id1), name(Id2)), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div,  
	Op \= {mod},
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id1), STid1), 
	lookup(STids, n(Id2), STid2),
	lookup_simples(STid1, tipo, Tipo),
	lookup_simples(STid2, tipo, Tipo),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, false),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, STid1),
	insert(ST, termo_dir, STid2).

anal_sem(op(Op, name(Id1), name(Id2)), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div,  
	Op \= {mod},
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id1), STid1) -> 
	(
	    lookup(ST, args, ListaArgs),
	    lookup_lista(ListaArgs, Id2, STid2),
	    lookup_simples(STid1, tipo, Tipo),	    
	    lookup_simples(STid2, tipo, Tipo),
	    insert(ST, classe, op(Op)),
	    insert(ST, tipo, bool),
	    insert(ST, const, false),
	    insert(ST, lado_e, false),
	    insert(ST, termo_esq, STid1),
	    insert(ST, termo_dir, STid2)
	);
	(
	    lookup(ST, lista_ids, STids),
	    lookup(STids, n(Id2), STid2) ->
	    (
		lookup(ST, args, ListaArgs),
		lookup_lista(ListaArgs, Id1, STid1),
		lookup_simples(STid1, tipo, Tipo),
		lookup_simples(STid2, tipo, Tipo),
		insert(ST, classe, op(Op)),
		insert(ST, tipo, bool),
		insert(ST, const, false),
		insert(ST, lado_e, false),
		insert(ST, termo_esq, STid1),
		insert(ST, termo_dir, STid2)
	    );
	    (
		lookup(ST, args, ListaArgs),
		lookup_lista(ListaArgs, Id1, STid1),
		lookup_lista(ListaArgs, Id2, STid2),
		lookup_simples(STid1, tipo, Tipo),
		lookup_simples(STid2, tipo, Tipo),
		insert(ST, classe, op(Op)),
		insert(ST, tipo, bool),
		insert(ST, const, false),
		insert(ST, lado_e, false),
		insert(ST, termo_esq, STid1),
		insert(ST, termo_dir, STid2)
	    )
	).	
	    

anal_sem(op(Op, X1, X2), ST):-
	Op \= soma, Op \= sub, Op \= mult, Op \= div, 
	Op \= {mod},
	X1 \== name(_),
	X2 \== name(_),
	anal_tipos(op(Op, X1, X2), _, ST),
	insert(ST1, pai, ST),
	insert(ST2, pai, ST),
	anal_sem(X1, ST1),
	anal_sem(X2, ST2),
	insert(ST, classe, op(Op)),
	insert(ST, tipo, bool),
	insert(ST, const, true),
	insert(ST, lado_e, false),
	insert(ST, termo_esq, ST1),
	insert(ST, termo_dir, ST2).


% Expressao "referencia a array"
%------------------------------------------
anal_sem(array_ref(name(Id), Indice), STarray_ref):-
	lookup(STarray_ref, lista_ids, STids),
	lookup(STids, n(Id), STid) ->
	(
	    lookup_simples(STid, tipo, array(Tipo)) ->
	    (
		insert(STarray_ref, classe, op(array_ref)),
		insert(STarray_ref, nome, Id),
		insert(STarray_ref, lado_e, false),
		insert(STarray_ref, const, false),
		insert(STarray_ref, tipo, array(Tipo)),
		insert(STarray_ref, indice, STindice),
		anal_sem(Indice, STindice),
		lookup_simples(STindice, tipo, int)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na referencia a array '),
		write(Id), 
		write(' --> Identificador nao e um array!'), nl,
		close(Stream)
	    )
	);
	(
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na referencia a array '),
	    write(Id), 
	    write(' --> Array inexistente!'), nl,
	    close(Stream)
	).		
	

% Expressao "referencia a funcao"
%------------------------------
anal_sem(func_ref(name(Id), args(Args)), STfunc_ref):-
	lookup(STfunc_ref, lista_ids, STids), 
	lookup(STids, n(Id), STid) ->
	(
	    lookup_simples(STid, tipo, map) ->
	    (
		lookup_simples(STid, valor, STvalor),
		lookup_simples(STvalor, tipo, Tipo),
		lookup_simples(STvalor, args, ListaPar), 
		lookup_simples(STvalor, num_args, L),
		length(Args, L) ->
		(
		    insert(STfunc_ref, classe, op(func_ref)),
		    insert(STfunc_ref, nome, Id),
		    insert(STfunc_ref, lado_e, false),
		    insert(STfunc_ref, const, false),
		    insert(STfunc_ref, tipo, Tipo),
		    insert(STfunc_ref, args, ListaArgs),
		    insert(STfunc_ref, valor, STvalor),
		    anal_sem(args(Args), STfunc_ref),		    
		    verifica_args(ListaArgs, ListaPar) ->
		    (
			length(Args, L)
		    );
		    (
			open('erros.pl',append, Stream),
			set_output(Stream),
			write('Erro na referencia a funcao '),
			write(Id), 
			write(' --> Argumentos incorrectos!'), nl,
			close(Stream)
		    ) 
		);
		(
		    open('erros.pl',append, Stream),
		    set_output(Stream),
		    write('Erro na referencia a funcao '),
		    write(Id), 
		    write(' --> Numero de argumentos incorrecto!'), nl,
		    close(Stream)
		)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na referencia a funcao '),
		write(Id), 
		write(' --> Identificador nao e uma funcao!'), nl,
		close(Stream)
	    )
	);
	(
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na referencia a funcao '),
	    write(Id), 
	    write(' --> Funcao inexistente!'), nl,
	    close(Stream)
	).

% Expressao "chamada de funcao recursiva"
%----------------------------------------
anal_sem(r_func_ref(args(Args)), STr_func_ref):-
	encontra_funcao(STr_func_ref, STfunc),
	lookup_simples(STfunc, num_args, L),
	length(Args, L) ->
	(
	    lookup_simples(STfunc, tipo, Tipo),
	    lookup_simples(STfunc, args, ListaPar),
	    lookup_simples(STfunc, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    insert(STr_func_ref, classe, op(r_func_ref)),
	    insert(STr_func_ref, nome, Nome),
	    insert(STr_func_ref, lado_e, false),
	    insert(STr_func_ref, const, false),
	    insert(STr_func_ref, tipo, Tipo),
	    insert(STr_func_ref, args, ListaArgs),
	    insert(STr_func_ref, valor, STfunc),
	    anal_sem(args(Args), STr_func_ref),
	    verifica_args(ListaArgs, ListaPar) ->
	    (
		true
	    );
	    
(		encontra_funcao(STr_func_ref, ST1),
		lookup_simples(ST1, pai, STpai),
		lookup_simples(STpai, nome, Nome),
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na referencia recursiva a funcao '),
		write(Nome), 
		write(' --> Argumentos incorrectos!'), nl,
		close(Stream)
	    )
	);
	(
	    encontra_funcao(STr_func_ref, ST1),
	    lookup_simples(ST1, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na referencia recursiva a funcao '),
	    write(Nome), 
	    write(' --> Numero de argumentos incorrecto!'), nl,
	    close(Stream)
	).

% Instrucoes (geral)
%-------------------
anal_sem(stats([]), _).
anal_sem(stats([X|Xs]), ST):-
	anal_sem(X, ST),
	anal_sem(stats(Xs), ST).

% Instrucao "assign"
%-------------------
anal_sem(assign([], _), _).
anal_sem(assign([X|Xs], Exp), ST):-
    anal_sem(assign(X, Exp), ST),
    anal_sem(assign(Xs, Exp), ST).

anal_sem(assign(name(Id), Exp), ST):-
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(assign(name(Id), Exp), ST).

anal_sem(assign(name(Id), Exp), ST):-
	Exp \= name(_), 
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid), 
	lookup_simples(STid, tipo, Tipo),
	insert(STassign, pai, ST),
	insert(STassign, classe, statment(assign)),
	insert(STassign, const, false),
	insert(STassign, tipo, void),
	insert(STassign, lhs, STid),
	insert(STassign, rhs, STexp),
	insert(STexp, pai, STassign),  
	anal_tipos(Exp, Tipo, ST),
	anal_sem(Exp, STexp),
	lookup_simples(STexp, tipo, Tipo),
	lookup_simples(ST, lista_stats, Lista),
	insert_lista(Lista, STassign).
	
anal_sem(assign(name(Id), Exp), ST):-	
	Exp = name(Idexp),
	nao_existe(name(Idexp), ST),
	open('erros.pl',append, Stream),
	set_output(Stream),
	write('Erro na instrucao assign '),
	write(Id), write(' := '), write(Idexp), 
	write(' --> Identificador '), write(Idexp), write(' nao definido!'), nl,
	close(Stream).		

anal_sem(assign(name(Id), Exp), ST):-	
	Exp = name(Idexp),
	lookup(ST, lista_ids, STids),
	lookup(lista_ids, n(Idexp), STExp),  
	lookup(STids, n(Id), STid), 
	lookup_simples(STid, tipo, Tipo),	
	insert(STassign, pai, ST),
	insert(STassign, classe, statment(assign)),
	insert(STassign, const, false),
	insert(STassign, tipo, void),
	insert(STassign, lhs, STid),
	insert(STassign, rhs, STExp), 
	lookup_simples(STExp, tipo, Tipo),	
	lookup_simples(ST, lista_stats, Lista),
	insert_lista(Lista, STassign).

anal_sem(assign(name(Id), Exp), ST):-	
	Exp = name(Idexp),
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Idexp, STExp),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid), 
	lookup_simples(STid, tipo, Tipo),	
	insert(STassign, pai, ST),
	insert(STassign, classe, statment(assign)),
	insert(STassign, const, false),
	insert(STassign, tipo, void),
	insert(STassign, lhs, STid),
	insert(STassign, rhs, STExp), 
	lookup_simples(STExp, tipo, Tipo),	
	lookup_simples(ST, lista_stats, Lista),
	insert_lista(Lista, STassign).


anal_sem(assign(name(Id), Exp), ST):- 
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STid), 
	lookup_simples(STid, tipo, Tipo1),       
	insert(STassign, pai, ST),
	insert(STassign, classe, statment(assign)),
	insert(STassign, const, false),
	insert(STassign, tipo, void),
	insert(STassign, lhs, STid),
	insert(STassign, rhs, STexp),
	insert(STexp, pai, STassign),  
	anal_tipos(Exp, Tipo2, ST) ->
	(
	    Tipo1 = Tipo2 ->
	    (
		anal_sem(Exp, STexp),
		lookup_simples(ST, lista_stats, Lista),
		insert_lista(Lista, STassign)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na instrucao assign '),
		write(Id), write(' := '), write('exp...'), 
		write(' --> Tipos diferentes!'), nl,
		close(Stream)		
	    )
	);
	(
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na instrucao assign '),
	    write(Id), write(' := '), write('exp...'), 
	    write(' --> Tipos diferentes na expressao!'), nl,
	    close(Stream)		
	).
	    
		


anal_sem(assign(name(Id), Exp), ST):-
	lookup(ST, lista_ids, STids), (lookup(STids, n(Id), _)) -> 
	(    
	    anal_tipos(Exp, _,_) ->
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na instrucao assign '),
		write(Id), write(' := '), write('exp...'), 
		write(' --> Tipos diferentes ou identificadores inexistentes!') , nl,
		close(Stream)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na instrucao assign '),
		write(Id), write(' := '), write('exp...'), 
		write(' --> Tipos diferentes na expressao!'), nl,
		close(Stream)		
	    )
	);
	(    
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na instrucao assign '),
	    write(Id), write(' := '), write('exp...'), 
	    write(' --> Identificador '), write(Id), write(' nao definido!'), nl,
	    close(Stream)		
	).	


% Instrucao "chamada de funcao"
%------------------------------
anal_sem(func_call(name(Id), args(Args)), ST):-
	lookup(ST, lista_ids, STids), 
	lookup(STids, n(Id), STid) ->
	(
	    lookup_simples(STid, tipo, map) ->
	    (
		lookup_simples(STid, valor, STvalor),
		lookup_simples(STvalor, tipo, Tipo),
		lookup_simples(STvalor, args, ListaPar), 
		lookup_simples(STvalor, num_args, L),
		length(Args, L) ->
		(
		    insert(STfunc_call, pai, ST),
		    insert(STfunc_call, classe, statment(func_call)),
		    insert(STfunc_call, nome, Id),
		    insert(STfunc_call, lado_e, false),
		    insert(STfunc_call, const, false),
		    insert(STfunc_call, tipo, Tipo),
		    insert(STfunc_call, args, ListaArgs),
		    insert(STfunc_call, valor, STvalor),
		    anal_sem(args(Args), STfunc_call),
		    verifica_args(ListaArgs, ListaPar) ->
		    (
			lookup(ST, lista_stats, Lista),
			insert_lista(Lista, STfunc_call)
		    );
		    (
			open('erros.pl',append, Stream),
			set_output(Stream),
			write('Erro na chamada da funcao '),
			write(Id), 
			write(' --> Argumentos incorrectos!'), nl,
			close(Stream)
		    ) 
		);
		(
		    open('erros.pl',append, Stream),
		    set_output(Stream),
		    write('Erro na chamada da funcao '),
		    write(Id), 
		    write(' --> Numero de argumentos incorrecto!'), nl,
		    close(Stream)
		)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na chamada da funcao '),
		write(Id), 
		write(' --> Identificador nao e uma funcao!'), nl,
		close(Stream)
	    )
	);
	(
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na chamada da funcao '),
	    write(Id), 
	    write(' --> Funcao inexistente!'), nl,
	    close(Stream)
	).


anal_sem(args([]), _).

anal_sem(args([X|Xs]), ST):-
	X = name(Id),
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(args([X|Xs]), ST).

anal_sem(args([X|Xs]), ST):-
	X \= name(_),
	insert(STArg, pai, ST), 
	anal_sem(X, STArg),
	lookup(ST, args, ListaArgs),
	insert_lista(ListaArgs, STArg),
	anal_sem(args(Xs), ST).

anal_sem(args([X|Xs]), ST):-
	X = name(Id),
	lookup(ST, args, STArgs),
	lookup_lista(STArgs, Id, STArg),
	lookup(ST, args, ListaArgs),
	insert_lista(ListaArgs, STArg),
	anal_sem(args(Xs), ST).

anal_sem(args([X|Xs]), ST):-
	X = name(Id),
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STArg),
	lookup(ST, args, ListaArgs),
	insert_lista(ListaArgs, STArg),
	anal_sem(args(Xs), ST).


% Instrucao "chamada de funcao recursiva"
%----------------------------------------
anal_sem(r_func_call(args(Args)), ST):-
	encontra_funcao(ST, STfunc),
	lookup_simples(STfunc, num_args, L),
	length(Args, L) ->
	(
	    lookup_simples(STfunc, tipo, Tipo),
	    lookup_simples(STfunc, args, ListaPar),
	    lookup_simples(STfunc, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    insert(STr_func_call, pai, ST),
	    insert(STr_func_call, classe, statment(r_func_call)),
	    insert(STr_func_call, nome, Nome),	    
	    insert(STr_func_call, lado_e, false),
	    insert(STr_func_call, const, false),
	    insert(STr_func_call, tipo, Tipo),
	    insert(STr_func_call, args, ListaArgs),
	    insert(STr_func_call, valor, STfunc),
	    anal_sem(args(Args), STr_func_call),
	    verifica_args(ListaArgs, ListaPar) ->
	    (
		lookup_simples(ST, lista_stats, Lista),
		insert_lista(Lista, STr_func_call)
	    );
	    (
		lookup(ST, valor, ST1),
		lookup_simples(ST1, pai, STpai),
		lookup_simples(STpai, nome, Nome),
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na chamada recursiva da funcao '),
		write(Nome), 
		write(' --> Argumentos incorrectos!'), nl,
		close(Stream)
	    )
	);
	(
	    lookup(ST, valor, ST1),
	    lookup_simples(ST1, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na chamada recursiva da funcao '),
	    write(Nome), 
	    write(' --> Numero de argumentos incorrecto!'), nl,
	    close(Stream)
	).
	

	
% Instrucao "return"
%-------------------
anal_sem(return(Exp), ST):-
	Exp = name(Id),
	nao_existe(name(Id), ST),
	lookup(ST, lista_ids, STids),
	insert(STvar, pai, STids),
	insert(STvar, nome, Id),
	insert(STvar, classe, decl(var_def)),
	insert(STvar, const, false),
	insert(STvar, lado_e, false),
	insert(STvar, tipo, _),
	insert(STvalor, pai, STvar),
	insert(STvar, valor, STvalor),
	insert(STids, n(Id), STvar),	
	anal_sem(return(Exp), ST).

anal_sem(return(Exp), ST):-
	lookup(ST, valor, STfunc),
	lookup_simples(STfunc, tipo, Tipo1),
	anal_tipos(Exp, Tipo1, ST) ->
	(
	    Tipo1 = Tipo1 ->
	    (
		insert(STreturn, pai, ST),
		insert(STreturn, classe, statment(return)),
		insert(STreturn, lado_e, false),
		insert(STreturn, const, false),
		insert(STreturn, tipo, void),
		insert(STreturn, valor, STValor),
		(Exp \= name(Id) -> 
		    (
			insert(STValor, pai, STreturn),			    
			anal_sem(Exp, STValor) ->
			(
			    lookup_simples(ST, lista_stats, Lista),
			    insert_lista(Lista, STreturn)
			);
			(
			    open('erros.pl',append, Stream),
			    set_output(Stream),
			    write('Erro na instrucao return'),
			    write(' --> Expressao incorrecta!'), nl,
			    close(Stream)
			)
		    );
		    (
			Exp = name(Id),
			(
			    (lookup(ST, lista_ids, STids),
			    lookup(STids, n(Id), STValor));
			    (lookup(ST, args, ListaArgs),
			    lookup_lista(ListaArgs, Id, STValor))
			) -> 
			(
			    lookup_simples(STValor, tipo, Tipo1) ->
			    (
				lookup_simples(ST, lista_stats, Lista),
				insert_lista(Lista, STreturn)
			    );
			    (
				open('erros.pl',append, Stream),
				set_output(Stream),
				write('Erro na instrucao return'),
				write(' --> Tipo incorrecto!'), nl,
				close(Stream)
			    )
			);
			(
			    open('erros.pl',append, Stream),
			    set_output(Stream),
			    write('Erro na instrucao return'),
			    write(' --> Identificador inexistente!'), nl,
			    close(Stream)
			)
		    )
		);
		(
		    open('erros.pl',append, Stream),
		    set_output(Stream),
		    write('Erro na instrucao return'),
		    write(' --> Tipo incorrecto!'), nl,
		    close(Stream)
		)
	    );
	    (
		open('erros.pl',append, Stream),
		set_output(Stream),
		write('Erro na instrucao return'),
		write(' --> Erro de tipos na expressao!'), nl,
		close(Stream)
	    )
	).
	    

% Instrucao "while"
%------------------------
anal_sem(while(Clauses), ST):-
	insert(STwhile, pai, ST),
	insert(STwhile, classe, statment(while)),
	insert(STwhile, const, false),
	insert(STwhile, lado_e, false),
	insert(STwhile, tipo, void),
	insert(STwhile, clauses, _),
	anal_sem(Clauses, STwhile) ->
	(
	    lookup_simples(ST, lista_stats, Lista),
	    insert_lista(Lista, STwhile)
	).


% Instrucao "condicional"
%------------------------
anal_sem(cond(Clauses), ST):-
	insert(STcond, pai, ST),
	insert(STcond, classe, statment(cond)),
	insert(STcond, const, false),
	insert(STcond, lado_e, false),
	insert(STcond, tipo, void),
	insert(STcond, clauses, _),
	anal_sem(Clauses, STcond) ->
	(
	    lookup_simples(ST, lista_stats, Lista),
	    insert_lista(Lista, STcond)
	).
	
anal_sem(clauses(name(Id), stats(Stats)), ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, bool),
	insert(STclause, pai, ST),
	insert(STclause, classe, clause),
	insert(STclause, const, false),
	insert(STclause, lado_e, false),
	insert(STclause, tipo, void),
	insert(STclause, condicao, STid),
	insert(STclause, lista_stats, _),
	anal_sem(stats(Stats), STclause),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause). 

anal_sem(clauses(name(Id), stats(Stats)), ST):-
	lookup(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, STarg),
	lookup_simples(STarg, tipo, bool),
	insert(STclause, pai, ST),
	insert(STclause, classe, clause),
	insert(STclause, const, false),
	insert(STclause, lado_e, false),
	insert(STclause, tipo, void),
	insert(STclause, condicao, STarg),
	insert(STclause, lista_stats, _),
	anal_sem(stats(Stats), STclause),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause). 
	

anal_sem(clauses(Exp, stats(Stats)), ST):-
	insert(STexp, pai, ST),
	anal_sem(Exp, STexp),
	lookup_simples(STexp, tipo, bool) ->
	(
	    insert(STclause, pai, ST),
	    insert(STclause, classe, clause),
	    insert(STclause, const, false),
	    insert(STclause, lado_e, false),
	    insert(STclause, tipo, void),
	    insert(STclause, condicao, STexp),
	    insert(STclause, lista_stats, _),
	    anal_sem(stats(Stats), STclause),
	    lookup(ST, clauses, ListaClauses),
	    insert_lista(ListaClauses, STclause) 
	);
	(
	    lookup(ST, valor, ST1),
	    lookup_simples(ST1, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na funcao '),
	    write(Nome), 
	    write(' --> Erro na expressao condicional!'), nl,
	    close(Stream)
	).

anal_sem(clauses(name(Id), stats(Stats1), stats(Stats2)), ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, bool),
	insert(STclause, pai, ST),
	insert(STclause, classe, clause),
	insert(STclause, const, false),
	insert(STclause, lado_e, false),
	insert(STclause, tipo, void),
	insert(STclause, condicao, STid),
	insert(STclause, lista_stats, _),
	anal_sem(stats(Stats1), STclause),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause),
	insert(STclause2, pai, ST),
	insert(STclause2, classe, clause_else),
	insert(STclause2, const, false),
	insert(STclause2, lado_e, false),
	insert(STclause2, tipo, void),
	insert(STclause2, lista_stats, _),
	anal_sem(stats(Stats2), STclause2),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause2).

anal_sem(clauses(name(Id), stats(Stats1), stats(Stats2)), ST):-
	lookup(ST, args, ListaArgs),
	lookup(ListaArgs, Id, STarg),
	lookup_simples(STarg, tipo, bool),
	insert(STclause, pai, ST),
	insert(STclause, classe, clause),
	insert(STclause, const, false),
	insert(STclause, lado_e, false),
	insert(STclause, tipo, void),
	insert(STclause, condicao, STarg),
	insert(STclause, lista_stats, _),
	anal_sem(stats(Stats1), STclause),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause),
	insert(STclause2, pai, ST),
	insert(STclause2, classe, clause_else),
	insert(STclause2, const, false),
	insert(STclause2, lado_e, false),
	insert(STclause2, tipo, void),
	insert(STclause2, lista_stats, _),
	anal_sem(stats(Stats2), STclause2),
	lookup(ST, clauses, ListaClauses),
	insert_lista(ListaClauses, STclause2).

anal_sem(clauses(Exp, stats(Stats1), stats(Stats2)), ST):-
	insert(STexp, pai, ST),
	anal_sem(Exp, STexp),
	lookup_simples(STexp, tipo, bool) ->
	(
	    insert(STclause1, pai, ST),
	    insert(STclause1, classe, clause),
	    insert(STclause1, const, false),
	    insert(STclause1, lado_e, false),
	    insert(STclause1, tipo, void),
	    insert(STclause1, condicao, STexp),
	    insert(STclause1, lista_stats, _),
	    anal_sem(stats(Stats1), STclause1),
	    lookup(ST, clauses, ListaClauses),
	    insert_lista(ListaClauses, STclause1),
	    insert(STclause2, pai, ST),
	    insert(STclause2, classe, clause_else),
	    insert(STclause2, const, false),
	    insert(STclause2, lado_e, false),
	    insert(STclause2, tipo, void),
	    insert(STclause2, lista_stats, _),
	    anal_sem(stats(Stats2), STclause2),
	    lookup(ST, clauses, ListaClauses),
	    insert_lista(ListaClauses, STclause2)
	);
	(
	    lookup(ST, valor, ST1),
	    lookup_simples(ST1, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na funcao '),
	    write(Nome), 
	    write(' --> Erro na expressao condicional!'), nl,
	    close(Stream)
	).

anal_sem(clauses(Exp, stats(Stats), Clauses), ST):-
	insert(STexp, pai, ST),
	anal_sem(Exp, STexp) ->
	(
	    insert(STclause, pai, ST),
	    insert(STclause, classe, clause),
	    insert(STclause, const, false),
	    insert(STclause, lado_e, false),
	    insert(STclause, tipo, void),
	    insert(STclause, condicao, STexp),
	    insert(STclause, lista_stats, _),
	    anal_sem(stats(Stats), STclause),
	    lookup(ST, clauses, ListaClauses),
	    insert_lista(ListaClauses, STclause),
	    anal_sem(Clauses, ST)
	);
	(
	    lookup(ST, valor, ST1),
	    lookup_simples(ST1, pai, STpai),
	    lookup_simples(STpai, nome, Nome),
	    open('erros.pl',append, Stream),
	    set_output(Stream),
	    write('Erro na funcao '),
	    write(Nome), 
	    write(' --> Erro na expressao condicional!'), nl,
	    close(Stream),
	    anal_sem(Clauses, ST)
	).


% Instrucao "block"
%------------------------
anal_sem(block(Bloco), ST):-
	insert(STblock, pai, ST),
	insert(STblock, classe, statment(block)),
	insert(STblock, const, false),
	insert(STblock, tipo, void),
	insert(STblock, lado_e, false),
	insert(STlista_ids, pai, STblock),
	insert(STblock, lista_ids, STlista_ids),
	insert(STblock, lista_stats, _),
	anal_sem(stats(Bloco), STblock),
	lookup_simples(ST, lista_stats, Lista),
	insert_lista(Lista, STblock).


% Instrucao "break"
%------------------------
anal_sem(break, ST):-
	insert(STbreak, pai, ST),
	insert(STbreak, classe, statment(break)),
	insert(STbreak, const, false),
	insert(STbreak, lado_e, false),
	insert(STbreak, tipo, void),
	lookup_simples(ST, lista_stats, Lista),
	insert_lista(Lista, STbreak).



anal_sem(par(X), ST):-
	anal_sem(par(X), ST, 0).

	

% declaracoes de parametros com tipo implicito
%---------------------------------------------

anal_sem(par([]), ST, Num):- 
	insert(ST, num_args, Num).

anal_sem(par([X|Xs]), ST, Num):-
	X = imp_type([]),
	anal_sem(par(Xs), ST, Num).

anal_sem(par([X|Xs]), ST, Num):- 
	X = imp_type([name(Id)|Ids]),
	lookup_simples(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, _),
	open('erros.pl', append, Stream),
	set_output(Stream),
	write('Erro na declaracao do parametro '),
	write(Id),  
	write(' --> Parametro ja declarado!') , nl,
	close(Stream),
	anal_sem(par([imp_type(Ids)|Xs]), ST, Num).

anal_sem(par([X|Xs]), ST, Num):-
	X = imp_type([name(Id)|Ids]),
	anal_tipos(name(Id), Tipo, _),
	insert(STPar, pai, ST), 
	insert(STPar, nome, Id),
	insert(STPar, classe, formals),
	insert(STPar, const, false),
	insert(STPar, lado_e, false),
	insert(STPar, tipo, Tipo),
	insert(STPar, valor, _),
	lookup_simples(ST, args, ListaArgs),
	insert_lista(ListaArgs, STPar),
	Num1 is Num + 1,
	anal_sem(par([imp_type(Ids)|Xs]), ST, Num1).

% declaracoes de parametros com tipo explicito
%---------------------------------------------
anal_sem(par([X|Xs]), ST, Num):-
	X = exp_type([], _),
	anal_sem(par(Xs), ST, Num).

anal_sem(par([X|Xs]), ST, Num):- 
	X = exp_type([name(Id)|Ids], Tipo),
	lookup_simples(ST, args, ListaArgs),
	lookup_lista(ListaArgs, Id, _),
	open('erros.pl', append, Stream),
	set_output(Stream),
	write('Erro na declaracao do parametro '),
	write(Id),  write(' : '), write(Tipo), 
	write(' --> Parametro ja declarado!') , nl,
	close(Stream),
	anal_sem(par([exp_type(Ids, Tipo)|Xs]), ST, Num).

anal_sem(par([X|Xs]), ST, Num):-
	X = exp_type([name(Id)|Ids], Tipo),
	anal_tipos(name(Id), Tipo1,_),
	anal_tipos(Tipo, Tipo2,_),
	Tipo1 = Tipo2,
	insert(STPar, pai, ST), 
	insert(STPar, nome, Id),
	insert(STPar, classe, formals),
	insert(STPar, const, false),
	insert(STPar, lado_e, false),
	insert(STPar, tipo, Tipo1),
	insert(STPar, valor, _),
	lookup_simples(ST, args, ListaArgs),
	insert_lista(ListaArgs, STPar),
	Num1 is Num + 1,
	anal_sem(par([exp_type(Ids, Tipo)|Xs]), ST, Num1).



%-------------------------------------------------------%
%     ANALISE DE TIPOS  (verificacao de tipos)          %
%-------------------------------------------------------%

% declaracoes de tipos, variaveis e constantes
%---------------------------------------------
anal_tipos(type_def(_,_), void,_).
anal_tipos(var_def(_,_), void,_).
anal_tipos(var_def(_,_,_), void,_).
anal_tipos(cnst_def(_,_,_), void,_).
anal_tipos(cnst_def(_,_), void,_).


% declaracoes de tipos
%---------------------
anal_tipos(type(void), void,_).
anal_tipos(type(int), int,_).
anal_tipos(type(real), real,_).
anal_tipos(type(bool), bool,_).
anal_tipos(type(class, _), class, _).
anal_tipos(type(array, _, T), array(Tipo), _):- anal_tipos(T, Tipo, _).

% operadores booleanos
%---------------------
anal_tipos(op(or, X1, X2), bool, ST):- anal_tipos(X1, bool, ST), anal_tipos(X2, bool, ST).
anal_tipos(op(and, X1, X2), bool, ST):- anal_tipos(X1, bool, ST), anal_tipos(X2, bool, ST).
anal_tipos(op(not, X1), bool, ST) :- anal_tipos(X1, bool, ST).

% operadores de comparacao
%-------------------------
anal_tipos(op(menor, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(op(menor_i, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(op(igual, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(op(dif, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(op(maior_i, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(op(maior, X1, X2), bool, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).

% operadores aritmeticos
%-----------------------
anal_tipos(op(soma, X1, X2), T, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST), (T = int ; T = real). 
anal_tipos(op(sub, X1, X2), T, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST), (T = int ; T = real).
anal_tipos(op(mult, X1, X2), T, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST), (T = int ; T = real).
anal_tipos(op(div, X1, X2), T, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST), (T = int ; T = real).
anal_tipos(op(mod, X1, X2), T, ST):- anal_tipos(X1, T,ST), anal_tipos(X2, T, ST), (T = int ; T = real).
anal_tipos(op(menos, X1, X2), T, ST):- anal_tipos(X1, T, ST), anal_tipos(X2, T, ST), (T = int ; T = real).
anal_tipos(op(menos, X), T, ST):- anal_tipos(X, T, ST), (T = int ; T = real).

% literais
%---------	
anal_tipos(name(Id), Tipo, ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, tipo, Tipo).
anal_tipos(name(Id), Tipo, ST):-
	lookup(ST, args, ListaArgs),
	lookup(ListaArgs, Id, STid),
	lookup_simples(STid, tipo, Tipo).
anal_tipos(name(_), _, _).

 
anal_tipos(lit(int,_), int, _).
anal_tipos(lit(real,_), real, _).
anal_tipos(lit(bool,_), bool, _).

anal_tipos(lit(array, Valores), array(Tipo), _):-
	anal_tipos(lista_val(Valores), Tipo, _).
anal_tipos(lista_val([]), _, _).
anal_tipos(lista_val([X|Xs]), Tipo, _):-
	anal_tipos(X, Tipo, _),
	anal_tipos(lista_val(Xs), Tipo, _).

% literal de funcao
anal_tipos(lit(map, _, _), map, _).
anal_tipos(lit(map, _, _, _), map, _).

% instrucoes
%-----------
anal_tipos(assign(X1, X2), void, ST):- !, anal_tipos(X1, T, ST), anal_tipos(X2, T, ST).
anal_tipos(func_ref(name(Id), _), Tipo, ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid), 
	lookup_simples(STid, valor, STvalor),
	lookup_simples(STvalor, tipo, Tipo).

anal_tipos(r_func_ref( _), Tipo, ST):-
	lookup(ST, valor, STfunc),
	lookup_simples(STfunc, tipo, Tipo).

anal_tipos(array_ref(name(Id), _), Tipo, ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), STid),
	lookup_simples(STid, valor, STvalor),
	lookup_simples(STvalor, tipo, array(Tipo)).	


%-------------------------------------------------------%
%     Predicados auxiliares                             %
%-------------------------------------------------------%

% predicado portray
%-----------------------------------------
e_simbol_table([_=_|_]).

% predicado de insercao numa lista
%-----------------------------------------
insert_lista(Lista, V):- var(Lista), !, Lista = [V| _ ].
insert_lista([_|Lista], V):- insert_lista(Lista, V).

% predicado de insercao numa simbol table (insert)
%-----------------------------------------
insert(ST, K, V):- var(ST), !, ST = [K=V| _ ].
insert([K=_| _ ], K, _):- !, fail.
insert([_|ST], K, V):- insert(ST, K, V).

% predicado de pesquisa numa simbol table (lookup)
%-----------------------------------------
lookup(ST, K, V):- lookup(ST, K, V, ST).
lookup(ST, K, V, STO):- var(ST), !, lookup_simples(STO, pai, STP),  lookup(STP, K, V, STP).
lookup([K=V| _ ], K, V, _).
lookup([_|ST], K, V, STO):- lookup(ST, K, V, STO).

% predicado de pesquisa numa lista de simbol table 
%-----------------------------------------
lookup_lista(Lista, _, _):- var(Lista), !, fail.
lookup_lista([X|_], V, X):- lookup_simples(X, nome, V).
lookup_lista([_|Xs], V, ST):- lookup_lista(Xs, V, ST), !.

% predicado de pesquisa simples (apenas num nivel) numa simbol table 
%-----------------------------------------
lookup_simples(ST, _, _):- var(ST), !, fail.
lookup_simples([K=V| _], K, V).
lookup_simples([_|ST], K, V):- lookup_simples(ST, K, V).


% predicados que imprimem o conteudo de uma simbol table    
%--------------------------------------------------------
print_lista(K, []):- write(K), write(=), write('Nao existe(m)!'), nl.
print_lista(K, V):- write(K), write(=), nl, print_lista_aux(V). 
print_lista_aux([]).
print_lista_aux([X|Xs]):- e_simbol_table(X), print_st(X), print_lista_aux(Xs).

print_aux2(K, _):- var(K).
print_aux2(K, V):- var(V), write(K), write(=), write('Nao instanciado!'), nl.
print_aux2(K, V):- 
	nonvar(K), nonvar(V), e_simbol_table(V), nl, 
	write(K), write(=),  print_st(V).
print_aux2(K, V):- write(K=V), nl.

print_aux(X):-var(X).
print_aux([K=_|Xs]):- K==pai, print_aux2(K, 'simbol table correspondente!'), print_aux(Xs).
print_aux([K=V|Xs]):- (K==lista_stats; K==args; K == clauses; K == valores), print_lista(K,V), 
	print_aux(Xs). 
print_aux([K=V|Xs]):- K\==pai, K \==lista_aux, K \== args, print_aux2(K, V), print_aux(Xs).

print_rec(X):-var(X).
print_rec([K=V|Xs]):- (K == lista_stats; K == args; K == valores), print_lista(K, V), print_rec(Xs).
print_rec([K=_|Xs]):- (K == valor; K == pai), print_aux2(K, 'simbol table correspondente'), print_rec(Xs).
print_rec([K=V|Xs]):- K \== valor, K \== pai, print_aux2(K, V), print_rec(Xs).

print_st(ST):- 
	lookup(ST, classe, Classe),
	(Classe = statment(r_func_call); Classe = statment(func_call);
	    Classe = op(r_func_ref); Classe = op(r_func_ref); Classe = op(array_ref)),
    
	nl, 
	write(-------------------------------------------- ), nl, 
	print_rec(ST),
	write(-------------------------------------------- ), nl.


print_st(ST):- 
	nl,
	write(-------------------------------------------- ), nl, 
	print_aux(ST),
	write(-------------------------------------------- ),nl.

print_main(ST):-  
	open('st.pl',write, Stream),
	set_output(Stream),
	print_st(ST), !, 
	close(Stream).


% predicado que imprime o codigo sim para um ficheiro sim.sm    
%-----------------------------------------------------------
print_sim(Cod):-
	open('sim.sm',write, Stream),
	set_output(Stream),
	print_sim_aux(Cod), !, 
	close(Stream).	

print_sim_aux([]).

print_sim_aux([l(X)|Xs]):-
	write(X), write(':'), nl,
	print_sim_aux(Xs).

print_sim_aux(['.TEXT'|Xs]):-
	nl, write('.TEXT'), nl,
	print_sim_aux(Xs).

print_sim_aux(['.DATA'|Xs]):-
	nl, write('.DATA'), nl,
	print_sim_aux(Xs).

print_sim_aux([global(Id, Tipo, Valor)|Xs]):-
	write(Id), write(':'),
	write('\t'), write(Tipo),
	write('\t'), write(Valor), nl, 
	print_sim_aux(Xs).


print_sim_aux([push(N)|Xs]):-
	write('\t'), write('PUSH '), write(N), nl,
	print_sim_aux(Xs).

print_sim_aux([X|Xs]):-
	write('\t'), write(X), nl,
	print_sim_aux(Xs).

% predicado que verifica a validade dos argumentos de uma chamada de funcao
%--------------------------------------------------------------------------
verifica_args([],[]).
verifica_args([A|As], [P|Ps]):-
	lookup_simples(A, tipo, Tipo),
	lookup_simples(P, tipo, Tipo),
	verifica_args(As,Ps).		


% predicado que verifica se um determinado id nao existe
%----------------------------------------------------------
nao_existe(name(Id), ST):-
	lookup(ST, lista_ids, STids),
	lookup(STids, n(Id), _) -> 
	(
	    !, 
	    fail
	); 
	(
	    lookup(ST, args, ListaArgs),
	    lookup_lista(ListaArgs, Id, _) -> 
	    (
		!, 
		fail
	    ); 
	    true
	).

% predicados que inserem as funcoes predefinidas na ST
%----------------------------------------------------------
insere_pred(ST):-
	insert(ST, pai, void),	
	insert(ST, nome, main),
	insert(ST, classe, program),
	insert(ST, tipo, void),
	insert(STlista_ids, pai, ST),
	insert(ST, lista_ids,STlista_ids),
	insert(ST, lista_stats, _),
	insere_print_char(STlista_ids),
	insere_print_int(STlista_ids),
	insere_read_bool(STlista_ids),
	insere_read_int(STlista_ids),
	insere_read_char(STlista_ids),
	insere_write_char(STlista_ids),
	insere_write_int(STlista_ids),
	insere_halt(STlista_ids),
	insere_dump_regs(STlista_ids),
	insere_dump_stack(STlista_ids),
	insere_stack_trace(STlista_ids).

insere_print_char(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, print_char),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([imp_type([name(i)])]), STvalor),
	insert(ST, n(print_char), STcnst).

insere_print_int(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, print_int),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([imp_type([name(i)])]), STvalor),
	insert(ST, n(print_int), STcnst).

insere_read_bool(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, read_bool),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, bool),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(read_bool), STcnst).

insere_read_int(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, read_int),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, int),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(read_int), STcnst).

insere_read_char(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, read_char),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, int),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(read_char), STcnst).

insere_write_char(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, write_char),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([imp_type([name(i)])]), STvalor),
	insert(ST, n(write_char), STcnst).

insere_write_int(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, write_int),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([imp_type([name(i)])]), STvalor),
	insert(ST, n(write_int), STcnst).

insere_halt(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, halt),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(halt), STcnst).

insere_dump_regs(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, dump_regs),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(dump_regs), STcnst).

insere_dump_stack(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, dump_stack),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(dump_stack), STcnst).

insere_stack_trace(ST):-
	insert(STcnst, pai, ST),
	insert(STcnst, nome, stack_trace),
	insert(STcnst, classe, decl(cnst_def)),
	insert(STcnst, const, true),
	insert(STcnst, lado_e, false),
	insert(STcnst, tipo, map),
	insert(STcnst, valor, STvalor),
	insert(STvalor, pai, STcnst),
	insert(STvalor, classe, lit(map)),
	insert(STvalor, const, true),
	insert(STvalor, tipo, void),
	insert(STvalor, lado_e, false),
	insert(STvalor, args, _),
	insert(STvalor, lista_ids, ListaIds),
	insert(ListaIds, pai, STvalor),
	insert(STvalor, lista_stats, _),
	anal_sem(par([]), STvalor),
	insert(ST, n(stack_trace), STcnst).

% predicado que insere na lista de stats as inicializacoes das variaveis
%-----------------------------------------------------------------------
ver_inicial(ST):-
	lookup_simples(ST, lista_ids, STids),
	ver_inicial_aux(STids).

ver_inicial_aux(X):- var(X).
ver_inicial_aux([n(Id)=ST|Xs]):-
	lookup_simples(ST, classe, decl(var_def)),
	lookup_simples(ST, valor, Valor),
	nonvar(Valor),
	lookup_simples(ST, pai, STpai),
	lookup_simples(STpai, pai, STavo),	
	anal_sem(assign(name(Id), Valor), STavo),
	ver_inicial_aux(Xs).

ver_inicial_aux([_=_|Xs]):-
	ver_inicial_aux(Xs).

% predicado que transforma uma ST de ST's numa lista de ST's
%-----------------------------------------------------------
transf_lista(ST, Lista):- transf_lista(ST, [], [], Lista).
transf_lista(ST, ListaAux, ListaAux2, Lista):-
	lookup_simples(ST, K, V), 
	K \= pai, nonvar(K), nonvar(V),
	K \= n(program),
	not_member(K, ListaAux),
	transf_lista(ST, [K|ListaAux], [V|ListaAux2], Lista).
transf_lista(_,_,Lista, Lista). 


% predicado que devolve a funcao em que uma expressao esta inserida
%------------------------------------------------------------------
encontra_funcao(ST, STfunc):-
	lookup_simples(ST, classe, lit(map)) ->
	(
	    lookup_simples(ST, pai, STPai),
	    lookup_simples(STPai, valor, STfunc)
	);
	(
	    lookup_simples(ST, pai, STPai),
	    encontra_funcao(STPai, STfunc)
	).


not_member(El, Lista):-
	member(El, Lista) -> fail ; true.


% predicado que calcula o numero de variaveis numa funcao
%--------------------------------------------------------
num_vars(ST, N) :- 
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(ST, lista_stats, ListaStats),
	num_vars(STids, 0, Naux),
	num_vars(ListaStats, Naux, N).

num_vars(ST, S, S):- var(ST).
num_vars([], S, S).
num_vars([_=V| Xs], Naux, N):-  
	lookup_simples(V, classe, decl(var_def)),
	N1 is Naux + 1,
	num_vars(Xs, N1, N).

num_vars([_=V| Xs], Naux, N):-  
	lookup_simples(V, classe, decl(cnst_def)),
	lookup_simples(V, tipo, Tipo),
	(Tipo = int ; Tipo = real ; Tipo = bool),
	N1 is Naux + 1,
	num_vars(Xs, N1, N).

num_vars([_=_| Xs], Naux, N):-  
	num_vars(Xs, Naux, N).

num_vars([ST|Xs], Naux, N):-
	lookup_simples(ST, classe, statment(block)),
	lookup_simples(ST, lista_ids, STids),
	lookup_simples(ST, lista_stats, ListaStats),
	num_vars(STids, Naux, Naux2),
	num_vars(ListaStats, Naux2, Naux3),
	num_vars(Xs, Naux3, N).
num_vars([_|Xs], Naux, N):-
	num_vars(Xs, Naux, N).

% predicados que devolvem o espaco necessario para os varios tipos
%-----------------------------------------------------------------
espaco(int, 1).
espaco(bool, 1).
espaco(real, 1).
espaco(void, 0).

% predicado que devolve o ultimo argumento da lista de argumentos
%-----------------------------------------------------------------
ultimo_arg(X, ST):- var(X), insert(ST, offset, 0).
ultimo_arg([X|Xs], X):- Xs = [].
ultimo_arg([_|Xs], Y):- ultimo_arg(Xs, Y).

%-------------------------------------------------------%
%     Predicados que inserem o offset na ST             %
%-------------------------------------------------------%
insert_globais(Xs):- var(Xs).
insert_globais([_=ST|Xs]):-
	insert(ST, global, true),
	insert_globais(Xs).

insert_offset(ST):- 
	lookup(ST, lista_ids, STids),
	insert_globais(STids),
	insert_offset(STids, -2, _).

insert_offset(X, Offset, Offset):- var(X).
insert_offset([], Offset, FimOffset):- 
	FimOffset is Offset - 1.
insert_offset([_=ST|Xs], Offset, FimOffset):- 
	var(ST), 
	insert_offset(Xs, Offset, FimOffset).

insert_offset([X=_|Xs], Offset, FimOffset):-
	(X = pai ; X = n(print_int) ; X = n(print_char) ; X = n(read_bool) ; X = n(read_int) ; 
	 X = n(read_char) ; X = n(write_int) ; X = n(write_char) ; X = n(halt) ; X = n(dump_regs) ; 
	 X = n(dump_stack) ; X = n(stack_trace)),
	insert_offset(Xs, Offset, FimOffset).

insert_offset([_=ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, decl(var_def)),
	lookup(ST, tipo, Tipo),
	espaco(Tipo, Tamanho),
	insert(ST, offset, Offset),
	Offset2 is Offset - Tamanho,
	insert_offset(Xs, Offset2, FimOffset).

insert_offset([_=ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, decl(cnst_def)),
	lookup_simples(ST, tipo, Tipo),
	Tipo \= map,
	espaco(Tipo, Tamanho),
	insert(ST, offset, Offset),
	Offset2 is Offset - Tamanho,
	insert_offset(Xs, Offset2, FimOffset).

insert_offset([ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, formals),
	lookup(ST, tipo, Tipo),
	espaco(Tipo, Tamanho),
	insert(ST, offset, Offset),
	Offset2 is Offset + Tamanho,
	insert_offset(Xs, Offset2, FimOffset).
	
insert_offset([_=ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, tipo, map),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, lista_ids, STids),
	lookup_simples(STvalor, args, ListaArgs),
	lookup_simples(STvalor, lista_stats, ListaStats),
	insert_offset(STids, -2, FimOffset2), 
	insert_offset(ListaArgs, 1, O), 
	insert_offset(ListaStats, FimOffset2, _),
	lookup_simples(STvalor, tipo, Tipo),
	espaco(Tipo, Espaco),
	Retorno is O + Espaco, 
	insert(STvalor, retorno, Retorno),
	insert_offset(Xs, Offset, FimOffset).

insert_offset([ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, statment(block)),
	lookup_simples(ST, lista_stats, ListaStats),
	lookup_simples(ST, lista_ids, STids),
	insert_offset(STids, Offset, FimOffset2),
	insert_offset(ListaStats, FimOffset2, FimOffset3),
	insert_offset(Xs, FimOffset3, FimOffset).

insert_offset([_=ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, Classe),
	Classe \= decl(_),
	Classe \= formals,
	Classe \= program, 
	insert_offset(Xs, Offset, FimOffset).	

insert_offset([ST|Xs], Offset, FimOffset):-
	lookup_simples(ST, classe, Classe),
	Classe \= decl(_),
	Classe \= formals,
	Classe \= program, 
	insert_offset(Xs, Offset, FimOffset).	


% predicado que separa as constantes de funcao do outro tipo de ids
%-------------------------------------------------------
separa_cnst(ST, _, _):- var(ST).
separa_cnst([pai=_|Xs], C, R):- separa_cnst(Xs, C, R).
separa_cnst([K=ST|Xs], C, R):-
	lookup_simples(ST, classe, decl(cnst_def)),
	lookup_simples(ST, tipo, map),
	insert(C, K, ST),
	separa_cnst(Xs, C, R).

separa_cnst([K=ST|Xs], C, R):-
	lookup_simples(ST, tipo, Tipo),
	Tipo \= map,
	insert(R, K, ST),
	separa_cnst(Xs, C, R).



% criacao das labels para os statments condicionais e para
% os ciclos	
%-------------------------------------------------------%
label(Label):- !,
	g_read(c, L), 
	L1 is L + 1, 
	g_assign(c, L1), 
	number_atom(L, A),
	atom_concat('label_',A, Label).


%-------------------------------------------------------%
%       GERACAO DE CODIGO                               %
%-------------------------------------------------------%

%  predicado principal 
%---------------------------
gc(ST) --> 
	{lookup_simples(ST, classe, program), !, 
	lookup_simples(ST, lista_ids, STids), 
	lookup_simples(STids, n(program), STprogram)},
	['.DATA'],
	ids_globais(STids), 
	['.TEXT'],
	gc(n(program)=STprogram), 
	gc(STids). 


%  predicado para saltar as partes que nao interessam ou que ja foram executadas 
%  (funcoes predefinidas, funcao program, ids globais e definicoes de variaveis locais)
%-------------------------------------------------------------------------------
gc([]) --> !, [].
gc(Xs) --> {var(Xs)}, !, [].
gc([pai=_|Xs]) --> !, [], gc(Xs).

gc([n(X)=_|Xs]) -->
	{(X = print_int ; X = print_char ; X = read_bool ; X = read_int ; X = read_char ;
	X = write_int ; X = write_char ; X = halt ; X = dump_regs ; X = dump_stack ;
	X = stack_trace ; X = program)}, !, [], gc(Xs).

gc([n(_)=ST|Xs]) --> 
	{lookup_simples(ST, global, true),
	lookup_simples(ST, tipo, Tipo),
	(Tipo = int ; Tipo = bool ; Tipo = real)}, !, [], gc(Xs).

gc([n(_)=ST|Xs]) --> 
	{lookup_simples(ST, classe, decl(var_def))}, !,
	[], gc(Xs).


% funcao principal (program)
%---------------------------
gc(n(program)=ST) --> !, 
	{lookup_simples(ST, classe, decl(cnst_def)),
	lookup_simples(ST, tipo, map), 
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, lista_stats, ListaStats),
	lookup_simples(STvalor, lista_ids, STids),
 	num_vars(STvalor, N),
	separa_cnst(STids, C, R)},
	[l(program), push(N), 'LINK'],
	gc(R),
	gc(ListaStats),
	['UNLINK', 'JUMP'],
	gc(C).

% definicao de constante de funcao
%-----------------------
gc([n(Id)=ST|Xs]) -->  
	{lookup_simples(ST, classe, decl(cnst_def)), 
	lookup_simples(ST, tipo, map), !, 
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, lista_stats, ListaStats),
	lookup_simples(STvalor, lista_ids, STids),
 	num_vars(STvalor, N),
	separa_cnst(STids, C, R)},
	['.TEXT', l(Id), push(N), 'LINK'],
	gc(R),
	gc(ListaStats),
	['UNLINK', 'JUMP'],
	gc(C),
	gc(Xs).


% definicao de constante de tipo inteiro, real ou booleano
%-----------------------
gc([n(_)=ST|Xs]) -->  
	{lookup_simples(ST, classe, decl(cnst_def)), 
	lookup_simples(ST, tipo, Tipo), 
	(Tipo = int ; Tipo = real ; Tipo = bool), 
	lookup_simples(ST, valor, STvalor),
	nonvar(STvalor)}, !, 	
	gcv(STvalor),
	gce(ST),
	['STORE'],
	gc(Xs).


% instrucao de afectacao
%-----------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(assign)), !,
	lookup_simples(ST, lhs, Esquerdo),
	lookup_simples(ST, rhs, Direito)},
	gcv(Direito),
	gce(Esquerdo),
	['STORE'],
	gc(Xs).

% instrucao de chamada de funcao
%-------------------------------
gc([ST|Xs]) --> 
	{lookup_simples(ST, classe, statment(func_call)),  
	lookup_simples(ST, nome, Nome),
	(Nome \= write_int, Nome \= write_char, Nome \= read_bool), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(Nome), 'CALL', 'POP'],
	pop_args(N),
	gc(Xs).


% instrucao de chamada de funcao write_int
%-------------------------------
gc([ST|Xs]) --> 
	{lookup_simples(ST, classe, statment(func_call)),  
	lookup_simples(ST, nome, write_int), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(print_int), 'CALL', 'POP'],
	pop_args(N),
	gc(Xs).


% instrucao de chamada de funcao write_char
%-------------------------------
gc([ST|Xs]) --> 
	{lookup_simples(ST, classe, statment(func_call)),  
	lookup_simples(ST, nome, write_char), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(print_char), 'CALL', 'POP'],
	pop_args(N),
	gc(Xs).


% instrucao de chamada de funcao read_bool
%-------------------------------
gc([ST|Xs]) --> 
	{lookup_simples(ST, classe, statment(func_call)),  
	lookup_simples(ST, nome, read_bool), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(read_int), 'CALL', 'POP'],
	pop_args(N),
	gc(Xs).


% instrucao chamada de funcao recursiva
%-------------------------------
gc([ST|Xs]) --> 
	{lookup_simples(ST, classe, statment(r_func_call)), !,
	lookup_simples(ST, nome, Nome),
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},	
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(Nome), 'CALL', 'POP'],
	pop_args(N),
	gc(Xs).

% instrucao de retorno
%-------------------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(return)), !,
	encontra_funcao(ST, STfunc),
	lookup_simples(STfunc, retorno, Retorno),
	lookup_simples(ST, valor, Valor)},
	gcv(Valor),
	[push(Retorno), 'LOCAL', 'STORE'],
	gc(Xs).


% coloca os argumentos de uma chamada de funcao na pilha
%-------------------------------------------------------
gc(args([])) --> !, [].
gc(args([X|Xs])) --> !, [], gcv(X), gc(args(Xs)).


% instrucao while
%-------------------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(while)), !,
	lookup_simples(ST, clauses, [STClauses]),
	lookup_simples(STClauses, condicao, Cond),
	lookup_simples(STClauses, lista_stats, ListaStats),
	label(INICIO),
	label(Ci),
	label(FIM),
	asserta(while(FIM))},
	[l(INICIO)],
	[push(Ci)],
	gcv(Cond),
	['SKIPZ', 'JUMP', 'POP', push(FIM), 'JUMP'],
	[l(Ci)],
	gc(ListaStats),
	[push(INICIO), 'JUMP'],
	[l(FIM)],
	{retract(while(FIM))},
	gc(Xs).


% instrucao break
%-------------------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(break)), !, 
	while(FIM), !},
	[push(FIM), 'JUMP'],
	gc(Xs).

% instrucao block
%-------------------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(block)), !, 
	lookup_simples(ST,lista_stats, ListaStats),
	lookup_simples(ST, lista_ids, STids)},
	[],
	gc(STids),
	gc(ListaStats),
	gc(Xs).

% instrucao condicional
%-------------------------------
gc([ST|Xs]) -->
	{lookup_simples(ST, classe, statment(cond)), !, 
	lookup_simples(ST, clauses, Clauses),
	label(INICIO)},
	gc_cond(Clauses, INICIO), 
	[l(INICIO)],
	gc(Xs).


% clausulas da instrucao condicional
%--------------------------------
gc_cond([], _) --> !, [].
gc_cond([ST|Xs], FIM) --> 
	{lookup_simples(ST, classe, clause), !,
	lookup_simples(ST, condicao, Cond),
	lookup_simples(ST, lista_stats, ListaStats),
	label(Ci),
	label(FE)},
	[push(Ci)],
	gcv(Cond),
	['SKIPZ', 'JUMP', 'POP', push(FE), 'JUMP'],
	[l(Ci)],
	gc(ListaStats),
	[push(FIM), 'JUMP'],
	[l(FE)],
	gc_cond(Xs, FIM).
	
gc_cond([ST|_], _) -->
	{lookup_simples(ST, classe, clause_else), !,
	lookup_simples(ST, lista_stats, ListaStats)},	
	gc(ListaStats), [].

%-------------------------------------------------------%
%       GERACAO DE CODIGO PARA VALORES                  %
%-------------------------------------------------------%

% literais de inteiro, real e booleano
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, lit(int)), !,
	lookup_simples(ST, valor, Valor)},
	[push(Valor)].

gcv(ST) -->
	{lookup_simples(ST, classe, lit(real)), !,
	lookup_simples(ST, valor, Valor)},
	[push(Valor)].

gcv(ST) -->
	{lookup_simples(ST, classe, lit(bool)), 
	lookup_simples(ST, valor, true)}, !,
	[push(1)].

gcv(ST) -->
	{lookup_simples(ST, classe, lit(bool)), 
	lookup_simples(ST, valor, false)}, !,
	[push(0)].


% Operador soma (+)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(soma)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['ADD'].

% Operador subtraccao (-)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(sub)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['SUB'].

% Operador multiplicacao (*)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(mult)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['MUL'].

% Operador divisao (/)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(div)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['DIV'].

% Operador "mod" (%)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(mod)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['MOD'].

% Operador "menos" (-)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(menos)), !,
	lookup_simples(ST, termo, Termo)},	
	[push(0)],
	gcv(Termo),
	['SUB'].

% Operador "maior" (>)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(maior)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Direito), gcv(Esquerdo), 
	['SLT'].

% Operador "maior ou igual" (>=)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(maior_i)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['SLT', push(1), 'SWAP', 'SUB'].

% Operador "menor" (<)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(menor)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['SLT'].

% Operador "menor ou igual" (<=)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(menor_i)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Direito), gcv(Esquerdo),
	['SLT', push(1), 'SWAP', 'SUB'].

% Operador "igual" (=)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(igual)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito), 
	['SLT', push(1), 'SWAP', 'SUB'],
	gcv(Direito), gcv(Esquerdo), 
	['SLT', push(1), 'SWAP', 'SUB', 'MUL'].

% Operador "diferente" (!=)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(dif)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito), 
	['SLT', push(1), 'SWAP', 'SUB'],
	gcv(Direito), gcv(Esquerdo), 
	['SLT', push(1), 'SWAP', 'SUB', 'MUL'],
	[push(1), 'SWAP', 'SUB'].

% Operador "and" (&&)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(and)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['MUL'].

% Operador "or" (||)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(or)), !,
	lookup_simples(ST, termo_esq, Esquerdo),
	lookup_simples(ST, termo_dir, Direito)},
	gcv(Esquerdo), gcv(Direito),
	['ADD'].

% Operador "not" (~)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(not)), !,
	lookup_simples(ST, termo, Termo)},	
	gcv(Termo),
	[push(1), 'SWAP', 'SUB'].

% argumento de uma funcao (formal)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, formals), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL', 'LOAD'].


% constante global (tipo = int, bool ou real)
%-------------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, decl(cnst_def)), 
	lookup_simples(ST, global, true), !,
	lookup_simples(ST, nome, Id)}, 
	[push(Id), 'LOAD'].


% constante local (cnst_def)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, decl(cnst_def)), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL', 'LOAD'].


% variavel global
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, decl(var_def)), 
	lookup_simples(ST, global, true), !,
	lookup_simples(ST, nome, Id)}, 
	[push(Id), 'LOAD'].


% variavel local (var_def)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, decl(var_def)), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL', 'LOAD'].

% referencia a funcao (func_ref)
%-------------------------------------
gcv(ST) -->
	{lookup_simples(ST, classe, op(func_ref)), 
	lookup_simples(ST, nome, Nome),
	(Nome \= write_int, Nome \= write_char, Nome \= read_bool), !,
	lookup_simples(ST, args, ListaArgs), 
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(Nome), 'CALL'],
	pop_args(N).


% referencia a funcao write_int
%-------------------------------
gcv(ST) --> 
	{lookup_simples(ST, classe, op(func_ref)),  
	lookup_simples(ST, nome, write_int), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(print_int), 'CALL'],
	pop_args(N).

% referencia a funcao write_char
%-------------------------------
gcv(ST) --> 
	{lookup_simples(ST, classe, op(func_ref)),  
	lookup_simples(ST, nome, write_char), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(print_char), 'CALL'],
	pop_args(N).

% referencia a funcao read_bool
%-------------------------------
gcv(ST) --> 
	{lookup_simples(ST, classe, op(func_ref)),  
	lookup_simples(ST, nome, read_bool), !,
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(read_int), 'CALL'],
	pop_args(N).


% referencia a funcao recursiva (r_func_ref)
%-------------------------------------
gcv(ST) --> 
	{lookup_simples(ST, classe, op(r_func_ref)), !,
	lookup_simples(ST, nome, Nome),
	lookup_simples(ST, args, ListaArgs),
	reverse(ListaArgs, ListaArgsR),
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, num_args, N)},	
	['DUP'],
	gc(args(ListaArgsR)), 
	[push(Nome), 'CALL'],
	pop_args(N).



%-------------------------------------------------------%
%       GERACAO DE CODIGO PARA ENDERECOS                %
%-------------------------------------------------------%

% constante global (tipo = int, bool ou real)
%-------------------------------------------
gce(ST) -->
	{lookup_simples(ST, classe, decl(cnst_def)), 
	lookup_simples(ST, global, true), !,
	lookup_simples(ST, nome, Id)},
	[push(Id)].

% constante local (cnst_def)
%-------------------------------------
gce(ST) -->
	{lookup_simples(ST, classe, decl(cnst_def)), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL'].


% variavel global
%-------------------------------------
gce(ST) -->
	{lookup_simples(ST, classe, decl(var_def)), 
	lookup_simples(ST, global, true), !,
	lookup_simples(ST, nome, Id)},
	[push(Id)].

% variavel local (var_def)
%-------------------------------------
gce(ST) -->
	{lookup_simples(ST, classe, decl(var_def)), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL'].

% argumento de uma funcao (formal)
%-------------------------------------
gce(ST) -->
	{lookup_simples(ST, classe, formals), !,
	lookup_simples(ST, offset, Offset)},
	[push(Offset), 'LOCAL'].



%-------------------------------------------------------%
%       INSERE POPS PARA REMOVER ARGUMENTOS DA PILHA    %
%-------------------------------------------------------%
pop_args(0) --> !, [].
pop_args(N) --> !,
	['POP'],
	{N1 is N - 1}, 
	pop_args(N1).


%-------------------------------------------------------%
%       GERACAO DE CODIGO PARA OS Ids GLOBAIS           %
%-------------------------------------------------------%
ids_globais(Xs) --> {var(Xs)}, !, [].
ids_globais([pai=_|Xs]) --> [], !, ids_globais(Xs).
ids_globais([n(X)=_|Xs]) --> 
	{(X = print_int ; X = print_char ; X = read_bool ; X = read_int ; X = read_char ;
	X = write_int ; X = write_char ; X = halt ; X = dump_regs ; X = dump_stack ;
	X = stack_trace)},
	[], !, ids_globais(Xs).

ids_globais([n(Id)=ST|Xs]) -->
	{lookup_simples(ST, classe, decl(var_def)), 
	lookup_simples(ST, global, true),
	lookup_simples(ST, tipo, Tipo),
	( Tipo = int; Tipo = bool ; Tipo = real), !,
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, valor, Valor)},
	[global(Id, '.WORD', Valor)],
	ids_globais(Xs).

ids_globais([n(Id)=ST|Xs]) -->
	{lookup_simples(ST, classe, decl(cnst_def)),
	lookup_simples(ST, global, true),
	lookup_simples(ST, tipo, Tipo),
	( Tipo = int; Tipo = bool ; Tipo = real), !,
	lookup_simples(ST, valor, STvalor),
	lookup_simples(STvalor, valor, Valor)},
	[global(Id, '.WORD', Valor)],
	ids_globais(Xs).

ids_globais([n(_)=_|Xs]) --> [], !, 
	ids_globais(Xs).


	
	

