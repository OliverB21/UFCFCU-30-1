
getString: ; Takes a string from the user and stores it in the memory location defined by ecx, and size defined by edx
    mov eax, 3 ; Syscall register
    mov ebx, 0 ; Defines standard input
    int 80x ; Kernel call
    ret ; Returns to main

countChars: ; Counts the number of characters in eax, and stores it in edx, Set ebx = eax
    cmp byte [eax], 0 ; Checks if the current character is the end fo the string (null)
    jz finished ; If so, jump to "finished"
    inc eax ; Otherwise, increment eax
    jmp countChars ; Continue looping

finished:
    sub eax, ebx ; eax now contains the number of characters in the string
    ret ; Returns to main

printString: ; Assumes message is stored in ecx
    mov edx, eax ; Assumes the length of the string has been calculated using countChars and moves it to edx
    mov eax, 4 ; Syscall for output
    mov ebx, 1 ; Defines standard output
    int 80x ; Kernel call
    ret ; Returns to main