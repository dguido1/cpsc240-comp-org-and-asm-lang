## Assignment 5: Electric Circuits in Parallel
Input the resistance of each sub-circuit, and then compute and display the resistance of the whole circuit.

<br/>&nbsp;&nbsp;&nbsp;&nbsp;California State University, Fullerton
<br/>&nbsp;&nbsp;&nbsp;&nbsp;CPSC 240: Computer Organization and Assembly Language
<br/>&nbsp;&nbsp;&nbsp;&nbsp;Spring 19'
***
<br/>



## Table of contents
  * [Introduction](#introduction)
  * [Application Background](#application-background)
  * [The application](#the-application)
  * [Suggested Approach](#suggested-approach)
  * [Typical Run](#a-typical-run)
  * [Actual Output](#actual-output)

***
<br/>

## Introduction
- This assignment provides an opportunity to use your knowledge of arrays to and practical problem.  There is a way to solve  the problem without arrays, but you’ll improve your skill in using arrays if you use an array based solution.
***
<br/>

## Application Background
- This assignment uses direct current circuits with multiple devices wired in parallel.  An engineering schematic for four devices wired in parallel will be the following diagram.
 <br/>
 
![image](https://user-images.githubusercontent.com/47490318/57693391-f048f680-75fd-11e9-9ae7-7569f0a65aa0.png)

- (This is the electron flow diagram – not the conventional flow diagram.)
<br/>

- The symbol on the far left is voltmeter that reads the voltage E produced by the source.  But that is not needed in this problem.
<br/>

- The symbol slightly right of the voltmeter is a source (battery, generator, wind mill, etc).
<br/>

- A zigzag symbol represents a consuming device (light bulb, coffee maker, personal computer, clock, microwave oven, etc).  The electrical engineers will use the generic name 'resistor” for all such devices.
<br/>

- The electricity flows from the source (say battery) in the direction of the little arrows.  Along the way the electricity flow through resistors (lights, stoves, clocks, etc).  Each device places resistance on the current flow.  Resistance in a circuit is measured in ohms designated as  Ω.  The unicode for  Ω  is  03A9.  Use it in your program.
<br/>

- The diagram shows 4 sub-circuits, but the number of sub circuits could be different.  There could be any integer number of sub-circuits.
***
<br/>
<br/>

## The application
- Make a program that will input the resistance of each sub-circuit, and then compute and display the resistance of the whole circuit.
 <br/>

- Scientists long ago discovered how it works.
<br/>

- Let R represent the resistance of the whole circuit.
      - Let R1 represent the resistance of sub-circuit number 1.
      - Let R2 represent the resistance of sub-circuit number 2.
      - Let R3 represent the resistance of sub-circuit number 3. and so on.
      - You can have many sub-circuits.
<br/>

- The formula discovered by Mr Ohm is
<br/>

- The inputs are  R1, R2, R3 and so on. The main output is R.
***
<br/>
<br/>


## Suggested Approach

- Read in the resistance numbers one by one until you reach control D.  As each number arrives place it into an array.  Of, course you are counting the numbers as they arrive.
<br/>

- With all the numbers in an array loop through the array computing the reciprocal of each number and adding that number to an accumulator.  The last step after the loop has finished is to compute the reciprocal of the accumulator.  That final number will be R = resistance of the entire circuit.
***
<br/>
<br/>

## Typical Run
#### &nbsp;&nbsp;&nbsp; circuitDriver Module (C++)


```
Welcome to Electric Circuit Processing (ECP) by Michelle Spivak.
```

#### &nbsp;&nbsp;&nbsp; circuitControl Module (x86)

```
This program will compute the resistance of a circuit configured with parallel sub-circuits.

Enter the resistance of a circuit:  5.0
Enter the resistance of a circuit:  8.0
Enter the resistance of a circuit:  2.0

Thank you.  The number of sub-circuits is 3.

The total resistance in this system is R = 1.212121212121 Ω

Thank you for using ECP.  The total resistance will now be returned to the driver program.
```

#### &nbsp;&nbsp;&nbsp; circuitDriver Module (C++)
```
The driver received this number:  1.21212121212.
The driver will now return 0 to the operating system.  Have a nice day.
```


## Actual Output

```
  Welcome to Electric Circuit Processing (ECP) by David Guido.

  This program will compute the resistance of a circuit configured with parallel sub-circuits.

  Enter the resistance of a circuit: 3.2
  Enter the resistance of a circuit: 1.2
  Enter the resistance of a circuit: 43.1
  Enter the resistance of a circuit: 

  Thank you. The number of sub-circuits is 3

  The total resistance in this system is R = 0.855406 OHM's.

  Thank you for using ECP.  The total resistance will now be returned to the driver program.

  The driver received this number: 0.855406243539383770.
  The driver will now return 0 to the operating system. Have a nice day.
```



<br/><br/><br/>
***
***
<br/>
Made by:<br/>
David Guido :rocket:<br/>

[Lit Lab Productions](https://www.litlabproductions.com)
***
<br/>
