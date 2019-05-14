; Author name: David Guido
; Program title: arr-of-long-int
; Course number: CPSC 240
; Assignment number: 3
;
; Names of files in this program:
;   1. driverMain.cpp
;   2. control.asm    (THIS FILE)
;   3. squares.cpp
;   4. display.c
;   5. mean.asm
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

    extern display          ; Global / external function declarations.
    extern calculateMean
    extern printf                                              
    extern scanf
    extern squares                                    
    global control            


segment .data    
    dmlIOFormat db "%ld", 0       ; Formatting.
    strIOFormat db "%s", 0

    msg1 db "The control module has begun.", 10, 0                    ; Messages.
    msg2 db "Instructions: Enter a sequence of integers.", 10, 0
    msg3 db "To terminate press ‘Enter’ followed by Control+D.", 10, 0 
    msg4 db "Here are the data as received:", 10, 0 
    msg5 db "Here are the squares of the data:", 10, 0 
    msg6 db "The control module is now returning to the caller module. Bye.", 10, 0 
    resultMsg1 db "The mean of these %ld numbers is %lf", 10, 0 

    currentVal dq 0     ; Temp input space.

segment .bss         
    intArray resq 65  ; 65 element quad array


segment .text                                              
control:    ; Entry point.

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

    mov r14, intArray        ; Array.
    mov r15, 0               ; Array size.

  ; ************************************************************
    mov qword rax, 0        ; Message Output 1: "The control module has begun."
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, msg1                ; Load in the first instruction message, rsi: Default param #2 
    call printf                  ; C Library function
        
    mov qword rax, 0        ; Message Output 2: "Instructions: Enter a sequence of integers."
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, msg2                ; Load in the first instruction message, rsi: Default param #2 
    call printf                  ; C Library function

    mov qword rax, 0        ;  Message Output 3: "To terminate press ‘Enter’ followed by Control+D."
    mov rdi, strIOFormat         ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, msg3                ; Load in the first instruction message, rsi: Default param #2 
    call printf                  ; C Library function
  ; ************************************************************

inputLoop:                    ; User input:  
    mov rdi, dmlIOFormat      ; Load in scanf/printf signed int I/O format, rdi: Default param #1
    mov rsi, currentVal          ; Load the current loop iterations user input value, rsi: Default param #2
    call scanf                   ; C Library function

                              ; Check conditions:
    cdq                          ; rdx = The sign-extension of that 32-bit number
    shl rdx, 32                  ; Move sign extension 32 bits to the left
    or rax, rdx                  ; rax = rax OR rdx
    cmp rax, -1                  ; Check for CTRL + ENTER, (-1) input
    je loopComplete             

    mov rcx, qword [currentVal]   ; Move the current input value into rcx.
    mov qword [r14+r15*8], rcx    ; Move the current input value from rcx into the array position.

    inc r15                       ; Increment the array count register.
    jmp inputLoop             ; Jump back to the top of this loop.


loopComplete:   
    mov qword rax, 0            ;  Message Output 4: 
    mov rdi, strIOFormat            ; "Here are the data as received"
    mov rsi, msg4        
    call printf 
                                ; Display array to console. 
    mov rdi, r14                    ; Array.
    mov rsi, r15                    ; Array count.
    mov qword rax, 0 
    call display
                                ; Calculate mean.
    mov rdi, r14                    ; Pass array.
    mov rsi, r15                    ; Pass array size.
    call calculateMean
                                ; Print mean. "The mean of these __ numbers is __"
    movsd xmm15, xmm0               ; Resilt in xmm0 --> Save temp in xmm15  .. (xmm0 through xmm7) volotile.
    mov rax, 1                      ; Assembler will now look in xmm0.
    mov rdi, resultMsg1             ; Mean result message.
    mov rsi, r15                    ; Array size.
    call printf
                                ; Calculate squares.
    mov rdi, r14                    ; Pass array.
    mov rsi, r15                    ; Pass array size.
    call squares
                                ;  Message Output 5: 
    mov qword rax, 0                ; "Here are the squares of the data"
    mov rdi, strIOFormat
    mov rsi, msg5       
    call printf 
                                ; Display array of squares to console. 
    mov rdi, r14                    ; Array of squares.
    mov rsi, r15                    ; Arr size.
    call display
                                ;  Message Output 6: 
    mov qword rax, 0                ; "The control module is now returning to the caller module. Bye."
    mov rdi, strIOFormat
    mov rsi, msg6
    call printf    

    movsd xmm0, xmm15     ; Move original mean value from xmm15 back to xmm0 for return to caller funtion.


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


    ret     ; Return to calling funtion.