section .data
    userMsg db "Dame un numero: ", 0xA, 0xD
    userMsgLen equ $ - userMsg
    incMsg db "Su incremento es: ", 0xA, 0xD
    incMsgLen equ $ - incMsg
    decMsg db "Su decremento es: ", 0xA, 0xD
    decMsgLen equ $ - decMsg

section .bss
    num resb 5
    incNum resb 5
    decNum resb 5

section .text
    global _start

_start:
    ; Imprimir mensaje para ingresar número
    mov eax, 4
    mov ebx, 1
    mov ecx, userMsg
    mov edx, userMsgLen
    int 0x80

    ; Leer número desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 5
    int 0x80

    ; Convertir de ASCII a entero
    movzx eax, byte [num]  ; Usa movzx para evitar sign extension
    sub eax, '0'

    ; Calcular incremento
    inc eax
    mov [incNum], al  ; Almacena el resultado en incNum
    add byte [incNum], '0' ; Convertir de nuevo a ASCII

    ; Calcular decremento
    dec eax
    dec eax
    mov [decNum], al  ; Almacena el resultado en decNum
    add byte [decNum], '0' ; Convertir de nuevo a ASCII

    ; Imprimir mensaje de incremento
    mov eax, 4
    mov ebx, 1
    mov ecx, incMsg
    mov edx, incMsgLen
    int 0x80

    ; Imprimir número incrementado
    mov eax, 4
    mov ebx, 1
    mov ecx, incNum
    mov edx, 1  ; Modificado para imprimir solo un carácter
    int 0x80

    ; Imprimir mensaje de decremento
    mov eax, 4
    mov ebx, 1
    mov ecx, decMsg
    mov edx, decMsgLen
    int 0x80

    ; Imprimir número decrementado
    mov eax, 4
    mov ebx, 1
    mov ecx, decNum
    mov edx, 1  ; Modificado para imprimir solo un carácter
    int 0x80

    ; Finalizar programa
    mov eax, 1
    int 0x80

