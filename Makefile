JAVA = CLASSPATH=/usr/share/CUP:. java
JAVAC = CLASSPATH=/usr/share/CUP:. javac

all: jflex cup 

jflex:
	clear
	jflex Generators/tpl.lex

cup:
	cup Generators/tpl.cup
	$(JAVAC) -d . Tpl03.java parser.java sym.java Main_tpl03.java

acker: 
	clear
	$(JAVA) Main_tpl03 exemplos/acker.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < ./sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

afect:  
	clear
	$(JAVA) Main_tpl03 exemplos/afect.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

beep: 
	clear
	$(JAVA) Main_tpl03 exemplos/beep.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp	

cond:  
	clear
	$(JAVA) Main_tpl03 exemplos/cond.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

fact:  
	clear
	$(JAVA) Main_tpl03 exemplos/fact.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

func_call:  
	clear
	$(JAVA) Main_tpl03 exemplos/func_call.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

func_call2:  
	clear
	$(JAVA) Main_tpl03 exemplos/func_call2.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

globais_locais_bloco: 
	clear
	$(JAVA) Main_tpl03 exemplos/globais_locais_bloco.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

nesting: 
	clear
	$(JAVA) Main_tpl03 exemplos/nesting.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

while:  
	clear
	$(JAVA) Main_tpl03 exemplos/while.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

while_break:  
	clear
	$(JAVA) Main_tpl03 exemplos/while_break.s apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp

outro: 
	clear
	$(JAVA) Main_tpl03 [in_file] apt.pl
	gplc --no-top-level anal_sem.pl
	./anal_sem      	
	sim2c < sim.sm > comp.c
	gcc -o comp comp.c	
	./comp
