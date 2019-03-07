#/bin/bash


#Author name: Guadalupe Garcia


rm *.out
rm *.o

echo "Compile the driver module"
gcc -c -Wall -m64 -std=c99 -fno-pie -no-pie -o starthere.o start.c

echo "Assemble the discovery module"
nasm -f elf64 -l discover.lis -o discov.o discover.asm

echo "Compile the summation module"
gcc -c -Wall -m64 -std=c99 -fno-pie -no-pie -o sum.o sum.c

echo "Compile the swap module"
g++ -c -Wall -m64 -std=c++98 -fno-pie -no-pie -o swap.o swap.cpp

echo "Link four object files"
g++ -m64 -std=c++98 -fno-pie -no-pie -o simplestuff.out starthere.o discov.o sum.o swap.o

echo "Run the Simple Parameter Passinng program"
./simplestuff.out

echo "The Bash file says good-bye"
