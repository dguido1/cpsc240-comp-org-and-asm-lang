;******************************************************************************************************************
;******************************************************************************************************************
;
; Author name: David Guido
; Program name: End of Transmission
; Names of files in this programming:
;   1. EndOfTransmission.c
;   2. end-of-transmission-x86.asm
;   3. run.sh
; Course number: CPSC 240
; Scheduled delivery date: February 18, 2019
; Program purpose: 
;   1. The implementation of a loop in X86
;   2. The use of Control+D to signal the end of a sequence of data.
;   3. The summation of numerical data in an accumulator
; Status: Complete
; Date of last modification: Feb 11, 2019
;
;******************************************************************************************************************

section .data  ; Pointer identifiers --> Point to ascii strings within heap space            
    
    ; String console output
    startMsg db "The fast accumulator program written in X86 Intel language has begun.", 10, 0
    instrMsg1 db "Instructions: Enter a sequence of integers. Include white space between each number.", 10, 0
    instrMsg2 db "To terminate press ‘Enter’ followed by Control+D.", 10, 0
    countMsg db "Thank you. You have entered %d numbers with a sum equal to ", 0
    returnMsg db "The X86 function will now return the sum to the caller program. Bye.", 10, 0
    enterInputMsg db "Enter an integer: ", 0
    sumMsg db "%d", 0

    ; Standard IO format for string & signed int
    strIOFormat db "%s", 0
    sgnIntIOFormat db "%d", 0
    
    ; New line & period
    periodMsg db ".", 0
    newLineMsg db "", 10, 0

    ; Used to compute sum of all inputed values
    currentVal dq 0
    sumOfInput dq 0

;******************************************************************************************************************

section .bss  ; Uninitialized Data --> Not used in this assignment 

;******************************************************************************************************************

section .text                    ; External Library References:
    extern scanf                 ; Simplified input using C library
    extern printf                ; Simplified output using C library
    global accumulateSumOfInput  ; global to call from .cpp function

; Main Function
accumulateSumOfInput:
    call printStartMsg           ; Function to print a message stating that the program is starting
    call printInstrMsg           ; Function to print an instruction messages
    
    mov r15, 0                   ; Initialize register input counter to 0
    call summationLoop

    call printInputResults       ; Function to print count & sum of inputed values
    call printReturnMsg          ; Function to print confirmation that both the sum return value 
                                 ; & instructions are being passed back to .cpp function 
    mov rax, qword [sumOfInput]  ; Load final sum value into rax for retun back to .cpp module
    ret    
                                 ; Loop to: A: Input 64 bit integer numbers, then end w/ input of CTRL + ENTER
summationLoop:                   ;          B: Compute sum of all inputed values
    call printEnterInputMsg      ; Function to print 'Enter an integer: ' each loop iteration
    
    ; User input:
    mov rdi, sgnIntIOFormat      ; Load in scanf/printf signed int I/O format, rdi: Default param #1
    mov rsi, currentVal          ; Load the current loop iterations user input value, rsi: Default param #2
    call scanf                   ; C Library function
    
    ; Check conditions:
    cdq                          ; rdx = The sign-extension of that 32-bit number
    shl rdx, 32                  ; Move sign extension 32 bits to the left
    or rax, rdx                  ; rax = rax OR rdx
    cmp rax, -1                  ; Check for CTRL + ENTER, (-1) input
    je loopComplete              ; if (rax == -1) --> exit to 'loopComplete' label

    ; Add to input sum
    mov rcx, qword [currentVal]  ; rcx = User inputed value of current loop iteration
    add qword [sumOfInput], rcx  ; Add this value to the sum of all inputs

    ; Repeat
    inc r15                      ; Increment input (loop) counter
    jmp summationLoop            ; Move to the top of summationLoop to start execution

loopComplete:                    ; Loop exited with an input of (-1)
    ret                          ; Return to accumulateSumOfInput

printStartMsg:
    mov qword rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, startMsg            ; Load in the start message, rsi: Default param #2 
    call printf                  ; C Library function

    ret                          ; Return to accumulateSumOfInput                        

printInstrMsg:
    call printInstrMsg1          ; Function to print the first instruction message
    call printInstrMsg2          ; Function to print the second instruction message
    ret                          ; Return to accumulateSumOfInput   

printInstrMsg1:
    mov qword rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, instrMsg1           ; Load in the first instruction message, rsi: Default param #2 
    call printf                  ; C Library function
    
    ret                          ; Return to printInstrMsg   

printInstrMsg2:
    mov qword rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, instrMsg2           ; Load in the second instruction message, rsi: Default param #2 
    call printf                  ; C Library function
    
    ret                          ; Return to printInstrMsg   

printEnterInputMsg:
    mov qword rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, enterInputMsg       ; Load in the enter input message, rsi: Default param #2 
    call printf                  ; C Library function

    ret                          ; Return to summationLoop   

printInputResults:
    call printNewLine            ; Function to print a new line message
    call printInputCount         ; Function to print an input count message
    call printInputSum           ; Function to print an input sum message
    call printPeriod             ; Function to print a period message
    call printNewLine            ; Function to print a new line message

    ret                          ; Return to accumulateSumOfInput   

printNewLine:
    mov rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, newLineMsg          ; Load in the new line message, rsi: Default param #2
    call printf                  ; C Library function

    ret                          ; Return to printInputResults

printPeriod:
    mov rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, periodMsg           ; Load in the period message, rsi: Default param #2
    call printf                  ; C Library function

    ret   

printInputCount:
    mov qword  rax, 0
    mov rdi, countMsg            ; Load in count message, rsi: Default param #1
    mov rsi, r15                 ; Load in the count value, rsi: Default param #2 
    call printf                  ; C Library function

    ret                          ; Return to printInputResults   

printInputSum:
    mov qword rax, 0
    mov rdi, sumMsg              ; Load in sum message, rsi: Default param #1
    mov rsi, qword [sumOfInput]  ; Load in the sum value, rsi: Default param #2 
    call printf                  ; C Library function

    ret                          ; Return to printInputResults   

printReturnMsg:
    mov rax, 0
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, returnMsg           ; Load in the return message, rsi: Default param #2 
    call printf                  ; C Library function

    ret                          ; Return to accumulateSumOfInput   

;******************************************************************************************************************
;******************************************************************************************************************