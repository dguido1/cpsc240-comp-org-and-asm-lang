// Author name: David Guido
// Program title: arr-of-long-int
// Course number: CPSC 240
// Assignment number: 3
//
// Names of files in this program:
//   1. driverMain.cpp
//   2. control.asm
//   3. squares.cpp    (THIS FILE)
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

    // "C" is a directive to the C++ compiler --> "CCC" rules for parameter passing.
extern "C" void squares(long[], long);

    // Calulates the squares of all elements in the array, then returns the
void squares (long arr[], long size)    // result to the caller funtion.
{
    for (long i = 0; i < size; i++)     // Square every element in array.
        arr[i] = arr[i] * arr[i];
}