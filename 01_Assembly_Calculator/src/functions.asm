;--------------------------------------------------------
; Name:     countCharsInString
; In:       ECX = Pointer to string
; Out:      ECX = Number of characters in string
; Saved:    EBX, EDX
;--------------------------------------------------------
countCharsInString: ; Counts the characters in the string stored in ECX, stores the value in ECX
    push ebx ; Save EBX
    push edx ; Save EDX

    mov edx, 0 ; Zero EDX
    mov ebx, ecx ; Copy ECX to EBX

    .countLoop:
    cmp byte [ecx], 0 ; Check if the current character is the null terminator
    je .countEnd ; If so, end the loop
    inc ecx ; If not, Increment ECX
    jmp .countLoop ; Continue the loop

    .countEnd:
    sub ecx, ebx ; Subtract the original pointer from the current pointer to get the number of characters
    pop edx ; Restore EDX
    pop ebx ; Restore EBX
    ret ; Return to main

;--------------------------------------------------------
; Name:     printString
; In:       ECX = Pointer to string
; Out:      Nothing
; Saved:    EAX, EBX, ECX, EDX
;--------------------------------------------------------
printString: ; Prints the string stored in ECX
    push eax ; Save EAX
    push ebx ; Save EBX
    push edx ; Save EDX
    push ecx ; Save ECX

    call countCharsInString ; Call countCharsInString to get the number of characters in the string
    
    mov edx, ecx ; Copy ECX to EDX
    pop ecx ; Restore ECX

    mov eax, 4 ; Set EAX to 4 (sys_write)
    mov ebx, 1 ; Set EBX to 1 (stdout)

    int 0x80 ; Call the kernel

    pop edx ; Restore EDX
    pop ebx ; Restore EBX
    pop eax ; Restore EAX

    ret

;--------------------------------------------------------
; Name:     getUserInput
; In:       ECX = Pointer to memory location to store input
; Out:      memory location pointed to by ECX = User input
; Saved:    EAX, EBX, ECX, EDX
;--------------------------------------------------------
getUserInput:
    push eax ; Save EAX
    push ebx ; Save EBX
    push ecx ; Save ECX
    push edx ; Save EDX

    mov eax, 3 ; Set EAX to 3 (sys_read)
    mov ebx, 0 ; Set EBX to 0 (stdin)
    mov edx, 127 ; Set EDX to 127 (max number of bytes to read)
    int 0x80 ; Call the kernel

    mov byte[ecx + eax], 0 ; Set the last byte to 0 (null terminator)

    pop edx ; Restore EDX
    pop ecx ; Restore ECX
    pop ebx ; Restore EBX
    pop eax ; Restore EAX

    ret ; Return to main

;--------------------------------------------------------
; Name:     strtoint
; In:       ECX = Pointer to string
; Out:      EAX = Integer value of string
; Saved:    EBX, ECX, EDX
;--------------------------------------------------------
strtoint: ; Converts the string pointed to in ECX to an integer, stores the value in EAX
    push ebx ; Save EBX
    push edx ; Save EDX
    push ecx ; Save ECX

    mov edx, ecx ; Copy ECX to EDX
    mov eax, 0 ; Zero EAX

    call checkstrcanbeint ; Call checkstrcanbeint to check if the string can be converted to an integer

    .convertLoop:
    movzx ecx, byte [edx] ; Copy the current character to ECX
    inc edx ; Increment EDX
    cmp ecx, 0x30 ; Check if the character is less than '0'
    jl .convertEnd ; If so, end the loop
    cmp ecx, 0x39 ; Check if the character is greater than '9'
    jg .convertEnd; If so, end the loop
    sub ecx, 0x30 ; Subtract '0' from the character to get the integer value
    imul eax, 10 ; Multiply EAX by 10
    add eax, ecx ; Add the integer value of the character to EAX
    jmp .convertLoop ; Continue the loop

    .convertEnd:
    pop ecx ; Restore ECX
    pop edx ; Restore EDX
    pop ebx ; Restore EBX
    ret ; Return to main
