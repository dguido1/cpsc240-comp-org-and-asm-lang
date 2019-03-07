;****************************************************************************************************************************
;Program name: "Processor Identification".  This program demonstrates how to call functions in the C library for the        *
;purpose of inputting or outputting numeric values.  Copyright (C) 2015  Floyd Holliday                                     *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *;
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3****

;Author information
;  Author name:  F. Holliday
;  Email: holliday@fullerton.edu
;Program information
;  Program name: Processor Identification
;  Programming languages: C (1 module)), X86 (1 module)
;  Date program development began: 2015-Sep-21
;  Date of last modification: 220019-Jan-11 [Comments upgraded]
;  Files in this program: cpuidentification.c, cupidentify.asm
;  Status: Done.  The author plans no more modifications.
;  Access: Open source with GNU GPL v3 license

;Purpose
;  Demonstrate to students enrolled in assembly programming classes how to extract information about the processor

;This module
;  File name: cpuidentify.asm
;  Language: X86 with Intel syntax
;  Source code page width: 14 chars
;  Purpose: This program module extracts the need information from the processsor by repeated calls to the cpuid instruction.

;Primary reference: Intel Processor Identification and the CPUID Instruction, Application Note 485, revised May 2012 (App-Note 485).

;Flowchart of program logic:

;Temporary symbols in unicode.
;←  u+2190
;↑  u+2191
;→  u+2192
;↓  u+2193
;   u+e116
;
;
;                         _______
;                        ( Start )
;                         ‾‾‾‾‾‾‾
;                            
;                            
;                   _______________________                  ______________________________
;                   | Is cpuid executable | No | Show message cpuid does not |
;                   | on this computer?   |                 | execute on this computer.   |                 
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 
;                                                                                                                                
;                           Yes                                                                             
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ____________________________                                                            
;                   | Obtain and output vendor |                                                            
;                   | ID string         #5.1.1 |                                                            
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                            
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ______________________________________                                                  
;                   | Obtain and output largest standard |                                                  
;                   | function number             #5.1.1 |                                                  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ______________________________________                                                  
;                   | Obtain and output feature info     |                                                  
;                   | 32-bit integer              #5.1.2 |                                                  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ______________________________________                                                  
;                   | Obtain and output processor        |                                                  
;                   | identification signature  #5.1.2.1 |                                                  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ______________________________________                                                  
;                   | Output largest extended            |                                                  
;                   | function number             #6.2.1 |                                                  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                                                                                                                                
;                   ______________________________________                 _______________________________  
;                   | Is brand string implemented?       | No | Output message Brand string |  
;                   |                                    |                 | not implemented.            |  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾  
;                                                                                                                              
;                           Yes                                                                                 
;                                                                                                                              
;                                                                                                                              
;                                                                                                                              
;                   ______________________________________                                                      
;                   | Output brand string                |                                                      
;                   |                      #6.2.3 & #7.2 |                                                      
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                      
;                                                                                                                              
;                                                                                                                              
;                                                   
;                                                                                                                                
;                   ______________________________________                 _______________________________  
;                   | Is SN implemented?                 | No | Output message SN           |  
;                   |                                 #6 |                 | not implemented             |  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾  
;                                                                                                                              
;                           Yes                                                                                 
;                                                                                                                              
;                                                                                                                              
;                                                                                                                              
;                   ______________________________________                                                      
;                   | Output SN                          |                                                      
;                   |                                 #6 |                                                      
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                      
;                                                                                                                              
;                                                                                                                              
;                                                   
;                                                                                                                                
;                   ______________________________________                 _______________________________  
;                   | Is Brand Id implemented?           | No | Output message Brand        |  
;                   |                                 #7 |                 | Id not implemented          |  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾  
;                                                                                                                              
;                           Yes                                                                                 
;                                                                                                                              
;                                                                                                                              
;                                                                                                                              
;                   ______________________________________                                                      
;                   | Output Brand Id                    |                                                      
;                   |                               #7.1 |                                                      
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                      
;                                                                                                                              
;                                                                                                                              
;                                                   
;                                                                                                                                
;                   ______________________________________                                                  
;                   | Output largest extended            |                                                  
;                   | function number             #6.2.1 |                                                  
;                   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  
;                                                                                                                                
;                            
;                         _______
;                        ( Exit )
;                         ‾‾‾‾‾‾‾









