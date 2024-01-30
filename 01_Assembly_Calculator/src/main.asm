; TODO: 
; Receive 3 arguments from the user
; Store and check each of these arguments
; If the arguments are valid, call the correct function based on the operand argument
; Output the result to the user
SECTION .data

errormsg db 'Incorrect number of arguments passed', 0x

SECTION .text

global _start

_start:
    
    pop ecx ; Store the number of arguments in ecx
    cmp ecx, 4 ; Check if there are 3 arguments (3 arguments + program name)
    jne error ; If not, jump to error

    call exit ; Otherwise, exit the program

error:
    mov eax, 4 ; System call for write
    mov ebx, 1 ; File descriptor 1 - standard output
    mov ecx, errormsg ; Address of the string to output
    mov edx, 36 ; Number of characters in message
    int 0x80 ; Call the kernel

    mov eax, 1 ; System call for exit
    mov ebx, 1 ; Exit with return code 1
    int 0x80 ; Call the kernel

exit:
    mov eax, 1 ; System call for exit
    mov ebx, 0 ; Exit with return code 0
    int 0x80 ; Call the kernel

