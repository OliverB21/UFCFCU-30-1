%include 'functions.asm'
%include 'operators.asm' ; Includes functions from seperate files

SECTION .data ; Data section for initialized data
firstOperandMsgNew db "Welcome to the calculator. Please enter the first operand (or ! to exit): ", 0x0

firstOperandMsg db "Please enter the first operand (or ! to exit): ", 0x0
secondOperandMsg db "Please enter the second operand: ", 0x0
operatorMsg db "Please enter the operator (+, -, * or /): ", 0x0

resultMsg db "The result is: ", 0x0
remainderMsg db ", with a remainder of ", 0x0

invalidOperandMsg db "Invalid operand. Operation Cancelled", 0x0
invalidOperatorMsg db "Invalid operator. Please enter a valid operator (+, -, * or /): ", 0x0
likelyOverflowMsg db "Likely overflow. Proceed with caution", 0x0
divisionByZeroMsg db "Division by zero. Operation Cancelled", 0x0

newLine db 0xA, 0xD, 0x0 ; New line character

SECTION .bss ; BSS section for uninitialized data
firstOperand resd 1
secondOperand resd 1
operator resd 1

SECTION .text ; Code section

global _start

_start:
    mov ecx, firstOperandMsgNew ; Move the address of the firstOperandMsgNew to ecx
    jmp anyTime ; Jump to anyTime

notFirstTime:
    mov ecx, newLine
    call printString
    mov ecx, firstOperandMsg ; Move the address of the firstOperandMsg to ecx

anyTime:
    
    call printString ; Call the printString function to print the message
    mov ecx, firstOperand ; Move the address of the firstOperand variable to ecx
oper1:
    call getUserInput ; Call the getUserInput function to get the user's first operand
    call strtoint ; Call the strtoint function to convert the user's input to an integer
    mov [firstOperand], eax ; Move the integer to the firstOperand variable

    mov ecx, secondOperandMsg ; Move the address of the secondOperandMsg to ecx
    call printString ; Call the printString function to print the message
oper2:
    mov ecx, secondOperand ; Move the address of the secondOperand variable to ecx
    call getUserInput ; Call the getUserInput function to get the user's second operand
    call strtoint ; Call the strtoint function to convert the user's input to an integer
    mov [secondOperand], eax ; Move the integer to the secondOperand variable

    mov ecx, operatorMsg ; Move the address of the operatorMsg to ecx
    call printString ; Call the printString function to print the message
operatorInput:
    mov ecx, operator ; Move the address of the operator variable to ecx
    call getUserInput ; Call the getUserInput function to get the user's operator

checkOperator:
    cmp byte [operator], '+'
    je add
    cmp byte [operator], '-'
    je sub
    cmp byte [operator], '*'
    je mul
    cmp byte [operator], '/'
    call checkdividebyzero
    je div
    cmp byte [operator], '!'
    je cleanexit
    call invalidOperator
