%include 'functions.asm' ; Include functions.asm file

SECTION .data ; Data section, initialized variables
firstOperandMsg db "Welcome to the calculator. Please enter the first operand: ", 0x
secondOperandMsg db "Please enter the second operand: ", 0x
operatorMsg db "Please enter the operator (+, -, * or /): ", 0x

addSymbol db "+"
subSymbol db "-"
mulSymbol db "*"
divSymbol db "/"

SECTION .bss ; Uninitialized variables
firstOperand resd 1
secondOperand resd 1
operator resd 1

SECTION .text ; Code section

global _start

_start:
    mov eax, firstOperandMsg 
    mov ebx, eax
    call countChars 
    mov ecx, firstOperandMsg 
    call printString 
    mov edx, 1
    mov ecx, firstOperand 
    call getString 

    mov eax, secondOperandMsg
    mov ebx, eax
    call countChars
    mov ecx, secondOperandMsg
    call printString
    mov edx, 1
    mov ecx, secondOperand
    call getString

    mov eax, operatorMsg
    mov ebx, eax
    call countChars
    mov edx, 1
    mov ecx, operatorMsg
    call printString
break1:
    mov ecx, operator
    call getString

    mov edx, 0
    mov dl, byte[operator]
    cmp dl, '+'
    je callAdd
    mov edx, [subSymbol]
    cmp edx, [operator]
    je callSubtract
    mov edx, [mulSymbol]
    cmp edx, [operator]
    je callMultiply
    mov edx, [divSymbol]
    cmp edx, [operator]
    je callDivide

    mov eax, 1
    mov ebx, 4
    int 80x

printResult:
    call countChars
    mov ecx, eax
    mov eax, 4
    mov ebx, 1
    int 80x


    mov eax, 1
    mov ebx, 0
    int 80x

callAdd:
    call add
    jmp printResult

callSubtract:
    call subtract
    jmp printResult

callMultiply:
    call multiply
    jmp printResult

callDivide:
    call divide
    jmp printResult