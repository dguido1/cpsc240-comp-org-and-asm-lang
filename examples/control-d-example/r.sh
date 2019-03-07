#/bin/bash

#Author: Floyd Holliday
#Program name: Control D Example
#Language: Bash

rm *.o, *.lis, *.out

echo "Assemble the X86 file control-d.asm"
nasm -f elf64 -l control-d.lis -o control-d.o control-d.asm

echo "Compile the C++ file control-d-main.cpp"
g++ -c -m64 -Wall -l control-d-main.lis -o control-d-main.o -fno-pie -no-pie control-d-main.cpp

echo "Link the 'O' files control-d-main.o, control-d.o"
g++ -m64 -fno-pie -no-pie -o d.out control-d-main.o control-d.o

echo "Run the Control-d program"
./d.out


