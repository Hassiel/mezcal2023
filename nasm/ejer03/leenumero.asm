section .data
	userMsg1 db "ingrese un numero: ", 0xA,0xD
	len1 equ $ - userMsg1
	userMsg2 db "ingrese el numero 2: " , 0xA, 0xD
	len2 equ $ - userMsg2
	dispRes db "[] resultdo de la suma es: ", 0xA, 0xD
	len3 equ $ - dispRes

section .bss
	num1 resb   5
	num2 resb  5
	res resb 5

section .text
	global _start

_start:
	; Impresion del userMsg1
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg1
	mov edx, len1
	int 0x80

	;Lectura desde el teclado
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	mov edx, 5
	int 0x80

	;Printing el userMsg2
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg2
	mov edx, len2
	int 0x80

	; Reading num2
	mov eax, 3
	mov ebx, 2
	mov ecx, num2
	mov edx, 5
	int 0x80

	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov [res], eax

	; Printing result message
	mov eax, 4
	mov ebx, 1
	mov ecx, dispRes
	mov edx, len3
	int 0x80

	;Printing add result
	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 5
	int 0x80

	;Closing programa

mov eax, 1
int 0x80
