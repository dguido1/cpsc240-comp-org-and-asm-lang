#/bin/bash

#Author: Floyd Holliday
#Program name; Discover Op Codes

rm *.out

echo "Compile the C++ file opcode.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l opcode.lis -o opcode.o opcode.cpp

echo "Assemble the X86 file opcode.asm"
nasm -f elf64 -l discovery.lis -o discovery.o discovery.asm

echo "Link the object files opcode.o and discovery.o"
g++ -m64 -fno-pie -no-pie -o code.out opcode.o discovery.o

echo "Execute the program Discover Op Codes"
chmod u+x code.out
./code.out

echo "The script file will now terminate"
