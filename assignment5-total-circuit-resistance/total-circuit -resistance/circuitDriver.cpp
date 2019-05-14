// Author name: David Guido
// Program title: Total Circuit Resistance
// Course number: CPSC 240
// Assignment number: 5
//
// Names of files in this program:
//   1. circuitDriver.cpp     (THIS FILE)
//   2. circuitControl.asm   
//   3. run.sh
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
extern "C" double circuitController(); 
using namespace std;

int main (int argc, char* argv[])
{
    printf("\nWelcome to Electric Circuit Processing (ECP) by David Guido.\n\n");

    double circuitResult = 0.0;

    circuitResult = circuitController();
    printf("%s%1.18lf%s\n","\nThe driver received this number: ", 
    circuitResult,".\nThe driver will now return 0 to the operating system. Have a nice day.");

    return 0;
} 