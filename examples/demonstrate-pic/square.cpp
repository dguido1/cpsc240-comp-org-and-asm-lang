//****************************************************************************************************************************
//Program name: "Demonstrate PIC".  This program shows how to develop code in a PIC environment.                              *
//Copyright (C) 2018  Floyd Holliday                                                                                         *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Demonstrate PIC
//  Programming languages: C language (one module), C++ (one module), X86 (one module), Bash (one module)
//  Date program began: 2018-Feb-01 
//  Date of last update: 2018-Feb-03
//  Date of reorganization of comments: 2018-Nov-10
//  Files in this program: driver-pic.c, square.cpp, show4registers.asm, r.sh
//  Status: Development is done; no further updates are coming.
//
//Purpose of program
//  PIC means Position Independent Code.  Beginning in October or November 2017 Linux distro made PIC-enabled object files the 
//  default requirement for the open source linker.  This program will demonstrate how to program in the new PIC environment.  
//  Notice that in this program the linker command makes no reference to PIC.
//
//This file
//  File name: square.cpp
//  Language: C++
//  Max page width: 132 columns
//  Compile: g++ -c -Wall -m64 -fPIC -o square.o square.cpp
//  Optimal print specifications: 132 columns width, 7-point font, monospace, 8½x11 paper
//
//Purpose of this file
//  Demonstrate techniques of passing data:
//     1.  How to pass a value from C module to C++ module.
//     2.  How to pass an integer from C++ module to assembly module.
//     3.  How to this C++ module receives a double from the assembly module.
//     4.  How this C++ module returns a double to a calling C module.
//
//References and credit
//  None: This module is standard C++ language.
//
//
//
//===== Begin code area ===================================================================================================================================================
//

#include <stdio.h>
//#include <stdint.h> //For C99 compatibility

#include <iostream>

using namespace std;

//Declare the prototypes of any functions that may be called later.  This function calls exactly one other function.
extern "C" double show4registers(long);

//Declare the prototype of this function.
extern "C" double square(unsigned long);
//
double square(unsigned long passed_in_number)
{unsigned long my_number = passed_in_number;
 double returned_value = 1.0;
 printf("%s%016lx\n","The square function has begun and has received this number 0x", my_number);
 printf("%s\n","The square function will now call show4registers and send to it the number 2018");
 returned_value = show4registers(2018);
 printf("%s%lf\n","The function square received this value from show4registers: ",returned_value);
 printf("%s\n","The function square will return control to main.");
 return returned_value+2.0;
}
