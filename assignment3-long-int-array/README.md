## Assignment 3: Array of Long Integers
Converts an integer to a numerically equal floating point number before passing it to another function for arithmetic manipulation

<br/>&nbsp;&nbsp;&nbsp;&nbsp;California State University, Fullerton
<br/>&nbsp;&nbsp;&nbsp;&nbsp;CPSC 240: Computer Organization and Assembly Language
<br/>&nbsp;&nbsp;&nbsp;&nbsp;Spring 19'
***
<br/>

## Table of contents
  * [Educational Objectives](#educational-objectives)
  * [Program Structure](#program-structure)
  * [Source Files](#source-files)
  * [Output](#output)
     * [Split Sample Output by Source](#split-output-by-source)
     * [Full Output](#full-output)
* [Actual Output](#actual-output)
<br/><br/><br/>
***
<br/>

## Educational Objectives
   1.  &nbsp;&nbsp;Declare an array
   2.  &nbsp;&nbsp;Pass data to a subprogram
   3.  &nbsp;&nbsp;Convert an **integer** to a numerically equal **floating point number**
   4.  &nbsp;&nbsp;Pass a float number to another function
   5.  &nbsp;&nbsp;Use a GPR register in the role of index to an array
<br/><br/><br/>
***
<br/>

## Program Structure
![240assn3img](https://user-images.githubusercontent.com/47490318/53944906-3705f780-4075-11e9-84e7-34c20bf93de7.png)
<br/><br/><br/>
***
<br/>

## Source Files
1. The module called “*driver*” does not know anything about what this program does  
   - Its principle job is to call the control module
   - When the control module has terminated this driver has received
     a number having no special significance to the driver
     - The driver simply prints that number  
<br/>

2. The “*control*” module is really in charge of this program  
   - It declares the array
   - It asks the user to input data into the array
   - It calls submodules:
     1. display
     2. compute_mean
     3. square
   - At the end it returns the computed mean  
<br/>

3. The module “*display*” performs only one task:  
   1. Output in an orderly fashion the data in any array passed to it
       - This module does not display any welcome messages nor any general information  
<br/>

4. The module compute_mean does what its name says  
   1. First it finds the sum of all the numbers in the array
   2. Then it divides the sum by the count of how many numbers are present
   3. The quotient is now called mean
   4. The mean is returned to the calling program
   5. This module does not output anything  
<br/>

5. The module “*square*” changes every value in the array to become the square of the value
   - This module does not output anything by itself  
<br/>

The bash file runs the entire show
   - It compiles 5 sources files and then links them into a single executable file, and then executes that file
   - You already know how to do this
<br/><br/><br/>
***
<br/>

## Output

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Split Sample Output by Source

#### &nbsp;&nbsp;&nbsp; Main Function (C++)
```
Welcome to an array of long integers. 
This program is brought to you by Mai Hong Lam. 
```

#### &nbsp;&nbsp;&nbsp; Controller (x86)
```
The control module has begun. 
Instructions: Enter a sequence of integers.  Include white space between each number.
To terminate press ‘Enter’ followed by Control+D.   
73   56   95    27    82     9  <enter><cntl+D>      
Here are the data as received: 
```

#### &nbsp;&nbsp;&nbsp; Display Module (C)
```
73  
56            
95              
27   
83 
9
```

#### &nbsp;&nbsp;&nbsp; Controller (x86)
```
The mean of these 6 numbers is 57.1667 
Here are the squares of the data:
```

#### &nbsp;&nbsp;&nbsp; Display Module (C)
```
5329    
3136       
9025        
729      
6889                 
81       
```

#### &nbsp;&nbsp;&nbsp; Controller (x86)
```
The control module is now returning to the caller module.  Bye. 
```

#### &nbsp;&nbsp;&nbsp; Main Function (C++)
```
The driver received this unknown number:   57.1667  
The driver will now return 0 to the operating system.
```
<br/>

***

<br/>



### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Full Sample Output
```
Welcome to an array of long integers.
This program is brought to you by Mai Hong Lam.

The control module has begun.
Instructions: Enter a sequence of integers.  Include white space between each number.
To terminate press ‘Enter’ followed by Control+D.
73   56   95    27    82     9  <enter><cntl+D>
Here are the data as received:
73
56
95
27
83
9
The mean of these 6 numbers is 57.1667
Here are the squares of the data:
5329
3136
9025
729
6889
81
The control module is now returning to the caller module.  Bye.

The driver received this unknown number:   57.1667
The driver will now return 0 to the operating system.

```
<br/><br/><br/>
***
<br/>

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Actual Output
```
Bash script has started.\n
The bash script has concluded its execution. It will now close.\n

Welcome to an array of long integers.
This program is brought to you by David Guido.

The control module has begun.
Instructions: Enter a sequence of integers.
To terminate press ‘Enter’ followed by Control+D.
73
56
95
27
83
9
Here are the data as received:
73
56
95
27
83
9
The mean of these 6 numbers is 57.166667
Here are the squares of the data:
5329
3136
9025
729
6889
81
The control module is now returning to the caller module. Bye.

The driver received this unknown number: 57.166666666666664298.
The driver will now return 0 to the operating system.

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
