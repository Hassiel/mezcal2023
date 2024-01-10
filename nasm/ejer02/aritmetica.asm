section .data
	msg1 db "La suma de 5+4 es: ", 0xA, 0xD
	len1 equ $ - msg1
	msg2 db "La resta es de 5-4 es: ", 0xA, 0xD
	len2 equ $ - msg2

section .bss
	result resb 1

section .text
	global _start

_start:
	mov eax, 4	; llama al sistema (sys_write)
	mov ebx, 1	; stdout

	mov ecx, msg1	; msg1 a la pantalla
	mov edx, len1	; longitud del mensaje
	int 0x80	; llama al sistema de interrupciones

	;Suma
	mov eax, 5
	mov ebx, 4
	add eax, ebx
	add eax, "0"
	mov [result], eax
	; Impresion del resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, result
	mov edx, 1
	int 0x80

	;Resta
	mov eax, 4	; llama al sistema (sys_write)
	mov ebx, 1	; stdout
	mov ecx, msg2
	mov edx, len2
	int 0x80
	mov eax, 5
	mov ebx, 4
	sub eax, ebx
	add eax, "0"
	mov [result], eax
	;Impresion del resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, result
	mov edx, 1
	int 0x80


	;Finalizacion del programa
	mov eax, 1	;(systemctl("pause"), exit, sys_exit)
	int 0x80
