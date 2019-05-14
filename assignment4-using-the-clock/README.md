## Assignment 4: Using the Clock
compute the average time required to compute the square root of a float number.

<br/>&nbsp;&nbsp;&nbsp;&nbsp;California State University, Fullerton
<br/>&nbsp;&nbsp;&nbsp;&nbsp;CPSC 240: Computer Organization and Assembly Language
<br/>&nbsp;&nbsp;&nbsp;&nbsp;Spring 19'
***
<br/>


Introduction
Every microprocessor contains a simple clock. This assignment provides practical hands-on
experience in using that clock. The whole purpose of this assignment is for you to have real
experience in the use of the clock.

Program requirements
Create a two module system. The driver module is either C or C++; you pick one. The driver
module has nothing to do with the solution.
The driver module calls the clock module written in X86 assembly. This module is going to
compute the average time required to compute the square root of a float number. The module
will measure the time required to do the one instruction “square root” many times. Then the
average time needed to perform the square root operation is computed and outputted. Then the
program ends.
In the clock module the user inputs an integer, which we’ll call N. The number N is the number
of square roots to be computed. In pseudo code this is the processing:
for(int k = 1; k<N;k++)
{register#1 = clocktime;
register#2 = squareroot(k);
register#3 = clocktime;
totaltimeregister += (register#3 – register#1)
//Discard data in register#2.
}//End loop
The amount of time need to compute the square root of k is added to the accumulator. After the
loop finishes we want to use the value in the accumulator.
You pick suitable registers for pseudo variables appearing in the pseudocode above.