;                                      _______
;                                     ( Start )
;                                      ‾‾‾‾‾‾‾
;                                         │
;                                         │
;                               ______________________                     _______________________________
;                               | Is cpuid executable| ------- No -------> | Show message cpuid does not |--------->│
;                               | on this computer?  |                     | execute on this computer.   |          │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                     ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾          │
;                                        Yes                                                                        │
;                                         │                                                                         │
;                                         │                                                                         │
;                                         │                                                                         │
;                               ________________________________                                                    │
;                               | Compute and show the largest |                                                    │
;                               | standard function number and |                                                    │
;                               | vendor ID. §5.1              |                                                    │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                    │
;                                         │                                                                         │
;                                         │                                                                         │
;                                         │                                                                         │
;                               __________________________________                                                  │
;                               | Compute and show the largest   |                                                  │
;                               | extended function number. §5.2 |                                                  │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                  │
;                                         │                                                                         │
;                                         │                                                                         │
;                                         │                                                                         │
;                               ___________________________                                                         │
;                               | Extract and show serial |                                                         │
;                               | number.  §6.0           |                                                         │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                                         │
;                                         │                                                                         │
;                                         │                                                                         │
;                                         │                                                                         │
;                               ______________________________                   _______________________________    │
;                               | Is brand ID supported?  §7 | ------- No ------>| Output message: Brand ID is |    │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                   | not supported here.         |    │
;                                        Yes                                     ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾    │
;                                         │                                                 │                       │
;                                         │                                                 │                       │
;                                         │                                                 │                       │
;                               ____________________________                                │                       │
;                               | Output brand ID and      |                                │                       │
;                               | processor signature.  §7 |                                │                       │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                │                       │
;                                         │                                                 │                       │
;                                         │_________________________________________________│                       │
;                                         │                                                                         │
;                               _________________________________                 ________________________________  │
;                               | Is brand string supported?    | ------ No ----->| Output message: brand string |  │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                 | not supported.               |  │
;                                         │                                       ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾  │
;                                         │                                                 │                       │
;                                         │                                                 │                       │
;                               ____________________________                                │                       │
;                               | Output brand string      |                                │                       │
;                               | processor signature.     |                                │                       │
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                                │                       │
;                                         │                                                 │                       
;                                         │_________________________________________________│─────────────────────│
;                                         │
;                                         │
;                               __________________
;                               ( Return         )
;                               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾




;Assemble: nasm -f elf64 -l cpuidentify.lis -o cpuidentify.o cpuidentify.asm


;===== Begin code area ============================================================================================================
extern printf                                     ;This function will be linked into the executable by the linker

global processoridentification                    ;Make this program callable by outside functions

segment .data                                     ;Place initialized data in this segment

welcome db "Welcome to CPUID verification", 10, 0
specifierforstringdata db "%s", 0
newline db 10, 0

purpose db "This program will determine if the cpuid instruction may be correctly implemented in the present processor", 10, 0

initialrflags db "The initial value of rflags is %016lx", 10, 0
bit21 db "Bit #21 of rflags is  %01ld", 10, 0
modifiedrflags db "Now the value of rflags is %016lx", 10, 0

cpuidmessage db "Bit #21 has been successfully changed, and therefore the cpuid instruction is implemented on this machine", 10, 0
noncpuidmessage db "Since bit #21 remains unchanged the conclusion is that cpuid is not implemented in this processor.", 10, 0

largeststandarddescription db "The largest standard function number implemented on this machine is %ld", 10, 0
largestextendeddescription db "The largest extended function number implemented on this machine is %ld", 10, 0

vendoridstring db "The Vendor ID of the CPU in this computer is %s", 0
initialprocessorbrandstring db "The Processor Brand in this computer is %s", 0

processorsignature db "The processor signature of the CPU in this computer is %ld", 10, 0
brandidnumber db "The brand id number of the CPU in this computer is %ld", 10, 0

serialnumberinitial db "The serial number of the CPU is %08ld", 0
serialnumbermiddle db "%08ld", 0
serialnumberlast db "%08ld", 10, 0

stringformat db "%s", 0
stringformatwithnewline db "%s", 10, 0


segment .bss                                      ;Place uninitialized data in this segment


segment .text                                     ;Place executable statements in this segment

processoridentification:                          ;Entry point: execution will begin here.

