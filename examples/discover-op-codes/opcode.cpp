//****************************************************************************************************************************
//Program name: "Discover Op Codes".  This program provides a foundation where the user can easily search in the object code *
//to find codes for operator and operands, and find endianess.  Copyright (C) 2018  Floyd Holliday                           *
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
//  Program name: Discover Op Codes
//  Programming languages: One module in C++, and one in X86, and one in Bash script.
//  Date program began: 2017-Dec-01
//  Date of last update: 2018-Apr-30
//  Files in this program: opcode.cpp, discovery.asm, r.sh
//
//Purpose
//  The intent of this program is to provide a platform where users can reverse engineer instructions at the binary level.  Look at
//  the .lis file and make educated guesses as to what the opcode is for any operation.  Students of assembly programming should
//  experiment with changing an opcode in the executable file.
//
//This file:
//  FIle name: opcode.cpp
//  Language: C++
//  Max page width: 132 columns
//  Status: This program was tested more than 7 times on Debian9.3.0 (Dec 2017) without issues.
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -l opcode.lis -o opcode.o opcode.cpp
//  Optimal print specification: Portrait, 7 points, monospace, 8½x11 paper










//Are all these includes really needed?  Can't we omit a few?  What happened to namespace?

#include <stdio.h>
#include <ctime>
#include <cstring>
#include <iostream>
#include <iomanip>


extern "C" void discover();

int main()
{printf("This program will help you discover operators, operands, and their codes.\n");
 discover();
 printf("The driver will return 0 to the operating system.\n");
 return 0;
}
