## Assignment 4: Using the Clock
Compute the average time required to compute the square root of a float number.

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



### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Split Output by Source


## First sample execution

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
Welcome to Assignment 4 created by Linda Gutierrez.
This program is executing on an AMD phenom at 2.2GHz.
The main program will now call the clock module.
```

#### &nbsp;&nbsp;&nbsp; Clock Module (x86)
```
The clock module has started and the time is 782441043 tics.
Please enter the number of desired iterations: 105
Thank you. The iterations will be from 1 through the number inputted.
Iteration number: 10 Sqrt: 3.16227
Iteration number: 20 Sqrt: 4.47213
Iteration number: 30 Sqrt: 5.47722
Iteration number: 40 Sqrt: 6.32455
Iteration number: 50 Sqrt: 7.07106
Iteration number: 60 Sqrt: 7.74596
Iteration number: 70 Sqrt: 8.36660
Iteration number: 80 Sqrt: 8.94427
Iteration number: 90 Sqrt: 9.48683
Iteration number: 100 Sqrt: 10.00000
Iteration number: 105 Sqrt: 10.24695
Total time for computing square roots: 216452874 tics = 0.0983876767 seconds.
The clock function will now return the time to the caller.
```

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
The clock main program received this number 0.0983876767
Have a nice day. Bye
```



## Second sample execution

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
Welcome to Assignment 4 created by Linda Gutierrez.
This program is executing on an AMD phenom at 2.2GHz.
The main program will now call the clock module.
```

#### &nbsp;&nbsp;&nbsp; Clock Module (x86)
```
The clock module has started and the time is 1003443713 tics.
Please enter the number of desired iterations: 3515
Thank you. The iterations will be from 1 through the number inputted.
Iteration number: 351 Sqrt: 18.73499
Iteration number: 702 Sqrt: 26.49528
Iteration number: 1053 Sqrt: 32.44996
Iteration number: 1404 Sqrt: 37.46998
Iteration number: 1755 Sqrt: 41.89272
Iteration number: 2106 Sqrt: 45.89117
Iteration number: 2457 Sqrt: 49.56813
Iteration number: 2808 Sqrt: 52.99056
Iteration number: 3159 Sqrt: 56.20498
Iteration number: 3510 Sqrt: 59.24525
Iteration number: 3515 Sqrt: 59.28743
Total time for computing square roots: 7031602840 tics = 3.1961831090909 seconds.
The clock function will now return the time to the caller.
```

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
The clock main program received this number 3.1961831090909
Have a nice day. Bye
```


## Third sample execution

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
Welcome to Assignment 4 created by Linda Gutierrez.
This program is executing on an AMD phenom at 2.2GHz.
The main program will now call the clock module.
```

#### &nbsp;&nbsp;&nbsp; Clock Module (x86)
```
The clock module has started and the time is 12009443713 tics.
Please enter the number of desired iterations: 4
Thank you. The iterations will be from 1 through the number inputted.
Iteration number: 1 Sqrt: 1.00000
Iteration number: 2 Sqrt: 1.41421
Iteration number: 3 Sqrt: 1.73205
Iteration number: 4 Sqrt: 2.00000
Total time for computing square roots: 2116028408 tics = 0.2349321490944 seconds.
The clock function will now return the time to the caller.
```

#### &nbsp;&nbsp;&nbsp; Driver module (C++)
```
The clock main program received this number 0.2349321490944
Have a nice day. Bye
```
