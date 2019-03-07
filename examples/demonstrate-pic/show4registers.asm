;****************************************************************************************************************************
;Program name: "Demonstrate PIC".  This program shows how to develop code in a PIC environment                              *
;Copyright (C) 2018  Floyd Holliday                                                                                         *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Demonstrate PIC
;  Programming languages: C language (one module), C++(one module), X86 (one module), Bash (one module)
;  Date program began: 2018-Feb-01 
;  Date of last update: 2018-Feb-03
;  Date of reorganization of comments: 2018-Nov-10
;  Files in this program: driver-pic.c, square.cpp, show4registers.asm, r.sh
;  Status: Development is done; no further updates are coming.
;
;Purpose
;  PIC means Position Independent Code.  Beginning in October or November 2017 Linux distro made PIC-enabled object files the default 
;  requirement for the open source linker.  This program will demonstrate how to program in the new PIC environment. 
;
;This file
;  Name: show4registers.asm
;  Language: X86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -l show4registers.lis -o show4registers.o show4registers.asm
;  Max page width: 142 columns
;  Comments begin: column 61
;  Optimal print specification: 142 columns side, monospaced, landscape, 8½x11 paper
;
;;References and credit
;  This module contains common assembly programming statements except for statements using the new PIC techniques.  A example of such a 
;  statement is "call printf wrt ..plt".  The PIC techniques was found by using online search engines.
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Technical note: This assembly module illustrates the use of calling an external function using the "PIC technique".  The two called functions are printf and scanf.
;The programmer must be aware that the call to either of these external functions using the PIC technique requires the 16-byte boundary condition be satisfied. 
;
;
;===== Begin area for source code =========================================================================================================================================

extern printf                                               ;Declare that printf is not defined here: it will be linked in later.
extern scanf

global show4registers                                       ;Make this program callable by modules outside this file.

segment .data                                               ;Place initialized data here

running db "The assembly program is now executing and has received this value from the caller: %ld.",10,0
received_number db "The number received by the assembly program is: %ld",10,0
prompt db "Please enter a floating point number and press enter: ", 0
input_format db "%lf",0
number_format db "You entered this number: 0x%016lx",10,0
output_information_decimal db "Base 10: The square of %1.16lf is %1.16lf",10,0
output_information_hex db "Base 16: The square of 0x%016lx is 0x%016lx",10,0
four_register_format db "The contents of 4 general registers are:",10,"  rdi = 0x%016lx",10,"  rsi = 0x%016lx",10,"  rsp = 0x%016lx",10,"  rbp = 0x%016lx",10,0
good_bye_message db "Good bye.  Enjoy your X86 programming.  This assembly program will return one float number to the caller",10,0

segment .bss                                                ;Place un-initialized data here including arrays.

;This segment is empty.

segment .text                                               ;Place executable instructions in this segment.

show4registers:                                             ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =====================================================================================================

;The next two instructions are here in order to maintain compatibility with other object modules possibly created from other language source code.
push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;Do this to preserve the continuity of the linked list of pointers.
;The next 14 instructions are here simply to back up the remaining GPRs (general purpose registers)
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags

;===== Begin the application here =========================================================================================================================================

;===== Output a message indicating that this X86 program is now executing =================================================================================================
mov rax, 0                                                  ;zero in rax tells printf that no xmm registers are involved.
mov rsi, rdi                                                ;copy the passed in data value to the second parameter of printf
mov rdi, running                                            ;copy the pointer to a string to rdi
call printf wrt ..plt                                       ;call printf using the PIC technique

;===== Output the prompt requesting the input of a float number ===========================================================================================================
mov rax, 0                                                  ;zero in rax tells printf that no xmm registers are involved.
mov rdi, prompt                                             ;copy the pointer to a string to rdi
call printf wrt ..plt                                       ;call printf using the PIC technique

;===== Input the float number from the keyboard ===========================================================================================================================
push qword -1                                                ;push 8 bytes to get on the 16-byte boundary

mov rax, 0                                                  ;zero in rax tells printf that no xmm registers are involved.
push qword -2                                              ;create qword of space for the incoming float number.
mov rdi, input_format                                       ;copy the pointer to a string to rdi
mov rsi, rsp                                                ;the second parameter of scanf must be a pointer to a qword of available space
call scanf wrt ..plt                                        ;call scanf using the PIC technique


;====== Verify the number entered =========================================================================================================================================
mov rax,0                                                   ;zero says that no xmm registers are used
mov rdi,number_format                                       ;copy the pointer to a string to rdi
mov rsi, [rsp]                                              ;copy the value on top of the stack to rsi
call printf wrt ..plt                                       ;call printf using PIC technique

;===== Compute the square of the inputted number ==========================================================================================================================
movsd xmm0, [rsp]                                           ;copy the input number into xmm0
movsd xmm1, xmm0                                            ;copy the input number into xmm1
mulsd xmm1, xmm0                                            ;compute the square and place it into xmm1



;===== Transfer a copy of the computed number to GPRs so that both numbers can be outputted in hex ========================================================================
push qword 1                                                ;create a qword of available space on the stack
push qword 2                                                ;maintain the existing 16-byte boundary
movsd [rsp],xmm1                                            ;copy the squared number to the available space

;===== Output the results in decimal ======================================================================================================================================
mov rax, 2                                                  ;two float numbers will be outputted
mov rdi, output_information_decimal                         ;copy the pointer to a string to rdi
call printf wrt ..plt

;===== Output the results in hex ==========================================================================================================================================
mov rax, 0                                                  ;no float numbers will be outputted
mov rdi, output_information_hex                             ;copy the pointer to a string to rdi
mov rdx,[rsp]                                               ;copy the square of the input into rdx
mov rsi,[rsp+16]                                            ;copy the original inputted number into rsi
call printf wrt ..plt                                       ;call printf using the PIC technique

;===== Output the values in the 4 commonly used general purpose registers =================================================================================================
mov rax, 0                                                  ;no float numbers will be outputted
mov r8,rbp
mov rcx,rsp
mov rdx,rsi
mov rsi,rdi
mov rdi,four_register_format                                ;copy the pointer to a string to rdi
call printf wrt ..plt

;===== Say good-bye =======================================================================================================================================================
;mov rax, 0                                                  ;no float numbers will be outputted
;mov rdi, good_bye_message                                   ;copy the pointer to a string into rdi
;call printf wrt ..plt                                       ;call printf using the PIC technique

;=========== End of application area ======================================================================================================================================

;The caller is expecting to receive a double (64-bit float).  Pick a number, say 8.0 = 0x4020000000000000, to send back to the caller.
mov rax,0x4020000000000000
push rax
movsd xmm0,[rsp]                                            ;copy 8.0 into xmm0
pop rax                                                     ;restore the stack to its former status before the most recent push

;=========== Remove stuff on the system stack that accumulated during the execution of this X86 module ====================================================================
pop rax                                                     ;Reverse the instruction "push qword 2"
pop rax                                                     ;Reverse the instruction "push qword 1"
pop rax                                                     ;Reverse the instruction "push qword -2"
pop rax                                                     ;Reverse the instruction "push qword -1"

;=========== Restore GPR values and return to the caller ==================================================================================================================
popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

ret

;========== End of subprogram show4registers ==============================================================================================================================

;Programming footnote: Some authors and some websites use the following assembly instruction
;    lea rdi, [rel good_bye_message]
;in place of
;    mov rdi, good_bye_message
;where good_bye_message could be any string defined in the .data section.  This program uses the second type of instruction.  Both appear to create the same outcome.
