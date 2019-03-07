//Author: Guadalupe Garcia
//Author email: gg@hotmail.com

//Program name: Simple Parameter Passing
//Programming languages: C (driver), X86 (main algorithm), C++ (swap), C (sum) 
//Date program began: February 15, 2019
//Date of last update: February 16, 2019
//Files in this program: start.c, discover.asm, swap.cpp, sum.c
//Status

//Purpose: This program has only an academic purpose, namely: discover how X86 can call programs with source codes in C and C++, 
//and correctly pass data between caller and called modules.

//This module: swap
//File name: swap.cpp
//Compile: g++ -c -Wall -m64 -std=c++98 -fno-pie -no-pie -o swap.o swap.cpp
#include<iostream>
using namespace std;

//Prototype: the prefix extern "C" is required because the C++ compiler will be used to compile this file.
extern "C" void swap(long *, long *);

void swap(long * first_address, long * second_address)
{cout << "FYI: the function swap, written in C++, has begun execution" << endl;
 long temp;
 temp = *first_address;
 *first_address = *second_address;
 *second_address = temp;
}//End of swap

