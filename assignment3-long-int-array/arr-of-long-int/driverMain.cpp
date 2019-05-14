// Author name: David Guido
// Program title: arr-of-long-int
// Course number: CPSC 240
// Assignment number: 3
//
// Names of files in this program:
//   1. driverMain.cpp    (THIS FILE)
//   2. control.asm
//   3. squares.cpp
//   4. display.c
//   5. mean.asm
//   6. run.sh
//
// Program purpose: 
//   1  Declare an array 
//   2  Pass data to a subprogram
//   3  Convert an integer to a numerically equal floating point number
//   4  Pass a float number to another function
//   5  Use a GPR register in the role of index to an array.
//
// Status: Complete
// Date of last modification: May 13, 2019
// ********************************************

#include <stdio.h>
#include <stdint.h>
#include <ctime>
#include <cstring>
#include <iostream>
#include <iomanip>
#include <math.h>

    // "C" is a directive to the C++ compiler --> "CCC" rules for parameter passing.
extern "C" double control(); 
using namespace std;

int main (int argc, char* argv[])
{
    printf("\nWelcome to an array of long integers.\nThis program is brought to you by David Guido.\n\n");

    double answer = 0.0;

    answer = control();
    printf("%s%1.18lf%s\n","\nThe driver received this unknown number: ", 
    answer,".\nThe driver will now return 0 to the operating system.");

    return 0;
} 