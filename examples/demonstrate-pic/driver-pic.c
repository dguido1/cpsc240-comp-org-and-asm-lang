//****************************************************************************************************************************
//Program name: "Demonstrate PIC".  This program shows how to develop code in a PIC environment.                             *
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
//Purpose
//  PIC means Position Independent Code.  Beginning in October or November 2017 Linux distro made PIC-enabled object files the 
//  default requirement for the open source linker.  This program will demonstrate how to program in the new PIC environment.  
//  Notice that in this program the linker command makes no reference to PIC.
//
//This file
//  File name: driver-pic.c
//  Language: C
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -m64 -std=c99 -fPIC -o driver-pic.o driver-pic.c
//  Link: g++ -m64 -o demo.out driver-pic.o square.o show4registers.o
//  Optimal print specifications: 132 columns width, 7-point font, monospace, 8½x11 paper
//
//References and credit
//  None: This module is standard C language.
//
//===== Begin code area ===========================================================================================================
//
//
#include <stdio.h>
#include <stdint.h> //For C99 compatibility
//
//The standard prototypes for any functions that may be called later.  This main function calls exactly one function.
 extern double square(unsigned long);
//
int main(int argc, char* argv[])
{double result = -9.99;   //The initial value is completely arbitrary.
 long nice_integer = 31;
 printf("%s\n","The main C program will now call the C++ subprogram.");
 result = square(nice_integer);
 printf("%s%1.16lf\n","The main program has received this number: ",result);
 printf("%s\n","The main function will now terminate by sending zero to the operating system.  Bye");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

//Additional notes to students enrolled in CPSC 240.
//Sometime around October 2017 the open source linker program(s) were modified to expect that the object files being
//linked contained "position independent code" known simply as PIC.  This change broke all the assembly programs I had
//made in the past.  Those programs simply do not link to make an executable.

//So, what is the solution?  There are lots of postings in online forums seeking a solution to the new change.  This
//program Demonstrate-PIC implements a solution posted on line.  By studying this program you will see that a few 
//vital changes in the assembly code are required and then the object files will link and run as expected.  By the way
//the new style linker programs, like this one, will compile, link, and run on the old pre-October-2017 distros as well.

//Conclusion: if your Linux distro was created before October 2017 then you should use the "old style" examples posted 
//at the class website.  The date October 2017 does not refer to the date you installed your distro, but rather it 
//refers to the date the distro was first made available for public download.  If your distro was created after October
//2017 then you should program in the style shown in the program you are now viewing.

