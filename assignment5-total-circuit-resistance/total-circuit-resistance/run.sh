# Author name: David Guido
# Program title: Total Circuit Resistance
# Course number: CPSC 240
# Assignment number: 5
#
# Names of files in this program:
#   1. circuitDriver.cpp
#   2. circuitControl.asm    
#   3. run.sh      (THIS FILE)
#
# Run this 'run.sh' file from the terminal:
#   1. chmod +x run.sh
#   2. ./run.sh
#
# Status: Complete
# Date of last modification: May 13, 2019
# ********************************************

rm *.out    # Remove other helper files.
rm *.o
rm *.lis

echo "Bash script has started.\n"

    # Assemble x86 module.
echo "Assembling x86 module.\n"
nasm -f elf64 -l circuitControl.lis -o circuitControl.o circuitControl.asm

    # Compile C++ module.
echo "Compiling C++ module.\n"
g++ -c -m64 -Wall -l circuitDriver.lis -o circuitDriver.o circuitDriver.cpp -fno-pie -no-pie

    # Link object files.
echo "Linking object files.\n"
g++ -m64 -o circuit.out circuitControl.o circuitDriver.o -fno-pie -no-pie

echo "The bash script has concluded its execution.\n"
echo "..It will now close..\n"
echo "..Launching Program..\n"

    # .out file execution.
./circuit.out