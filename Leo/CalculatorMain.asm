; Assembly Calculator (ADD | DIV | SUB | MULT)
; Leo Collins
; Compiled with nasm -f elf CalculatorMain.asm
; Link with ld -m elf_i386 calculator.o -o calculator
; Run with: ./calculator

%include 'CalculatorFunctions.asm' ; Imports functions from file
%include 'OperatorFunction.asm' ; Imports operator functions from file 

section .data
    
    ; Initializes memory labels to store messages output to the console
    num1msg db 'Please enter number 1: ', 0
    lnum1msg equ $ - num1msg

    num2msg db 'Please enter number 2: ', 0
    lnum2msg equ $ - num2msg

    addmsg db '1 = Add', 10 0
    laddmsg equ $ - addmsg

    submsg db '2 = Sub', 10, 0
    lsubmsg equ $ - submsg
    
    multmsg db '3 = Multiply', 10, 0
    lmultmsg equ $ - multmsg

    divmsg db '4 = Divide', 10, 0
    ldivmsg equ $ - divmsg

    opsmsg db 'Please enter an operation (1-4): ', 0
    lopsmsg equ $ - opsmsg

    resultsmsg db 'The result is: ', 0
    lresultsmsg equ $ - resultsmsg


section .bss
    ; Initialises a certain amount of memory space for input/output values that have not been stored yet
    num1: resb 10
    num2: resb 10
    result: resb 10


section .text

    global  _start
 


_start:

main:
    
    call inputquery1
exit:
    call quit
