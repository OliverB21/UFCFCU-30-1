; Reset + Exit Program function
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret

; ASCII to Int function to take user input
atoi:
    push ebx 
    push ecx
    push edx ; Preserves all 3 values by pushing them to the stack while function runs
    mov esi, eax ; Moves memory address pointer for the number we want to convert stored in eax to esi 
    mov eax, 0 
    mov ecx, 0 ; Initialises with decimal 0

printString:
    ; ECX - Pointer to string
    ; EDX - Length of string

    push eax
    push ebx
    push ecx
    push edx

    mov eax, 4
    mov ebx, 1
    
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

userInput:
    ; ECX - Pointer to the mem location we want to store the input at

    push eax
    push ebx
    push ecx
    push edx

    mov eax, 3
    mov ebx, 0
    mov edx, 127

    int 0x80

    ; EAX - Length of the input

    mov byte[ecx + eax], 0

    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

inputquery1:

    mov ecx, multmsg
    mov edx, lmultmsg 
    call printString

    mov ecx, addmsg
    mov edx, laddmsg
    call printString

    mov ecx, submsg
    mov edx, lsubmsg
    call printString

    mov ecx, divmsg
    mov edx, ldivmsg
    call printString

    mov ecx, opsmsg
    mov edx, lopsmsg
    call printString

    mov ecx, num1
    call userInput
