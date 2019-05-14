# Author name: David Guido
# Program title: arr-of-long-int
# Course number: CPSC 240
# Assignment number: 3
#
# Names of files in this program:
#   1. driver-main.cpp
#   2. control.asm
#   3. square.cpp
#   4. display.c
#   5. mean.asm
#   6. run.sh    (THIS FILE)
#
# Program purpose: 
#   1  Declare an array 
#   2  Pass data to a subprogram
#   3  Convert an integer to a numerically equal floating point number
#   4  Pass a float number to another function
#   5  Use a GPR register in the role of index to an array.
#
# Status: Complete
# Date of last modification: May 13, 2019
# ********************************************

rm *.out    # Remove other helper files.
rm *.o
rm *.lis

echo "Bash script has started.\n"

    # Assemble x86 module.
nasm -f elf64 -l control.lis -o control.o control.asm

    # Assemble x86 module.
nasm -f elf64 -l calculateMean.lis -o calculateMean.o calculateMean.asm

    # Compile C++ module.
g++ -c -m64 -Wall -l driverMain.lis -o driverMain.o driverMain.cpp -fno-pie -no-pie

    # Compile C++ module.
g++ -c -m64 -Wall -l squares.lis -o squares.o squares.cpp -fno-pie -no-pie

    # Compile C module.
g++ -c -m64 -Wall -l display.lis -o display.o display.c -fno-pie -no-pie

    # Link object files.
g++ -m64 -o array.out control.o calculateMean.o driverMain.o squares.o display.o -fno-pie -no-pie

echo "The bash script has concluded its execution. It will now close.\n"

    # .out file execution.
./array.out