;****************************************************************************************************************************
;Program name: "Discover Op Codes".  This program provides a foundation where the user can easily search in the object code *
;to find codes for operator and operands, and find endianess.  Copyright (C) 2018  Floyd Holliday                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Discover Op Codes
;  Programming languages: One module in C++ and one in X86.
;  Date program began: 2017-Dec-01
;  Date of last update: 2018-Apr-30
;  Files in this program: opcode.cpp, discovery.asm, r.sh
;
;Purpose
;  The intent of this program is to provide a platform where users can reverse engineer instructions at the binary level.  Look at
;  the .lis file and make educated guesses as to what the opcode is for any operation.  Students of assembly programming should
;  experiment with changing an opcode in the executable file.
;
;This file:
;  FIle name: discovery.asm
;  Language: X86-64
;  Max page width: 132 columns
;  Comments begin column 61
;  Status: This program was tested more than 7 times on Debian9.3.0 (Dec 2017) without issues.
;  Assemble: nasm -f elf64 -l opcode.lis -o opcode.o opcode.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf

extern scanf

global discover

segment .data

welcome db "Welcome to the Discover Program", 10, 0
integersum db "The sum of %ld and %ld is %ld.", 10, 0
integersubtraction db "The difference of %ld minus %ld is %ld.", 10, 0
integermultiplication db "The product of %ld times %ld is %ld (least significant bits only).", 10, 0
integerdivision db "The quotient of %ld divided by %ld is %ld with a remainder %ld.",10,0
flagmessage db "The value in rflags is 0x%016lx which equals %ld.",10,0
overflowmessage db "The sum of %ld and %ld is %ld.",10,0

segment .bss

segment .text

discover:

;===== Perform standard update of the two points into the system stack ============================================================

push rbp
mov rbp, rsp

;===== Do some extra backups.  Some of these are unnecessary but we do them anyway ================================================

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
push -99

mov rax, 0
mov rdi, welcome
call printf

;===== Add two integers in registers ==============================================================================================

mov r10, 12
push r10        ;Keep a backup copy of r10
mov r11, 9
add r10, r11

mov rax, 0
mov rdi, integersum
mov rcx, r10
mov rdx, r11
pop rsi
call printf

;===== Add two integers: one in a register and one in memory (stack) ==============================================================

mov qword rdx, 107
push rdx              ;Keep a backup copy of the first integer
push qword 121
add rdx, [rsp]

mov rax, 0
mov rdi, integersum
mov rcx, rdx
pop rdx
pop rsi
call printf

;===== Subtract one integer from another: both integers are in registers ==========================================================

mov r10, 44
push r10      ;Keep a back up copy
mov r11, 12
sub r10, r11

mov qword rax, 0
mov rdi, integersubtraction
pop rsi
mov rdx, r11
mov rcx, r10
call printf

;===== Subtract two integers: first one in a register and the second one in memory ================================================

push qword 9
mov r8, 12
push r8                            ;Keep a backup copy of "12"
sub r8, [rsp+8]

mov rax, 0
mov rdi, integersubtraction        ;"The difference of %ld minus %ld is %ld."
mov rcx, r8
pop rsi
pop rdx
call printf

;===== Multiply two integers: first one in a register and the second one in memory ================================================

mov qword rax, 3500
push rax                           ;Keep a backup copy of rax
push qword 700
imul qword [rsp]

mov rdi,integermultiplication
mov rcx,rax
pop rsi
pop rdx
mov rax,0
call printf

;===== Divide one integer by another: both integers are in registers ==============================================================

mov r14, 87    ;Numerator
mov r15, 11    ;Divisor
mov rax, r14
cqo
idiv r15

mov rdi, integerdivision
mov rsi, r14
mov r8, rdx
mov rdx, r15
mov rcx, rax
mov qword rax, 0
call printf

;===== What happens when an integer operation overflows ===========================================================================

pushf
mov rax, 0
mov rdi, flagmessage
pop rsi
mov rdx, rsi
call printf

mov r8, 0x7ffffffffffffff4
mov r9, 0x7ffffffffffffffc
push r9                   ;backup r9
add r9, r8
pushf                     ;push rflags

mov rax, 0
mov rdi, overflowmessage
mov rsi, r8
mov rdx, [rsp+8]
mov rcx, r9
call printf

mov rax, 0
mov rdi, flagmessage
pop rsi                   ;pop rflags
mov rdx, rsi
call printf
pop rax                   ;remove r9 from stack

;===== Meaningless instructions placed here just to see what the assembler does with then =========================================

mov rbx, r15
mov rbx, r14
mov rbx, r13
mov rcx, r15
mov rcx, r14
mov rcx, r13
mov rdx, rdi
mov rdi, rsi
mov rsi, r8
mov rsi, r9
mov rsi, r10
add rbx, rcx
add rbx, rdx
add rbx, rdi
add r15, rcx
add r15, rdx
add r15, rdi
add r15, rsi
mov rax, 0x1122               ;2-byte immediate operand
mov rax, 0x11223344           ;4-byte immediate operand
mov rax, 0x1122334455667788   ;8-byte immediate operand

;===== Restore all the registers backed up at the start of this function ==========================================================

pop rax    ;Remove the junk number
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
;End of the discover function =====================================================================================================

