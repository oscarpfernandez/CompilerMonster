#include <stdio.h>

// == Global data =============================================================

#define W  * 4
#define KB * 1024
#define MB KB KB

#define DATA_SZ   1 MB
#define HEAP_SZ   1 MB
#define STACK_SZ  1 MB

#define MEM_SZ ((DATA_SZ) + (HEAP_SZ) + (STACK_SZ))

union {
  int mem[0];
  struct {
    int m_mc;
    int m_nc;
  } named;
  struct {
    int z_data[DATA_SZ];
    int z_heap[HEAP_SZ];
    int z_stack[STACK_SZ];
  } zone;
} global;

#define M      global.mem
#define DATA   global.zone.z_data
#define HEAP   global.zone.z_heap
#define STACK  global.zone.z_stack

int SP = MEM_SZ;
int FP = 0;
int SR;
void *PC;				// (unused)

// -- Names for global variables ----------------------------------------------

#define GV_mc ((int *) &global.named.m_mc - (int *) &global.named)
#define GV_nc ((int *) &global.named.m_nc - (int *) &global.named)

// == Program =================================================================

int main (int argc, char *argv[])
{
  int i;

// -- Initialization ----------------------------------------------------------
  global.named.m_mc = 3;
  global.named.m_nc = 8;

// -- Library -----------------------------------------------------------------

	goto lib_init;			// skip library code!

print_int:				// print_int (int) -> ()
	printf ("%d\n", M[SP+1]);
	goto * ((void *) M[SP++]);

print_char:				// print_char (int) -> ()
	putchar (M[SP+1]);
	goto * ((void *) M[SP++]);

read_int:				// read_int () -> int
	scanf ("%d", &M[SP+1]);
	goto * ((void *) M[SP++]);

read_char:				// read_char () -> int
	M[SP+1] = getchar ();
	goto * ((void *) M[SP++]);

halt:					// halt () -> ()
	return 0;

dump_regs:				// dump_regs () -> ()
	{
	  printf ("-- Register dump --\n");
	  printf ("SP = 0x%x (%d)\n", (int) SP, (int) SP);
	  printf ("FP = 0x%x (%d)\n", (int) FP, (int) FP);
	  printf ("SR = 0x%x (%d)\n", (int) SR, (int) SR);
	  printf ("PC = (unused)\n");
	}
	goto * ((void *) M[SP++]);

dump_stack:				// dump_stack () -> ()
	{
	  printf ("-- Stack dump --\n");
	}
	goto * ((void *) M[SP++]);

stack_trace:				// stack_trace () -> ()
	{
	  printf ("-- Stack trace --\n");
	}
	goto * ((void *) M[SP++]);

lib_init:
	{
	  // (declarations for function ) (print_int);
	  // (declarations for function ) (print_char);
	  // (declarations for function ) (read_int);
	  // (declarations for function ) (read_char);
	  // (declarations for function ) (halt);
	  // (declarations for function ) (dump_regs);
	  // (declarations for function ) (dump_stack);
	  // (declarations for function ) (stack_trace);
	}

// -- Start execution ---------------------------------------------------------
  M[--SP] = (int) &&L_exit_program; // Save return address for main program
  goto program;			// start kicking...
L_exit_program:			// Return here, and...
  exit (0);			// quit.
  

// -- Instructions ------------------------------------------------------------
program:
	M[--SP] = 0;	// PUSH 0
	{ int N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK
	M[SP-1] = M[SP]; --SP;		// DUP
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = GV_nc;	// PUSH nc
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = GV_mc;	// PUSH mc
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = (int) &&acker;	// PUSH acker
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_11; goto *C; } // CALL
P_11:	++SP;				// POP
	++SP;				// POP
	M[--SP] = (int) &&print_int;	// PUSH print_int
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_15; goto *C; } // CALL
P_15:	++SP;				// POP
	++SP;				// POP
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = 10;	// PUSH 10
	M[--SP] = (int) &&print_char;	// PUSH print_char
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_21; goto *C; } // CALL
P_21:	++SP;				// POP
	++SP;				// POP
	SP=FP; FP=M[SP-1];		// UNLINK
	goto * ((void *) M[SP++]);		// JUMP

acker:
	M[--SP] = 0;	// PUSH 0
	{ int N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK
	M[--SP] = (int) &&label_1;	// PUSH label_1
	M[--SP] = 1;	// PUSH 1
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 0;	// PUSH 0
	M[SP+1] = M[SP+1] < M[SP+0]; ++SP; // SLT
	M[--SP] = 1;	// PUSH 1
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[--SP] = 0;	// PUSH 0
	M[--SP] = 1;	// PUSH 1
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[SP+1] = M[SP+1] < M[SP+0]; ++SP; // SLT
	M[--SP] = 1;	// PUSH 1
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[SP+1] = M[SP+1] * M[SP+0]; ++SP; // MUL
	if (! M[SP++]) goto P_47;	// SKIPZ
	goto * ((void *) M[SP++]);		// JUMP
P_47:	++SP;				// POP
	M[--SP] = (int) &&label_2;	// PUSH label_2
	goto * ((void *) M[SP++]);		// JUMP
label_1:
	M[--SP] = 2;	// PUSH 2
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 1;	// PUSH 1
	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD
	M[--SP] = 3;	// PUSH 3
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = (int) &&label_0;	// PUSH label_0
	goto * ((void *) M[SP++]);		// JUMP
label_2:
	M[--SP] = (int) &&label_3;	// PUSH label_3
	M[--SP] = 2;	// PUSH 2
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 0;	// PUSH 0
	M[SP+1] = M[SP+1] < M[SP+0]; ++SP; // SLT
	M[--SP] = 1;	// PUSH 1
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[--SP] = 0;	// PUSH 0
	M[--SP] = 2;	// PUSH 2
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[SP+1] = M[SP+1] < M[SP+0]; ++SP; // SLT
	M[--SP] = 1;	// PUSH 1
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[SP+1] = M[SP+1] * M[SP+0]; ++SP; // MUL
	if (! M[SP++]) goto P_80;	// SKIPZ
	goto * ((void *) M[SP++]);		// JUMP
P_80:	++SP;				// POP
	M[--SP] = (int) &&label_4;	// PUSH label_4
	goto * ((void *) M[SP++]);		// JUMP
label_3:
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = 1;	// PUSH 1
	M[--SP] = 1;	// PUSH 1
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 1;	// PUSH 1
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[--SP] = (int) &&acker;	// PUSH acker
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_92; goto *C; } // CALL
P_92:	++SP;				// POP
	++SP;				// POP
	M[--SP] = 3;	// PUSH 3
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = (int) &&label_0;	// PUSH label_0
	goto * ((void *) M[SP++]);		// JUMP
label_4:
	M[SP-1] = M[SP]; --SP;		// DUP
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = 2;	// PUSH 2
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 1;	// PUSH 1
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[--SP] = 1;	// PUSH 1
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = (int) &&acker;	// PUSH acker
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_111; goto *C; } // CALL
P_111:	++SP;				// POP
	++SP;				// POP
	M[--SP] = 1;	// PUSH 1
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 1;	// PUSH 1
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[--SP] = (int) &&acker;	// PUSH acker
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_120; goto *C; } // CALL
P_120:	++SP;				// POP
	++SP;				// POP
	M[--SP] = 3;	// PUSH 3
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
label_0:
	SP=FP; FP=M[SP-1];		// UNLINK
	goto * ((void *) M[SP++]);		// JUMP

}

