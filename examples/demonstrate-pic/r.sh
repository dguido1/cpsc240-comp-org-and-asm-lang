#/bin/bash



#Author name: Floyd Holliday
#Program name: Demonstrate PIC

rm *.o
rm *.out

echo "This is the script file ready to compile, link, and execute the file of the program Demonstrate PIC."

echo "Now assembling show4registers.asm"
nasm -f elf64 -l show4registers.lis -o show4registers.o show4registers.asm

echo "Now compiling function square.cpp"
g++ -c -Wall -m64 -fPIC -o square.o square.cpp

echo "Now compiling driver.c"
gcc -c -Wall -m64 -std=c99 -fPIC -o driver-pic.o driver-pic.c

echo "Now linking all the o files"
g++ -m64 -o demo.out driver-pic.o square.o show4registers.o

echo "The program will run next.  There will be no more messages from the script file."
./demo.out


#Summary
#The module show4registers.asm contains only PIC compliant code.

#The module square.cpp contains PIC non-compliant code: it must be compiled with parameter "-fPIC".

#The module driver-pic.c contains PIC non-compliant code: special parameter is not needed; the C compiler knows how to produce a compliant object file.

#The linker has no parameter specifying non-compliant object files: all the O-files are compliant and ready to be linked in the traditional fashion.

#The program runs successfully.
