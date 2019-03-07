//Author: Guadalupe Garcia
//Author email: gg@hotmail.com

//Program name: Simple Parameter Passing
//Programming languages: C (driver), X86 (main algorithm), C++ (swap), C (sum) 
//Date program began: February 15, 2019
//Date of last update: February 16, 2019
//Files in this program: start.c, discover.asm, sum.c, swap.cpp
//Status: Done.  No more development work will be performed on thhis proj

//Purpose: This program has only an academic purpose, namely: discover how X86 can call programs with source codes in C and C++, 
//and correctly pass data between caller and called modules.

//This module: summation
//File name: sum.c
//Compile: gcc -c -Wall -m64 -std=c99 -fno-pie -no-pie -o sum.o sum.c

#include "stdio.h"

//Prototype: The prefix extern "C" is not used because a non-C++ compiler will be used for compiling this file.
long int summation(long int [], long int);

long int summation(long int myarray[], long int number_of_elements)
{printf("FYI: the function summation, written in C, has begun execution\n");
 long int total = 0;
 long int loop_counter = 0;
 for(loop_counter = 0;loop_counter<number_of_elements;loop_counter=loop_counter+1)
      total += myarray[loop_counter];
 return total;
}//End of summation
