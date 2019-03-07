;****************************************************************************************************************************
;Program name: "Pointer and Reference".  This program provides a foundation where the user can easily search in the object  *
;code to find codes for operator and operands, and find endianess.  Copyright (C) 2018  Floyd Holliday                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Pointer and Reference
;  Programming languages: One module in C++ and one in X86.
;  Date program began: 2018-May-09
;  Date of last update: 2018-May-09
;
;Purpose
;  The intent of this program is to investigate what happens when a pointer is passed to a subprogram in comparison with what happens when a reference is passed to a
;  subprogram.
;
;Project information
;  Project files: pointer_ref.cpp, merchandise.asm
;  Status: In development
;
;Translator information
;  Linux: nasm -f elf64 -l merchandise.lis -o merchandise.o merchandise.asm
;
;References and credits
;  Pointers, References, and Dynamic Memory by Chua Hock Chuan posted at https://www.ntu.edu.sg/home/ehchua/programming/cpp/cp4_PointerReference.html
;
;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;
;Functional prototypes of this assembly program
;  double compute_total_via_reference_x86(double &,double &);
;  double compute_total_via_pointers_x86(double *,double *);
;
;Assertion to be validated.  A reference variable and a pointer variable are structurally the same.  
;  Plan: Call this x86 function two times as follows:
;  In the first call the C++ function sends two reference variables and the x86 treats them as ordinary pointers.  The result of the calculations is 
;         returned to the caller
;  In the second call the C++ function sends two genuine pointer variables to this same program.  The result is identical to the first call.  This is strong 
;         evidence in support of the assertion.
;  Outcome: It does not matter if the caller sends a pointer or a reference to this x86 function.  The numeric outcome is the same.
;
;An interesting side fact: A reference variable is declared and initialized in C++ like this.
;         double f = 3.75;        //f is an ordinary variable holding 3.75
;         double & g = f;         //g is a reference variable pointing to 3.75
;  Both f and g are scalar variables, and therefore, they will be stored in the stack region of runtime space.  However, the contents of g will be the address 
;  of f.  We, therefore, say that "g points to 3.75", and we also say that "f holds 3.75".  Running this program colaborates these statements. 
;
;
;There are differences between a pointer and a reference.  Those differences lie in the statements C++ uses to act on each type.  As far as assembly programming
;goes the kinds of variables are the same.
; 
;For further information about how C++ declares and uses pointers and references see the comprehensive description by Chua Hock Chuan referenced above.
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
extern printf

extern scanf

global compute_total_via_reference_x86
global compute_total_via_pointers_x86

segment .data

welcome db "Welcome to the Pointer and Reference Program", 10, 0
incoming_parameters db "Parameter rdi is %016lx and rsi is %016lx",10,0

segment .bss

segment .text

;Two entry points.  This function may be called by either of two names.
compute_total_via_reference_x86:
compute_total_via_pointers_x86:

;===== Perform standard update of the two points into the system stack ====================================================================================================

push rbp
mov rbp, rsp

;===== Do some extra backups.  Some of these are unnecessary but we do them anyway ========================================================================================

push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

mov rax, 0
mov rdi, welcome
call printf

;===== Show the values passed in via rdi and rsi ==========================================================================================================================

mov rax, 0
mov rdi, incoming_parameters
mov rsi, [rsp+10*8]
mov rdx, [rsp+9*8]
call printf

;===== Compute the total amount due =======================================================================================================================================

mov rax, [rsp+10*8]
movsd xmm0, [rax]                                           ;xmm0 contains pre-tax price
mov rax, [rsp+9*8]
movsd xmm1, [rax]                                           ;xmm1 contains the tax rate
mov rax, 0x3FF0000000000000                                 ;copy 1.0 into rax
push rax                                                    ;push 1.0 onto the stack
movsd xmm2, [rsp]                                           ;xmm2 contains 1.0
pop rax                                                     ;reverse the push two instructions earlier
addsd xmm1,xmm2                                             ;xmm1 contains 1.0 + pretax price
mulsd xmm0,xmm1                                             ;xmm0 contains the amount due

;===== Restore all the registers backed up at the start of this function ==================================================================================================

popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx

pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the discover function =============================================================================================================================================