;--------------------------------------------------------
; Name:     inttostr
; In:       EAX = Integer value
; Out:      None - prints int
; Saved:    EAX, EBX, ECX, EDX, ESI
;--------------------------------------------------------
printInt:
    push eax ; Save EAX
    push ebx ; Save EBX
    push ecx ; Save ECX
    push edx ; Save EDX
    push esi ; Save ESI

    mov ebx, 0 ; Zero ECX

    .divloop:
    inc ebx ; Increment ECX
    mov edx, 0 ; Zero EDX
    mov esi, 10 ; Set ESI to 10
    div esi ; Divide EAX by ESI
    add edx, 0x30 ; Add '0' to EDX
    push edx ; Push EDX to the stack
    cmp eax, 0 ; Check if EAX is 0
    jne .divloop ; If not, continue the loop

    .printloop:
    dec ebx ; Decrement ECX
    mov ecx, esp ; Moves the stack pointer ready to be printed

    call printString ; Call printString to print the string
    pop eax ; Pop the value from the stack to move ESP forward
    cmp ebx, 0 ; Check if ECX is 0
    jnz .printloop ; If not, continue the loop

    pop esi ; Restore ESI
    pop edx ; Restore EDX
    pop ecx ; Restore ECX
    pop ebx ; Restore EBX
    pop eax ; Restore EAX
    ret ; Return to main
;--------------------------------------------------------
; Name:     checkstrcanbeint
; In:       ECX = Pointer to string
; Out:      None, error is returned if string cannot be converted to int. Also checks for exit code
; Saved:    EBX, ECX, EDX
;--------------------------------------------------------
checkstrcanbeint: ; Checks if the string pointed to in ECX can be converted to an integer
    push ebx ; Save EBX
    push edx ; Save EDX
    push ecx ; Save ECX

    mov edx, ecx ; Copy ECX to EDX

    .checkLoop:
    movzx ecx, byte [edx] ; Copy the current character to ECX
    inc edx ; Increment EDX
    cmp ecx, 0x21 ; Check if the character is '!'
    je cleanexit ; If so, exit the program
    cmp ecx, 0x0 ; Check if the current character is the null terminator
    je .checkend ; If so, end the loop
    cmp ecx, 0x0A  ; Check if the character is a new line
    je .checkend ; If so, end the loop
    cmp ecx, 0x30 ; Check if the character is less than '0'
    jl .checkError ; If so, throw an error
    cmp ecx, 0x39 ; Check if the character is greater than '9'
    jg .checkError ; If so, throw an error
    jmp .checkLoop ; Continue the loop

    .checkError:
    mov ecx, invalidOperandMsg ; Set ECX to the invalid operand message
    call printString ; Call printString to print the message
    call clearregisters ; Call clearregisters to clear the registers
    jmp notFirstTime ; Jump to notFirstTime to continue the loop

    .checkend:
    pop ecx ; Restore ECX
    pop edx ; Restore EDX
    pop ebx ; Restore EBX
    ret ; Return to main

;--------------------------------------------------------
; Name:     clearregisters
; In:       None
; Out:      None
; Saved:    None
;--------------------------------------------------------
clearregisters: ; Checks if the string pointed to in ECX can be converted to an integer

    xor eax, eax ; Zero EAX
    xor ebx, ebx ; Zero EBX
    xor ecx, ecx ; Zero ECX
    xor edx, edx ; Zero EDX

    mov [firstOperand], eax ; Zero firstOperand
    mov [secondOperand], eax ; Zero secondOperand
    mov [operator], eax ; Zero operator

    ret ; Return to main

;--------------------------------------------------------
; Name:     checkdividebyzero
; In:       None
; Out:      None, error is returned if = 0
; Saved:    EAX
;--------------------------------------------------------
checkdividebyzero:
    push eax ; Save EAX

    mov eax, [secondOperand] ; Copy secondOperand to EAX
    cmp eax, 0 ; Check if EAX is 0
    je divideByZero ; If so, jump to divideByZero

    pop eax ; Restore EAX
    ret ; Return to main

    divideByZero:
    mov ecx, divisionByZeroMsg ; Set ECX to the divide by zero message
    call printString ; Call printString to print the message
    call clearregisters ; Call clearregisters to clear the registers
    jmp notFirstTime ; Jump to notFirstTime to continue the loop