;===== Back up all the registers used in this program module ========================================================================
push       rbp                                    ;Backup the base pointer
pushf                                             ;Backup rflags
push       rdi                                    ;Backup the 1st passing parameter
push       rsi                                    ;Backup the 2nd passing parameter
push       rdx                                    ;Backup the 3rd passing parameter
push       rcx                                    ;Bakcup the 4th passing parameter
push       r15                                    ;Backup r15

mov        r15, [rsp+5*8]                         ;Place a working copy of rflags into r15; rflags is subject to change by later instructions.
                                                  ;Now r15 has a copy of the original data from rflags
;===== Show the welcome message followed by the purpose message =====================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, specifierforstringdata             ;Use format "%s"
mov       rsi, welcome                            ;Show: Welcome to CPUID verification
call      printf                                  ;Use external function to handout the output

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, specifierforstringdata             ;Use format "%s"
mov       rsi, purpose                            ;Show: ... determine if the cpuid instruction may be correctly implemented ...
call      printf                                  ;Use external function to handout the output

;===== Show the initial value of rflags =============================================================================================
;The initial value of rflags was saved in r15

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, initialrflags                      ;Format: %016lx
mov       rsi, r15                                ;Original value from rflags will be printed
call      printf                                  ;Use external function to handout the output

;===== Isolate bit #21 ==============================================================================================================
push       r15                                    ;Save a copy of the original rflags
mov        r14, r15                               ;r14 holds the original data from rflags
shr        r14, 21                                ;Eliminate 21 bits on the right of bit #21, which is now in position 0
and        r14, 1                                 ;Set all bits #79 thru 1 to zero.  Bit #0 remains unchanged.

;===== Show bit #21 =================================================================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, bit21                              ;Format: %01ld
mov       rsi, r14                                ;Bit #21 (now in position #0) is passed to the printf function
call      printf                                  ;Use external function to handout the output

;===== Replace bit #21 with its logical complement ==================================================================================

xor       r15, 0x0000000000200000                 ;By properties of xor bit #21 has been complemented; other bits remain unchanged.
push      r15                                     ;Push the new data for rflags on the stack in order to copy that data to rflags
popf                                              ;Now rflags has the same data as before except bit #23 has flipped

;===== Show the data in rflags to verify visually any changes in bit #21 ============================================================

pushf                                             ;Copy the current data of rflags to the stack
pop       r15                                     ;Copy the current data of rflags to r15
mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, modifiedrflags                     ;Format: %016lx
mov       rsi, r15                                ;Data from the current value of rflags will be outputted
call      printf                                  ;Use external function to handout the output

;===== Output the conclusion ========================================================================================================
;r15 holds the modified data of rflags
pop        r14                                    ;r14 holds the original data of rflags
cmp        r14, r15                               ;Compare the original rflags with the modified rflags
je         notimplemented

;if r14 /= r15 then continue directly below; no jump instruction is needed.

;===== Show message cpuid is implemented ============================================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers       
mov       rdi, specifierforstringdata             ;Format: %s
mov       rsi, cpuidmessage                       ;The cpuid instruction is implemented
call      printf                                  ;Use external function to handout the output

jmp       largeststandardfunctionnumber

;===== Show message cpuid is not implemented ========================================================================================
notimplemented:                                         ;An entry point for a jump instruction

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, specifierforstringdata             ;Format: %s
mov       rsi, noncpuidmessage                    ;The cpuid instruction is not implemented
call      printf                                  ;Use external function to handout the output

jmp       preparetoexit

;===== Find the largest standard function number used by cpuid ======================================================================
largeststandardfunctionnumber:

mov qword rbx, 0                                  ;Zero out this register before cpuid writes to it
mov qword rcx, 0                                  ;Zero out this register before cpuid writes to it
mov qword rdx, 0                                  ;Zero out this register before cpuid writes to it

mov qword rax, 0                                  ;Zero is the input to the cpuid function
cpuid                                             ;Call the function and the return value will be in rax
mov       r15, rax                                ;Store the largest standard function number in r15 for safekeeping.

push      rcx                                     ;Save the last 4 bytes of the Vendor ID
push      rdx                                     ;Save the middle 4 bytes of the Vendor ID
push      rbx                                     ;Save the first 4 bytes of the Vendor ID

;===== Show the largest standard function number used by cpuid ======================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, largeststandarddescription         ;"Largest standard function number ..."
mov       rsi, r15                                ;Place the largest standard function number in the 2nd passing parameter
call      printf                                  ;Use external function to handout the output

