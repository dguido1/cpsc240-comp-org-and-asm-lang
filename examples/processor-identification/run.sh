#/bin/bash


#Author: Floyd Holliday
#Program name: Processor Identification

rm *.o
rm *.out

echo "This is program <CPU Identtification>"

echo "Assemble the module cpuidentify.asm"
nasm -f elf64 -l cpuidentify.lis -o cpuidentify.o cpuidentify.asm

echo "Compile the C module cpuidentification.c"
gcc -c -m64 -Wall -l cpuidentification.lis -o cpuidentification.o cpuidentification.c -fno-pie -no-pie

echo "Link the two object files already created"
g++ -m64 -o cpu.out cpuidentify.o cpuidentification.o -fno-pie -no-pie

echo "Execute the program CPU Identification"
./cpu.out

echo "The bash script file is now closing."
