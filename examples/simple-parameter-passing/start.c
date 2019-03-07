//Author: Guadalupe Garcia
//Author email: gg@hotmail.com

//Program name: Simple Parameter Passing
//Programming languages: C (driver), X86 (main algorithm), C++ (swap), C (reverse) 
//Date program began: February 15, 2019
//Date of last update: February 16, 2019
//Files in this program:
//Status: Done.  No more updates will be performed.

//Purpose: This program has only an academic purpose, namely: discover how X86 can call programs with source codes in C and C++, 
//and correctly pass data between caller and called modules.

//This file name: start.c

#include "stdio.h"

long * discovery();

int main(int argc, char* argv[])
{long * a;   //Uninitialized variable
 printf("Welcome to a discovery of parameters\n");
 printf("This program is brought to you by Guadalupe Garcia\n");
 a = discovery();
 printf("This driver program has received an unknown value, namely:\na = %lu = 0x%lx and *a = %ld = 0x%1lx\n",
         (unsigned long)a, (unsigned long)a, *a, *a);
 printf("Enjoy your time making great programs.\n");
 return 0;
}//End of main
