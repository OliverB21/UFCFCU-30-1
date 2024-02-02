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
    jc likelyoverflow
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
    jc likelyoverflow
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
    jc likelyoverflow
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
    jc likelyoverflow
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

;--------------------------------------------------------
; Name:     likelyoverflow
; In:       None
; Out:      None, prints error message
; Saved:    ECX
;--------------------------------------------------------
likelyoverflow:
    push ecx

    mov ecx, likelyOverflowMsg
    call printString
    mov ecx, newLine
    call printString

    pop ecx

    ret

;--------------------------------------------------------
; Name:     cleanexit
; In:       None
; Out:      None, exits program
; Saved:    None
;--------------------------------------------------------
cleanexit:
    mov eax, 1
    mov ebx, 0
    int 0x80