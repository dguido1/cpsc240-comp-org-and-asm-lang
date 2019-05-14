# **************************************
# Author name: David Guido
# Program name: End of Transmission
#
# Shell Commands:
# 1. 
# chmod +x run.sh
# 2. 
# ./run.sh eot
#
# --> Now, run script with ./eot
# **************************************
rm *.o
rm *.lis
rm *.out

echo "Compile EndOfTransmission.cpp, the C++ file.."
g++ -c -m64 -Wall -l EndOfTransmission.lis -o EndOfTransmission.o -fno-pie -no-pie EndOfTransmission.cpp

echo "Assemble end-of-transmission.asm, the x86 assembly file.."
yasm -f elf64 -l end-of-transmission.lis -o end-of-transmission.o end-of-transmission.asm

echo "Link both EndOfTransmission.o & end-of-transmission.o, the two object files.."
g++ -m64 -fno-pie -no-pie -o eot.out EndOfTransmission.o end-of-transmission.o

echo "Run the End Of Transmission Program"
./eot.out