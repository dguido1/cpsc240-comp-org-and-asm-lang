#/bin/bashh

echo "Remoove old binary files if any still exist"
rm *.out
rm *.o

echo "Assemble the file stackdump.asm"
nasm -f elf64 -o view.o -l dump.lis viewstack.asm

echo "Compile the C++ file stack-driver.cpp"
g++ -c -m64 -std=c++98 -Wall -o drive.o  view-stack-driver.cpp -fno-pie -no-pie

echo "Link together the recently created object files"
g++ -m64 -std=c++98 -o go.out drive.o view.o -fno-pie -no-pie

echo "Run the program named View System Stack"
./go.out

echo "The Bash file has finished"

