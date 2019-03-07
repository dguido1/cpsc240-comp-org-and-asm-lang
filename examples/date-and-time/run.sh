#/bin/bash

#Program: Date and Time
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble date_and_time.asm"
nasm -f elf64 -l date_and_time.lis -o date_and_time.o date_and_time.asm

echo "Compile current-time.c"
gcc -c -Wall -m64 -fno-pie -no-pie -o current-time.o current-time.c

echo "Link the object files"
gcc -m64 -fno-pie -no-pie -o current.out current-time.o date_and_time.o

echo "Run the program Date and Time:"
./current.out

echo "The script file will terminate"




#Summary
#The module date_and_time.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received two parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.
