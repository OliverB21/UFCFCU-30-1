; ADD, SUB, MULT, DIV Operation Functions
; The ADD function is commented to describe the process
; All functions aside from DIV use the same steps aside from line commented

add:
    ; Store number inputs 1 and 2 into registers al and bl (8 bit char)
    mov eax, [num1]
    mov ebx, [num2]

    ; Converts the two ASCII inputs to decimal integers
    sub eax, '0'
    sub ebx, '0'

    ; Adds the two decimal integers together, result is stored in al
    add eax, ebx

    ; Converts the result in al from decimal back to ASCII so it can be printed
    add eax, '0'

    ; Moves/stores the value in the al register to memory location label 'result'
    mov [result], eax

    ; System call for printing the result message
    mov eax, 4
    mov ebx, 1
    mov ecx, resultsmsg
    mov edx, lresultsmsg
    int 80h

    ; System call for printing the actual result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 10
    int 80h

    ; Jumps/branches to the quit function
    jmp quit


sub:
    mov eax, [num1]
    mov ebx, [num2]

    sub eax, '0'
    sub ebx, '0'

    sub eax, ebx ; subtraction takes place here

    add eax, '0'

    mov [result], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, resultsmsg
    mov edx, lresultsmsg
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 10
    int 80h

    jmp quit

multiply:
    mov eax, [num1]
    mov ebx, [num2]

    sub eax, '0'
    sub ebx, '0'

    mul ebx ; Multiplication takes place here

    add eax, '0'

    mov [result], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, resultsmsg
    mov edx, lresultsmsg
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 10

    jmp quit

division:
    mov eax, [num1]
    mov ebx, [num2]

    sub eax, '0'
    sub ebx, '0'

    idiv dword ebx ; Division takes place here

    add eax, '0'

    mov [result], eax
    

    mov eax, 4
    mov ebx, 1
    mov ecx, resultsmsg
    mov edx, lresultsmsg
    int 80h

    

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

    jmp quit

invalid:
    push ecx

    mov ecx, invalidopsmsg
    mov edx, linvalidopsmsg
    call printString

    jmp inputquery1