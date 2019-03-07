#/bin/bash

#Author: F. Holliday


rm *.out

echo "Compile the C++ file pointer_ref.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o point_ref.o pointer_ref.cpp

echo "Assemble the X86 file opcode.asm"
nasm -f elf64 -l merchandise.lis -o merchandise.o merchandise.asm

echo "Link the object files"
g++ -m64 -fno-pie -no-pie -o purchase.out point_ref.o merchandise.o 

echo "Execute the program Pointer and Reference"
./purchase.out

echo "The script file will now terminate"
