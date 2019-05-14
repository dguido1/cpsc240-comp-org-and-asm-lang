/*  
    Author name: David Guido
    Program name: End of Transmission
    Names of files in this programming:
    1. EndOfTransmission.c
    2. end-of-transmission-x86.asm
    3. run.sh
    Course number: CPSC 240
    Scheduled delivery date: February 18, 2019
    Program purpose: 
    1. The implementation of a loop in X86
    2. The use of Control+D to signal the end of a sequence of data
    3. The summation of numerical data in an accumulator
    Status: Complete
    Date of last modification: Feb 11, 2019
    Information about this module:
    This module purpose: The summation of a user defined amount of 64 bit integers 
    File name of this module: EndOfTransmission.cpp
    Compile this module: 
    g++ -c -m64 -Wall -l EndOfTransmission.lis -o EndOfTransmission.o -fno-pie -no-pie EndOfTransmission.cpp
    Link this module with other objects:
    g++ -m64 -fno-pie -no-pie -o eot EndOfTransmission.o end-of-transmission.o
*/

#include <iostream>

using namespace std;

extern "C" int accumulateSumOfInput ();  // ~ x86 (64 bit) .asm file function
                                         // extern C --> 'CCC','C Calling Convention'
int main()                               // Rules for parameter passing.
{
    int return_sum = 0;
    
    printf("\nWelcome to End of Transmission.");
    printf("\nThis program is brought to you by David Guido.\n\n");
    
    return_sum = accumulateSumOfInput();  // Return an int, the sum of all the
                                          // user-inputed numeric values
    printf("\nThe main program received this number: %d.",  return_sum);        
    printf("\nMain will return 0 to the operating system. Have a nice day.\n\n");

    return 0; 
}