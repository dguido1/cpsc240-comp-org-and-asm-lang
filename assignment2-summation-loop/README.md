## Assignment 2: End of Transmission
Summation loop of user-inputed numerical data

## Instructions:

1. *The implementation of a loop in x86*

2. *The use of Control+D to signal the end of a sequence of data.*

3. *The summation of numerical data in an accumulator*
***
### Requirements
Make a program containing one function with source in C++ and one function with source code in X86.  
Make a bash file that does the usual actions, namely:
- Translates the X86 file into an object file
- Translates the C++ file into an object file
- Links the 2 object files into a single executable
- Launches that single executable  
***
 
1. The “Main” module is not part of the solution. It outputs various greetings and farewells. The
important thing it does is call the Accumulator module written in X86.

2. The accumulator receives a sequence of 64 bit signed integers. Each inputted number is
separated from its predecessor and successor by white space. The last inputted number is
followed by ‘enter’ and then followed by control+D.

3. The X86 module adds all the inputted numbers and displays the sum of those numbers. The
last action of the X86 module is to return the sum to the main function.  

***
#### Sample session while running this program.
```
Welcome to summing a sequence of integers.
This program is brought to you by Michelle Zaragoza.

The fast accumulator program written in X86 Intel language has begun.
Instructions: Enter a sequence of integers. Include white space between each number.
To terminate press ‘Enter’ followed by Control+D.
Enter an integer: 7
Enter an integer: -3
Enter an integer: 12
Enter an integer: 1
Enter an integer: <enter> <cntl+D>
Thank you. You entered 4 numbers with a sum equal to 17.
The X86 function will now return the sum to the caller program. Bye.

The main program received this number: 17.
Main will return 0 to the operating system. Have a nice day.
```   
***  
***  
### Actual Output:
```

Welcome to End of Transmission.
This program is brought to you by David Guido.

The fast accumulator program written in X86 Intel language has begun.
Instructions: Enter a sequence of integers. Include white space between each number.
To terminate press ‘Enter’ followed by Control+D.
Enter an integer: 7
Enter an integer: -3
Enter an integer: 12
Enter an integer: 1
Enter an integer: 
Thank you. You have entered 4 numbers with a sum equal to 17.
The X86 function will now return the sum to the caller program. Bye.

The main program received this number: 17.
Main will return 0 to the operating system. Have a nice day.

```
