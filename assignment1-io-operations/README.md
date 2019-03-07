## Assignment 1: IO Operations
Use of C custom / library functions within assembly source for the purpose of **simplifying IO operations**

**Author name:** &nbsp;&nbsp;&nbsp; *David Guido*  
**Program title:** &nbsp;&nbsp;&nbsp; *IO Operations*<br/><br/>
**Files in this program:**  
- io-operations-x86.asm
- IOOperations.c
- run.sh

**Course number:** &nbsp;&nbsp;&nbsp; *CPSC 240*  
**Assignment number:** &nbsp;&nbsp;&nbsp; *1*  


************************************************************  
### Assignment 1 Shell Commands | February 8, 2019

###### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Remove Old Files --> Assemble --> Link --> Complile --> Load Process*  
```
rm *.out  
rm *.lst  
rm *.o  
yasm -f elf64 -l io-operations-x86.lst -o io-operations-x86.o io-operations-x86.asm  
gcc -c -m64 -o IOOperations.o IOOperations.c  
gcc -m64 -fno-pie -no-pie -o operations IOOperations.o io-operations-x86.o  
./operations
```  
#### Command Option Review:  
  
`gcc -c`&nbsp;&nbsp;*Compile source files to object files without linking*  
`gcc -Wall`&nbsp;&nbsp;*Enable all warning messages*  
`gcc -m64`&nbsp;&nbsp;*Generate code for a 32-bit or 64-bit environment*  
`gcc -o`&nbsp;&nbsp;*Output filewrite build output to output file*  
  
`yasm -f [format]`&nbsp;&nbsp;*Select object format*  
`elf64`&nbsp;&nbsp;*Standard object format in common use on modern Unix and compatible systems*  

************************************************************
************************************************************

## Assignment 1 Shell Command Notes:

&nbsp;&nbsp;1. YASM Assembler  
&nbsp;&nbsp;2. GCC Compiler  
   
************************************************************

1. YASM Assembler | Shell Command Options:

#### YASM Synopsis:

`yasm [-f format] [-o outfile] [other options...] infil`

- The yasm command assembles the file infile and directs output to the file outfile if specified.

*********************************

#### Options:

##### &nbsp;May be given in one of two forms:  
1. Dash followed by a single letter 
2. Two dashes followed by a long option name.  
- Listed in alphabetical order.

*********************************

#### General Options:

`-a arch` or `--arch`
- Select target architecture  

<br/>`-f format` or `--oformat=format`
- Select object format  

<br/>`-g debug` or `--dformat=debug`
- Select debug format

<br/>`-h` or `--help`
- Print a summary of options  

<br/>`-L list` or `--lformat=list`
- Select list file format

<br/>`-l listfile` or `--list=listfile`
- Specify list filename

<br/>`-m machine` or `--machine=machine`
- Select target machine architecture

<br/>`-o filename` or `--objfile=filename`
- Specify object filename

<br/>`-p parser` or `--parser=parser`
- Select parser

<br/>`-r preproc` or `--preproc=preproc`
- Select preprocessor

<br/>`--version`
- Get the Yasm version


*********************************

#### Preprocessor Options:

- The only preprocessor currently in Yasm is the “nasm” preprocessor.

<br/>`-D macro[=value]`
- Pre-define a macro

<br/>`-e` or `--preproc-only`
- Only preprocess

<br/>`-I path`
- Add include file path

<br/>`-P filename`
- Pre-include a file

<br/>`-U macro`
- Undefine a macro

*********************************  

#### Warning Options:  

- W options have two contrary forms:  

`-W?name?`  
`-Wno-name`  

- Only the non-default forms are shown here. 
- The warning options are handled in the order given on the command line, 
     so if -w is followed by -Worphan-labels, all warnings are turned off 
     except for orphan-labels.  

<br/>`-w`
- Inhibit all warning messages

<br/>`-Werror`
- Treat warnings as errors

<br/>`-Wno-unrecognized-char`
- Do not warn on unrecognized input characters

<br/>`-Worphan-labels`
- Warn on labels lacking a trailing colon

<br/>`-X style`
- Change error/warning reporting style

*********************************

#### Supported Object Formats:

- The “bin” object format produces a flat-format, non-relocatable binary file. It is appropriate for producing DOS .COM executables or things like boot blocks. It supports only 3 sections and those sections are written in a predefined order to the output file.


<br/>`coff` 
- The COFF object format is an older relocatable object format used on older Unix and compatible systems, and also (more recently) on the DJGPP development system for DOS.
 

<br/>`dbg` 
- The “dbg” object format is not a “real” object format; the output file it creates simply describes the
          sequence of calls made to it by Yasm and the final object and symbol table information in a humanreadable
          text format (that in a normal object format would get processed into that object format’s particular
          binary representation). This object format is not intended for real use, but rather for debugging
          Yasm’s internals.

<br/>`elf` 
- The ELF object format really comes in three flavors: “elf32” (for 32-bit targets), “elf64” (for 64-bit targets),
          and “elfx32” (for x32 targets). ELF is a standard object format in common use on modern Unix
          and compatible systems (e.g. Linux, FreeBSD). ELF has complex support for relocatable and shared
          objects.

<br/>`macho` 
- The Mach-O object format really comes in two flavors: “macho32” (for 32-bit targets) and “macho64”
          (for 64-bit targets). Mach-O is used as the object format on MacOS X. As Yasm currently only
          supports x86 and AMD64 instruction sets, it can only generate Mach-O objects for Intel-based Macs.

************************************************************
************************************************************

2. GCC Compiler | 'GNU Compiler Collection'

###### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--> C Compiler for Linux OS

*********************************

#### Syntax:

<br/>`gcc [options] [source files] [object files] [-o output file]`  
`gcc [-c|-S|-E] [-std=standard] [-g] [-pg] [-Olevel] [-Wwarn...]`  
`[-pedantic] [-Idir...] [-Ldir...] [-Dmacro[=defn]...] [-Umacro]`  
`[-foption...] [-mmachine-option...] [-o outfile] [@file] infile...`  

*********************************

#### GCC Options:

<br/>`gcc -m64`
- Generate code for a 32-bit or 64-bit environment         
                     --> The 32-bit environment sets int, long and pointer to 32 bits and generates code that runs on any i386 system.
                     --> The 64-bit environment sets int to 32 bits and long and pointer to 64 bits and generates code for AMD's x86-64 architecture.

<br/>`gcc -c1`
- compile source files to object files without linking  

<br/>`gcc -Dname[=value]`
- define a preprocessor macro  

<br/>`gcc -fPIC`
- generate position independent code for shared libraries  

<br/>`gcc -glevel`
- generate debug information to be used by GDB  

<br/>`gcc -Idir`
- add include directory of header files  

<br/>`gcc -llib`
- link with library file  

<br/>`gcc -Ldir`
- look in directory for library files  

<br/>`gcc -o`
- output filewrite build output to output file  

<br/>`gcc -O`
- level optimize for code size and execution time  

<br/>`gcc -shared`
- generate shared object file for shared library  

<br/>`gcc -Uname`
- undefine a preprocessor macro  

<br/>`gcc -w`
- disable all warning messages  

<br/>`gcc -Wall`
-  enable all warning messages  

<br/>`gcc -Wextra`
- enable extra warning messages  

<br/>`gcc -pie`
- Produce a dynamically linked position independent executable on targets that support it.
                     For predictable results, you must also specify the same set of options used for compilation
                     (-fpie, -fPIE, or model suboptions) when you specify this linker option.  

<br/>`gcc -fno-pie`
- Don’t produce a dynamically linked position independent executable.  
