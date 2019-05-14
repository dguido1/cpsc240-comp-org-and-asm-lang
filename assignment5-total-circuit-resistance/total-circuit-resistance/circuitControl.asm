; Author name: David Guido
; Program title: Total Circuit Resistance
; Course number: CPSC 240
; Assignment number: 5
;
; Names of files in this program:
;   1. circuitDriver.cpp
;   2. circuitControl.asm    (THIS FILE)
;   3. run.sh
;
; Status: Complete
; Date of last modification: May 13, 2019
; ********************************************

    extern printf           ; Global / external function declarations.
    extern scanf
    global circuitController

segment .data               ; Messages.
    purposeMsg db "This program will compute the resistance of a circuit configured with parallel sub-circuits.", 10, 0
    promptMsg db "Enter the resistance of a circuit: ", 0
    countMsg db "Thank you. The number of sub-circuits is %1ld", 10, 0
    resistanceMsg db "The total resistance in this system is R = ", 0
    ohmsMsg db " OHM's.", 10, 0
    returnToCallMsg db "Thank you for using ECP.  The total resistance will now be returned to the driver program.", 10, 0

    floatIOFormat db "%lf", 0      ; Formatting.
    strIOFormat db "%s", 0
    blankLine db "", 10, 0

    zeroFloat dq 0.0                ; Float constants.
    oneFloat dq 1.0


segment .bss            ; Dynamic, uninitialized. (Not being used in this module).


segment .text           ; Start of executable instructions.
circuitController:      ; Entry point.

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

    push qword 0                ; Reserve 8 bytes of storage.

    mov qword rax, 0            ; Display Purpose Message: 
    mov rdi, strIOFormat            ; "This program will compute the resistance of
    mov rsi, purposeMsg             ;  a circuit configured with parallel sub-circuits."
    call printf

    mov qword rax, 0            ; Display Blank Line.
    mov rdi, strIOFormat
    mov rsi, blankLine
    call printf

    mov r15, 0                  ; Set (input-count) register to 0.
    movsd xmm13, [zeroFloat]    ; Move a constant quadword-float into the xmm13 register.
                                

inputLoop:                  ; Loop, allowing for user-input of resistance values.
    mov qword rax, 0            ; Display Prompt Message:
    mov rdi, strIOFormat            ;  "Enter the resistance of a circuit: "
    mov rsi, promptMsg
    call printf

    push qword 0                ; User-input.
    mov qword  rax, 0
    mov rdi, floatIOFormat
    mov rsi, rsp                    ; Reserved storage PTR --> scanf.
    call scanf

    cdqe            ; EAX (32-bit): Sign extend integer into 
                    ; the full extent of RAX (64-bit).
    cmp rax, -1             ; Compare input with value of the  <CTRL+Enter>  command.
    je loopComplete         ; Jump to the top of inputLoop, if (input != <CTRL+Enter>).

    movsd xmm15, [rsp]     ; xmm15 = Input
    pop rax                ; Free any storage occupied by scanf.
                                ; Calulate Reciprocal.
    movsd xmm14, [oneFloat]         ; xmm14 = 1.0
    divsd xmm14, xmm15              ; xmm14 /= Input
    addsd xmm13, xmm14              ; xmm13 += xmm14

    inc r15                         ; r15 += 1
    jmp inputLoop           ; Jump to the start of inputLoop.


loopComplete:
    pop rax                 ; Remove last push from loop.
    pop rax                 ; Remove 0 value --> Now off boundry.

    mov qword  rax, 0            ; Display Blank Line.
    mov rdi, strIOFormat
    mov rsi, blankLine
    call printf

    mov qword  rax, 0            ; Display Blank Line.
    mov rdi, strIOFormat
    mov rsi, blankLine
    call printf

    mov qword  rax, 0           ; Display Count Message:
    mov  rdi, countMsg              ; "Thank you. The number of sub-circuits is "
    mov rsi, r15
    call printf
        
    mov qword  rax, 0            ; Display Blank Line.
    mov rdi, strIOFormat
    mov rsi, blankLine
    call printf

    mov rax, 0                  ; Display Resistance Message:
    mov rdi, strIOFormat            ; "The total resistance in this system is R = "
    mov rsi, resistanceMsg
    call printf

    movsd xmm14, [oneFloat]     ; xmm14  =  1.0
    divsd xmm14, xmm13          ; xmm14 /=  xmm13     --> xmm14 = [ 1 / (Sum of Reciprocal's) ]

    movsd xmm0, xmm14           ; Display total resistance value.
    mov rax, 1
    mov rdi, floatIOFormat
    call printf

    mov rdi, strIOFormat        ; Display OHM's Message:
    mov rsi, ohmsMsg                ; " OHM's."
    mov rax, 0
    call printf

    mov qword  rax, 0            ; Display Blank Line.
    mov rdi, strIOFormat
    mov rsi, blankLine
    call printf

    mov rax, 0                  ; Display Retun to Call Message:
    mov rdi, strIOFormat            ; "Thank you for using ECP.  The total resistance will now be
    mov rsi, returnToCallMsg        ;  returned to the driver program."
    call printf

    movsd xmm0, xmm14       ; Move total resistance value into xmm0 for return to caller (driver) function.

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
    ret     ; Return to caller funtion.