//Author name: Floyd Holliday
//Author email: holliday@fullerton.eduu

//Program name: View System Stack
//Programming languages: C++ (driver), X86 (algorithm)
//Date program began: April 2, 2017
//Date of last update: February 1, 2019
//Files in this program: stack-driver.cpp, stackdump.asm, r.sh
//Status: Done.  No more work will be done on this program apart from fixing any reported errors.

//Purpose: Show how a C++ programmer can call a program to display the contents of the system stack.

//This file name: stack-driver.cpp
//Compile: g++ -c -m64 -std=c++98 -Wall -o drive.o  stack-driver.cpp -fno-pie -no-pie
//Link:    g++ -m64 -std=c++98 -o go.out drive.o dump.o -fno-pie -no-pie

#include <iostream>
using namespace std;

//Prototype:
extern "C" unsigned long viewstack(long,unsigned long,unsigned long);
//The first input parameter is an arbitrary integer chosen by the programmer or the user.
//The second parameter is the number of qwords inside the stack to be displayed.
//The third parameter is the number of qwords outside the stack to be displayed.

//The variables used in this C++ main function have no importance other than their values will apppear in the displayed stack.
int main(int argc, char* argv[])
{long int u=7;
 long int v=6;
 long int w=5;
 long int sum=4;
 long int value_from_viewstack=200;  //rsp+64  //200 = 0xc8
// cout << "Enter 3 long integers separated by ws (the enter key is considered to be ws) " << endl;
// cin >> u;
// cin >> v;
// cin >> w;
// sum = u+v+w;
 value_from_viewstack = viewstack(10,7,13);
 cout << "Search in output #10 for values: 7, 6, 5, 4, 200" << endl;
 cout << "1st value returned from dumpstack = " << dec << value_from_viewstack << " which equals 0x" << hex << value_from_viewstack << endl << endl;
 long int x = -1;
 value_from_viewstack = viewstack(20,5,16);
 cout << "Search in output #20 for value -1" << endl;
 cout << "2nd value returned from dumpstack = " << dec << value_from_viewstack << " which equals 0x" << hex << value_from_viewstack << endl << endl;
 cout << "Lucky number = " << u+v+w+sum+x+value_from_viewstack << " Have a nice program." << endl;
 return 0;
}
 

//The stack frame ends with the qword containing the next instruction to execute after control returns to the caller.
//Notice that the stack frame always ends off the 16-byte boundary.  The reason is that the next frame begins on a 16-byte boundary.

//Where does the stack frame begin?  That is harder to pin point.  You might try to identify the end of the previous stack frame in order to 
//find the start of the current stack frame.
