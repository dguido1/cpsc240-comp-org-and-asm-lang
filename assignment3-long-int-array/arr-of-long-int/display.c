// Author name: David Guido
// Program title: arr-of-long-int
// Course number: CPSC 240
// Assignment number: 3
//
// Names of files in this program:
//   1. driverMain.cpp
//   2. control.asm
//   3. squares.cpp
//   4. display.c    (THIS FILE)
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

void display(long arr [], long int argc)
{
    for (long i = 0; i < argc; i++)
       printf("%ld\n", arr[i]);

    return;
}