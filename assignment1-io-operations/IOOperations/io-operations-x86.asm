; Author name: David Guido
; Program title:  IO Operations
; Files in this program:  IOOperations.c,  io-operations-x86.asm, run.sh
; Course number:  CPSC 240
; Assignment number: 1
; Required delivery date:  Feb 4, 2019 before 11:59pm
; Purpose: Learn how to embed C library function calls in an X86 module.
; Language of this module:  X86 with Intel syntax
;
; *********************************************************
;
; *** Module Commands for YASM Assembler & GNU Compiler *** 
; Remove Old Files: 
;   rm *.out, rm *.lst, rm *.o
; Assemble:
;   yasm -f elf64 -l io-operations-x86.lst -o io-operations-x86.o io-operations-x86.asm
; Link:
;   gcc -c -m64 -o IOOperations.o IOOperations.c
; Complile:
;   gcc -m64 -fno-pie -no-pie -o operations IOOperations.o io-operations-x86.o
; Load Process:
;   ./operations
; Run from .sh:
;   chmod +x /Desktop/4/IOOperations/run.sh
;   ./yourscript.sh

section .data                   ; Define standard constants
    SYS_exit equ 60             ; Terminate
    EXIT_SUCCESS equ 0          ; Success code

    inputMsg1: db "Please enter the first integer: ", 0    ; Define strings
    inputMsg2: db "Please enter the second integer: ", 0

    productMsg: db "The product of these two integers is: %d", 10, 0              ; %d: printf's (signed) 
    quotientMsg: db "The quotient of the first divided by the second is %d ", 0   ;     decimal int format

    remainderMsg: db "with remainder %d", 10, 0
    remainderRetMsg: db "This assembly function will now return the remainder to the driver.", 10, 0

    msg1Len: equ $-inputMsg1          ; Define const string sizes
    msg2Len: equ $-inputMsg2
    msg3Len: equ $-productMsg
    msg4Len: equ $-quotientMsg
    msg5Len: equ $-remainderMsg
    msg6Len: equ $-remainderRetMsg
    
    formatIntIO: db "%d", 0       ; Define (int) printf & scanf format    
    formatStrIO: db "%s", 0       ; Define (string) printf & scanf format 

    intInput1: times 4 dw 0       ; Double word, 32-bit integer, 4 bytes
    intInput2: times 4 dw 0 
    mulResult: times 4 dw 0       ; --> DW can be signed or unsigned int 
    divResult: times 4 dw 0       ;     when communicating with a .c file
    divRemainder: times 4 dw 0    

section .text
    global main                   ; Include programs start function
    extern printWelcomeMsg        ; Include custom (IOOperations.c) functions
    extern sendRemainder 
    extern scanf                  ; Include C-Library functions
    extern printf
 
main:  
    call _handleIOOperations      ; Call function to perform user input & output operations
    call _handleArithmetic        ; Call function to perform required arithmetic computation

    mov rax, SYS_exit             ; System EXIT call
    mov rdi, EXIT_SUCCESS         ; Return EXIT SUCCESS status

    syscall                       ; syscall: Pause the current process, transfer control to the OS, perfrom rax service
    ret                           ; ret:     Return from a function, pop stack into rip register, jump to post call line

_handleIOOperations:
    call printWelcomeMsg          ; Call function to print welcome message
    call _printInputMsg1          ; Call function to display first input instruction to the user
    
    mov rdi, formatIntIO          ; Move required (int) printf & scanf format string into rdi, param #1 
    mov rsi, intInput1            ; Move first double word (32b integer) input into rdi, param #2 
    mov al, 0
    call scanf                    ; Read in first user defined int input
                                  ; --> scanf("string format", numberToScan);
    call _printInputMsg2          ; Call function to display second input instruction to the user
 
    mov rdi, formatIntIO          ; Move required (int) printf & scanf format string into rdi, param #1 
    mov rsi, intInput2            ; Move second double word (32b integer) input into rdi, param #2 
    mov al, 0
    call scanf                    ; Read in second user defined int input
                                  ; --> scanf("string format", numberToScan);
    syscall
    ret

_handleArithmetic:
    call _handleMultiplication    ; Call function to perform required multiplication computation
    call _handleDivision          ; Call function to perform required division computation
    call _printRemainderRetMsg    ; Call function to print message, notifying the user that div remainder is being return to .c file
    call _sendRemainderToDriver   ; Call function to pass div remainder to .c file

    syscall
    ret

