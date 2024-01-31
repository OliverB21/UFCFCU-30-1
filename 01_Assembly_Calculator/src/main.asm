%include 'functions.asm'

SECTION .data
msg1 db "Welcome to the calculator. Please enter an expression in the format <int><operator><int>. Valid operators are +, -, * and /. : ", 0x

SECTION .bss
inputExp resb 255

SECTION .text

global _start

_start:
    mov eax, msg1 
    mov ebx, eax ; Stores the memory address of the welcome message in ebx and eax ready to count and print
    call countChars ; COunts the characters in the welcome message, stores in eax
    mov ecx, msg1 ; Stores the memory address of the welcome message in ecx ready to print
    call printString ; Prints the welcome message using the counted characters
    mov ecx, inputExp ; Moves the location of the inputExp variable into ecx ready to store the user input
    call getString ; Gets the user's input and stores it in ecx

    mov eax, 1
    mov ebx, 0
    int 80x