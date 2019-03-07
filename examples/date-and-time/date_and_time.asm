;****************************************************************************************************************************
;Program name: "Date and Time".  This program demonstrates multiple techniques of extracting the date and the time from an  *
;operating system and how to display those value in standard output. Copyright (C) 2019 Floyd Holliday                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Date and Time
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2019-Jan-05
;  Date of last update: 2019-Jan-05
;  Date of reorganization of comments:
;  Files in this program: current-time.c, data_and_time.asm
;  Status: Complete.  There are no user inputs in this program.
;
;This file
;   File name: current-time.c
;   Language: C
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l date_and_time.lis -o date_and_time.o date_and_time.asm


;===== Begin code area ==============================================================================================================
extern printf
extern gettimeofday
global x86datetime

segment .data

welcome db "The function x86datetime has begun executing.", 10, 0
format_tv db "The time elapsed since the epoch is %lu.%06lu seconds (accuracy to nearest microsecond).",10,0
format_tz db "Local location is %d minutes west of UTC and daylight saving time is %d",10,0
format_tv_sys db "Syscall produced: elapsed time since epoch is %lu.%06lu seconds.",10,0
format_tz_sys db "Syscall produced: location is %d minutes west of UTC and daylight saving time is %d",10,0

segment .bss  ; Reserved for uninitialized data

segment .text

x86datetime:

;Prolog
push rbp
mov  rbp,rsp

;Display a welcome message to the viewer.
mov rax, 0            ;A zero in rax means printf uses no data from xmm registers
mov rdi, welcome
call printf

;Get date and time from the system and display them.
;Reference: Ed Jorgensen's book, page 327, SYS_gettimeofday.
;  struct timeval
;         {time_t    tv_sec;   //Seconds
;          suseconds tv_usec;  //Microseconds
;         }
;  struct timezone
;         {int tz_minuteswest;
;          int tz_dsttime;
;         }
;Prototype:  int gettimeofday(struct timeval *,struct timezone *);
;rdi <- struct timeval *
;rsi <- struct timezone *
push qword -1    ;tv_usec = microseconds
push qword -2   ;tv_sec
mov rdi, rsp
push qword -3   ;tz_dsttime
push qword -4   ;tz_minuteswest
mov rsi, rsp
call gettimeofday  ;Function call
mov r14, rdi   ;Back up the pointer in rdi
mov r15, rsi   ;Back up the pointer in rsi

;Output the elapsed seconds with microseconds
mov rax, 0
mov rdi, format_tv
mov rsi, [r14]
mov rdx, [r14+8]
call printf

;Output information about local time zone and use of daylight savings time.
;Note: On the author's 'old' computer used for development time zone information was not updated.
;This need further research to pinpoint the cause of the problem.
mov rax, 0
mov rdi, format_tz
mov rsi, [r15]
mov rdx, [r15+8]
call printf

;Alternative: demonstrate syscall as a replacement for function call.
;Reference: Jorgensen, page 327.
;The input parameters rdi and rsi have already been established in the preceding lines of code.
;However, here we will zero out those earlier results and thereby give credibility to the syscall below.
mov qword [rsp],0
mov qword [rsp+8],0
mov qword [rsp+16],0
mov qword [rsp+24],0
;Set the pointers to be passed to SYS_gettimeofday
mov rdi,rsp
add rdi,16
mov rsi,rsp
mov rax,96                   ;Set the code for coming syscall
syscall                      ;Ask the operating system perform gettimeofday
mov r14, rdi   ;Back up the pointer in rdi
mov r15, rsi   ;Back up the pointer in rsi

;Output the elapsed seconds with microseconds
mov rax, 0
mov rdi, format_tv_sys
mov rsi, [r14]
mov rdx, [r14+8]
call printf

;Output the time zone information.  
;Again: on the author's machine time zone info was not updated.  This need research.
mov rax, 0
mov rdi, format_tz_sys
mov rsi, [r15]
mov rdx, [r15+8]
call printf

;Restore the stack prior to returning control to the calling module.
pop rax
pop rax
pop rax
pop rax
pop rbp               ;Restore the base pointer of the stack frame of the caller.

mov rax, 5            ;long int return number: 0 is the typical return value indicating success.
ret

;========================================================================================
