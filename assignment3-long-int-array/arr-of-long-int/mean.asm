; Author name: David Guido
; Program title: arr-of-long-int
; Course number: CPSC 240
; Assignment number: 3
;
; Names of files in this program:
;   1. driverMain.cpp
;   2. control.asm
;   3. squares.cpp
;   4. display.c
;   5. mean.asm    (THIS FILE)
;   6. run.sh
;
; Program purpose: 
;   1  Declare an array 
;   2  Pass data to a subprogram
;   3  Convert an integer to a numerically equal floating point number
;   4  Pass a float number to another function
;   5  Use a GPR register in the role of index to an array.
;
; Status: Complete
; Date of last modification: May 13, 2019
; ********************************************

    extern printf       ; External / global funtions.
    extern scanf
    global calculateMean

segment .data                       ; Initialized data.
    floatIOFormat db "%f", 10, 0    ; Formating.
    strIOFormat db "%s", 0
    dmlIOFormat db "%ld", 10, 0

    mean_output db "The mean of those numbers is: ", 0      ; Message(s).

segment .bss    ; Un-initialized data.
segment .text   ; Start of executable instructions.

calculateMean:   ; Entry point.
; ********************************************
    push rbp          ; Back-up registers.
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
; ********************************************

                        ; Array:
    mov r14, rdi            ; rdi --> r14

    mov r13, rsi            ; Array size:
    mov r15, rsi            ; rsi --> r13, r15

    mov r8, 0               ; Sum of user-inputed integer (decimal) array.


summationLoop:           ; Calulate sum of array:
    cmp r13, 0              ; (arraySize == 0)
    je loopComplete         ; --> Jump if true.

    add r8, [r14]           ; Add current array value to r8.
    dec r13                 ; Decrement the loop/array index counter.
    add r14, 8              ; Increment (move forard) to the next array position.
    jmp summationLoop            ; Jump to the top of this loop.


loopComplete:               ; Decimal --> floating point convertion:
    cvtsi2sd xmm3, r8           ; Sum to double (float).
    cvtsi2sd xmm4, r15          ; Size to double (float). 

    divsd xmm3, xmm4        ; FP Division (mean in xmm3).

    movsd xmm0, xmm3        ; Mean value from xmm3 --> xmm0 
                            ; for return to the calling function.
                        
; ********************************************
    popf           ; Restore registers.
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

; ********************************************
    ret     ; Return to calling funtion.