_handleMultiplication:
    mov eax, dword [intInput1]     ; Move the value of intInput1 into LH operand: eax
    mov edx, dword [intInput2]     ; Move the value of intInput2 into RH operand: ebx
    
    imul eax, edx                  ; Signed multiplication, result in eax
    mov dword [mulResult], eax     ; Move eax into mulResult, eax = edx:eax * dNumB,  (Product Result)

    call _printProductMsg          ; Call funtion to print the resulting products value 

    syscall
    ret

_handleDivision:                    ; Note: Double-word division, 64-bits allocated in (edx:eax)
    mov eax, dword [intInput1]      ;   Move the value of intInput1 into LH operand: eax
    mov ebx, dword [intInput2]      ;   Move the value of intInput2 into RH operand: ebx
    mov rdx, 0                      ;   BOTH (mov, rdx 0) & (cdq) are required
    cdq         ; eax → edx:eax        --> OR unexpected result from concatenation
                                    ;       of 64b (32b + 32b) edx:eax reg
    idiv ebx    ; eax = edx:eax/dNumB

    mov dword [divResult], eax      ; Move eax into divResult,    eax = edx:eax / dNumB,  (Quotient Result)
    mov dword [divRemainder], edx   ; Move edx into divRemainder, edx = edx:eax % dNumB,  (Remainder Result)

    call _printQuotientMsg          ; Call funtion to print the resulting quotients value 
    call _printRemainderMsg         ; Call funtion to print the resulting remainders value 
   
    syscall
    ret

_sendRemainderToDriver:
    mov edi, dword [divRemainder]   ; Move divRemainder into edi, (rdi) --> (edi) --> etc is first parameter passed
    call sendRemainder              ; Send Remainder to .c file to verify the resulting div remainders value 

    syscall
    ret

_printInputMsg1:    
    mov ebx, inputMsg1           ; Move first user input instructions into ebx
    mov rdi, formatStrIO         ; Move required (str) printf & scanf format string into rdi, param #1   
    mov esi, ebx                 ; Move ebx into esi, param #2 
    xor eax, eax                 ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself      
    call printf                  ; Print first input instructions to the screen
                                 ; --> printf("string of (str) format", msgToPrint);
    syscall
    ret

_printInputMsg2:    
    mov ebx, inputMsg2           ; Move second user input instructions into ebx                  
    mov rdi, formatStrIO         ; Move required (str) printf & scanf format string into rdi, param #1    
    mov esi, ebx                 ; Move ebx into esi, param #2 
    xor eax, eax                 ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself            
    call printf                  ; Print first input instructions to the screen
                                 ; --> printf("string of (str) format", msgToPrint);

    syscall
    ret

_printProductMsg:    
    mov ebx, dword [mulResult]   ; Move multiplication result into ebx
    mov rdi, productMsg          ; Move product message w/ required (int) printf & scanf format string into rdi, param #1   
    mov esi, ebx                 ; Move ebx into esi, param #2 
    xor eax, eax                 ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself    
    call printf                  ; Print multiplication result to the screen
                                 ; --> printf("string of (int) format", numberToPrint);
    syscall
    ret    

_printQuotientMsg:    
    mov ebx, dword [divResult]   ; Move quotient result into ebx
    mov rdi, quotientMsg         ; Move quotient message w/ required (int) printf & scanf format string into rdi, param #1  
    mov esi, ebx                 ; Move ebx into esi, param #2 
    xor eax, eax                 ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself   
    call printf                  ; Print quotient result to the screen
                                 ; --> printf("string of (int) format", numberToPrint);
    syscall
    ret 

_printRemainderMsg:                
    mov ebx, dword [divRemainder]  ; Move div remainder result into ebx
    mov rdi, remainderMsg          ; Move remainder message w/ required (int) printf & scanf format string into rdi, param #1  
    mov esi, ebx                   ; Move ebx into esi, param #2 
    xor eax, eax                   ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself 
    call printf                    ; Print remainder result to the screen
                                   ; --> printf("string of (int) format", numberToPrint);
    syscall
    ret 

_printRemainderRetMsg:
    mov ebx, remainderRetMsg     ; Move div remainder return message into ebx      
    mov rdi, formatStrIO         ; Move required (str) printf & scanf format string into rdi, param #1    
    mov esi, ebx                 ; Move ebx into esi, param #2 
    xor eax, eax                 ; Are A and B not equal, if (A != B) return 1, set ax to zero since ax is always equal to itself   
    call printf                  ; Print first input instructions to the screen
                                 ; --> printf("string of (str) format", msgToPrint);
    syscall
    ret 