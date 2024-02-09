; ........................................................... 
; Assembly Calculator (ADD | DIV | SUB | MULT)                
; Leo Collins
; Compiled with nasm -f elf CalculatorMain.asm
; Link with ld -m elf_i386 CalculatorMain.o -o CalculatorMain
; Run with: ./CalculationMain
; ...........................................................

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

    invalidopsmsg db 'The operator is invalid. Please enter a number 1-4.', 0
    linvalidopsmsg equ $ - invalidopsmsg


section .bss
    ; Initialises a certain amount of memory space for input/output values that have not been stored yet
    num1: resb 10
    num2: resb 10
    opnum: resb 10
    result: resb 10


section .text

    global  _start

_start:

; Label for start of main program loop

main:

    ; Calls input queries to present menu options + take user input of operation and specified numbers.
    call inputquery1
    call inputquery2

checkop:

    ; Checks the user operator input (1-4) and jumps to respective function.
    cmp byte [opnum], '1'
    je add
    cmp byte [opnum], '2'
    je sub
    cmp byte [opnum], '3'
    je multiply
    cmp byte [opnum], '4'
    je division

    ; If the program does not jump, an invalid character has been entered, so the 'invalid' function is called.
    call invalid


exit:

    ; Calls clean quit function
    call quit
