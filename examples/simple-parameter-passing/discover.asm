;****************************************************************************************************************************
;Program name: "Simple Parameter Passingn".  This program demonstrates some simple cases of passing data from an X86 moodule*
;to an C module and also to a C++ module. Copyright (C) 2019 Floyd Holliday                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Guadalupe Garcia
;  Author email: gg@hotmail.com
;
;Program name: Simple Parameter Passing
;Programming languages: C (driver), X86 (main algorithm), C++ (swap), C (reverse) 
;Date program began: February 15, 2019
;Date of last update: February 16, 2019
;Files in this program:
;Status: Done.  No more updates will be performed.

;Purpose: This program has only an academic purpose, namely: discover how X86 can call programs with source codes in C and C++, 
;and correctly pass data between caller and called modules.

;This file
;   File name: discover.asm
;   Language: X86
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l discover.lis -o discov.o discover.asm


;===== Begin code area ==============================================================================================================
;;%include "debug.inc"                                      ;Debug tool not used in this program.
extern printf
extern malloc
extern summation
extern swap

global discovery

segment .data

welcome db "FYI: The module discovery, writtten in X86, has begun executing.", 10, "No parameters were received by this asm module", 10, 0

swapmessage db "After calling swap the array now has changed values.",10,0

numbers_in_the_array db "The array contains:",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,0

sumformat db "The sum of some numbers in the array is %ld",10,0

goodbye db "This X86 module will now gently terminate by re-setting rbp to the  bottom of the activation record of the caller",
        db 10, "and automatically popping rsp exactly once.  The popped value goes into rip.", 10, 0

segment .bss  ; Reserved for uninitialized arrays
;Empty

segment .text

discovery:

;===== Backup all the GPRs ========================================================================================================
push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current stack frame
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11: printf often changes r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags
;Registers rax, rip, and rsp are usually not backed up.

;===== Output initial messages ====================================================================================================

mov rax, 0
mov rdi, welcome
call printf


;===== Create an array with slots for seven 8-byte numbers ========================================================================

mov rdi, 56                                                 ;A single unsigned int is passed to malloc
call malloc                                                 ;Create dynamically an array of 7 quadwords.  The name of the array is r15.
mov r15, rax                                                ;Save the pointer returned by malloc in a safe place.


;===== Enter some numeric values in the new array ================================================================================

mov qword [r15+8*0], 14
mov qword [r15+8*1], 7
mov qword [r15+8*2], 23
mov qword [r15+8*3], -1
mov qword [r15+8*4], 0xFFFFFFFFFFFFFFFE
mov qword [r15+8*5], 0xA
mov qword [r15+8*6], -5
;That is nice.  r15 is an array containing 7 rather random odd numbers


;===== Display the contents of the array ==========================================================================================


mov rax, 0
mov rdi, numbers_in_the_array
mov rsi, [r15+8*0]
mov rdx, [r15+8*1]
mov rcx, [r15+8*2]
mov r8,  [r15+8*3]
mov r9,  [r15+8*4]
mov rax, [r15+8*6]
push rax
mov rax, [r15+8*5]
push rax
call printf
pop rax
pop rax


;===== Call the swap function that lives in another file ==========================================================================

;Pass to the called function the addresses of the second and fourth slots in the array.
;We are not passing the entire array to the called function.
;We are not passing the contents of the first and third slots 
;We are passing exactly the addresses of the second and fourth slots of the array.
;Address of first slot:      r15+8*0
;Address of the second slot: r15+8*1
;Address of the third slot:  r15+8*2
;Address of the fourth slot: r15+8*3
;Address of the fifth slot:  r15+8*4
;Address of the sixth slot:  r15+8*5
;Address of the seventh slot:r15+8*6
;We send to the called function the two numbers: r15+8*1 and r15+8*3.

;Begin set up for the function call; exchange the stored values at index 2 and index 4.
mov rax, 0
mov rdi, r15
add rdi, 8
mov rsi, r15
add rsi, 24
call swap


;===== Display the contents of the array ==========================================================================================

mov rax,0
mov rdi,swapmessage
call printf

mov rax, 0
mov rdi, numbers_in_the_array
mov rsi, [r15+8*0]
mov rdx, [r15+8*1]
mov rcx, [r15+8*2]
mov r8,  [r15+8*3]
mov r9,  [r15+8*4]
mov rax, [r15+8*6]
push rax
mov rax, [r15+8*5]
push rax
call printf
pop rax
pop rax


;===== Call an external function that will sum the first n numbers in an integer array ===========================================

;Set up the parameters for calling the summation function
;Prototype:  long summation(long [],long size)
mov rax, 0                                                  ;rax holds the number of xmm registers that will be passsed to the called function
mov rdi, r15                                                ;The pointer to the array is now in rdi
mov rsi, 4                                                  ;4 = first 4 numbers will be summed
call summation
mov r14, rax                                                ;Save the number returned by summation in a safe place


;===== Show the summation number ==================================================================================================

;Set up the parameters for the function call
mov rax, 0                                                  ;rax holds the number of xmm registers that will be passsed to the called function
mov rdi, sumformat                                          ;"The sum of some numbers in the array is %ld\n"
mov rsi, r14                                                ;The sum is now in rdx waiting to be passed to printf
call printf


;===== Time to exit from this X86 module =========================================================================================

mov rax, 0
mov rdi, goodbye                                            ;"This X86 module will now gently terminate by re-setting rbp to ..."
call printf


;===== Select a value to send to the caller ======================================================================================

;What shall we send to the caller?  -99?   +100?   Let's send the starting address of the array.

mov rax, r15


;===== Restore original values to integer registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret


