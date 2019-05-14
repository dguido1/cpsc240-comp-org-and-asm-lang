// Author name: David Guido
// Program title:  IO Operations
// Files in this program:  IOOperations.c,  io-operations-x86.asm, run.sh
// Course number:  CPSC 240
// Assignment number: 1
// Required delivery date:  Feb 4, 2019 before 11:59pm
// Purpose: Learn how to embed C library function calls in an X86 module.
// Language of this module:  C
//
// *** Module Commands for YASM Assembler & GNU Compiler *** 
// Remove Old Files: 
//   rm *.out, rm *.lst, rm *.o
// Assemble:
//   yasm -f elf64 -l io-operations-x86.lst -o io-operations-x86.o io-operations-x86.asm
// Link:
//   gcc -c -m64 -o IOOperations.o IOOperations.c
// Complile:
//   gcc -m64 -fno-pie -no-pie -o operations IOOperations.o io-operations-x86.o
// Load Process:
//   ./operations

#include <stdio.h>

int printWelcomeMsg()
{
        printf("\nWelcome to IO Operations");
        printf("\nThis program was created by David Guido");
        printf("\nand completed on February 8, 2019\n\n");
        
        return 0; 
}

unsigned int sendRemainder(int remainder)
{
        printf("\nThe driver function has received this number: %d",  remainder);        
        printf("\nThe driver will now return 0 to the operating system. Have a nice day.");        
        printf("\n\n\t");
        return 0; 
}