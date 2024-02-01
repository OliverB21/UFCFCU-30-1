;--------------------------------------------------------
; Name:     add
; In:       firstOperand, secondOperand
; Out:      None, prints result
; Saved:    EAX, ECX
;--------------------------------------------------------
add:
    push eax
    push ecx


    mov eax, [firstOperand]
    add eax, [secondOperand]
    mov ecx, resultMsg
    call printString
    call printInt
    mov ecx, newLine
    call printString

    pop ecx
    pop eax

    jmp notFirstTime

;--------------------------------------------------------
; Name:     sub
; In:       firstOperand, secondOperand
; Out:      None, prints result
; Saved:    EAX, ECX
;--------------------------------------------------------
sub:
    push eax
    push ecx

    mov eax, [firstOperand]
    sub eax, [secondOperand]
    mov ecx, resultMsg
    call printString
    call printInt
    mov ecx, newLine
    call printString

    pop ecx
    pop eax

    jmp notFirstTime

;--------------------------------------------------------
; Name:     mul
; In:       firstOperand, secondOperand
; Out:      None, prints result
; Saved:    EAX, ECX
;--------------------------------------------------------
mul:
    push eax
    push ecx

    mov eax, [firstOperand]
    imul dword [secondOperand]
    mov ecx, resultMsg
    call printString
    call printInt
    mov ecx, newLine
    call printString

    pop ecx
    pop eax

    jmp notFirstTime

;--------------------------------------------------------
; Name:     div
; In:       firstOperand, secondOperand
; Out:      None, prints result
; Saved:    EAX, ECX
;--------------------------------------------------------
div:
    push eax
    push ecx

    mov eax, [firstOperand]
    idiv dword [secondOperand]
    mov ecx, resultMsg
    call printString
    call printInt
    mov ecx, remainderMsg
    call printString
    mov eax, edx
    call printInt
    mov ecx, newLine
    call printString

    pop ecx
    pop eax

    jmp notFirstTime

;--------------------------------------------------------
; Name:     invalidOperator
; In:       None
; Out:      None, prints error message
; Saved:    EAX, ECX
;--------------------------------------------------------
invalidOperator:
    push ecx

    mov ecx, invalidOperatorMsg
    call printString

    pop ecx

    jmp operatorInput
    