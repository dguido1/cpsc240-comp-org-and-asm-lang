#/bin/bash


#Author: David Guido    
#Program name: IO Operations

rm *.o
rm *.lst
rm *.out

echo "This is program <IO Operations>"

echo "Assemble the module io-operations-x86.asm"
yasm -f elf64 -l io-operations-x86.lst -o io-operations-x86.o io-operations-x86.asm

echo "Compile the C module IOOperations.c"
gcc -c -m64 -o IOOperations.o IOOperations.c

echo "Link the two object files already created"
gcc -m64 -fno-pie -no-pie -o operations IOOperations.o io-operations-x86.o

echo "Execute the program IO Operations"
./operations

echo "The bash script file is now closing."