;===== Show the vendor ID string ====================================================================================================

;The vendor ID string is in registers rbx, rdx, rcx -- 4 bytes of string in each register using little Endian format
;However, the three registers were pushed onto the integer stack where they are now.  By the nature of a stack the
;little Endian format has been converted to Big Endian format.  All that remains to do is to output the three substrings in 
;succession, and the Vendor ID will have been printed.


mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, vendoridstring
mov       rsi, rsp
call      printf
pop       rbx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rdx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformatwithnewline
mov       rsi, rsp
call      printf
pop       rcx

;===== Obtain and show feature information about this cpu ===========================================================================
;Ref: App-Note 485, section 5.1.2

;This module not yet implemented

;===== Find the largest extended function number used by cpuid ======================================================================

mov       rax, 0x8000000000000000                 ;Ref: Section 5.2 of App-Note 485.  Unresolved issue: why use 0x8000000000000000 and
;                                                 ;not use 0x0000000008000000  ??
cpuid
mov       r15, rax                                ;Copy the largest extended function number to a stable place 

;===== Show the largest extended function number used by cpuid ======================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, largestextendeddescription
mov       rsi, r15
call      printf

;===== Extract and show the Processor Brand string ==================================================================================
;Section 7.2

mov        rax, 0x0000000080000002
cpuid

push      rdx
push      rcx
push      rbx
push      rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, initialprocessorbrandstring
mov       rsi, rsp
call      printf
pop       rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rbx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rcx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rdx

mov       rax, 0x0000000080000003
cpuid

push      rdx
push      rcx
push      rbx
push      rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rbx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rcx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rdx

mov       rax, 0x0000000080000004
cpuid

push      rdx
push      rcx
push      rbx
push      rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rax

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rbx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformat
mov       rsi, rsp
call      printf
pop       rcx

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, stringformatwithnewline
mov       rsi, rsp
call      printf
pop       rdx

;====== Find the processor signature number and brand id number ====================================================================
;This module is intended for those cpus that have not implemented the Brand String method of identification.  Using processor
;signature number and brand id number one can go to tables and find the same information as Brand String.  As a useful exercise
;this program computes processor signature number and brand id number for your general information.  Ref: App-Note 485, p. 17.

mov qword rax, 1
cpuid
mov       r14, rax                                ;Save a copy of the processor signature
mov       r15, rbx                                ;Save a copy of the brand id

;===== Show the processor signature =================================================================================================

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, processorsignature
mov       rsi, r14
call      printf

;===== Show the brand id number =====================================================================================================
;Ref: Chapter 7

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, brandidnumber
mov       rsi, r15
call      printf

;===== Obtain and display the serial number =========================================================================================
;Chapter6

;Testing for support of serial number has not been programmed yet.

mov       rax, 0x0000000000000001
cpuid                                             ;rax now hold the processor signature, which is the first third of the serial number.
mov       r14, rax                                ;Copy first third of the serial number to r14 for safekeeping

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, serialnumberinitial
mov       rsi, r14
call      printf

mov       rax, 0x0000000000000003
cpuid                                             ;rax now hold the processor signature, which is the first third of the serial number.
mov       r14, rdx                                ;Copy middle third of the serial number to r14 for safekeeping
mov       r15, rcx                                ;Copy last third of the serial number to r15 for safekeeping

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, serialnumbermiddle
mov       rsi, r14
call      printf

mov qword rax, 0                                  ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, serialnumberlast
mov       rsi, r15
call      printf
;
;
;
;
;           More development is needed here.
;
;
;
;===== Prepare to exit from this function ===========================================================================================

preparetoexit:                                    ;Entry point for a jump instruction

;===== Restore the values saved earlier to their registers ==========================================================================
pop        r15                                    ;Restore r15
pop        rcx                                    ;Restore rcx
pop        rdx                                    ;Restore rdx
pop        rsi                                    ;Restore rsi
pop        rdi                                    ;Restore rdi
popf                                              ;Restore the original value to rflags
pop        rbp

;===== Send a return value to the caller ============================================================================================
;No special value is required for this program, therefore, we'll choose an arbitrary value to be returned.

mov        rax, -1

ret;                                              ;ret pops the stack taking away 8 bytes

;===== End of function cpuidimplementation ==========================================================================================
