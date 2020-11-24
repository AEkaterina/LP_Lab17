.586														
.model flat, stdcall										
includelib kernel32.lib										
includelib "..\Debug\LP_asm01a.lib"                         

ExitProcess PROTO: DWORD									
GetStdHandle PROTO: DWORD									; получить handle вывода на консоль 
															
WriteConsoleA PROTO: DWORD,: DWORD,: DWORD,: DWORD,: DWORD	; вывод на консоль
SetConsoleTitleA PROTO: DWORD								; прототип ф-ии устанавливающей заголовок консольного окна (функция стандартная)

getmin PROTO :DWORD, :DWORD
getmax PROTO :DWORD, :DWORD

.stack 4096

.const
	array			sdword		-1, 25, 23, -4, 2, 5, 3, -31, 16, 27
	consoleTitle	byte		'LP_asm01', 0               ; строка, первый элемент данные + нулевой бит
	mes 			byte		'getmax-getmin = ', 0		; строка для вывода ответа						
	handleOutput	sdword		-11					        ; код на запрос разрешения вывода в консоль	    

.data
	consoleHandle dword 0h		                        ; состояние консоли							
	max sdword ?
	min sdword ?
	result sdword ?
	resultString byte 4 dup(0)

.code

int_to_char PROC uses eax ebx ecx edi esi,		
							  pstr: dword,  ; адрес строки результат
						  intfield: sdword  ; преобразуемое число
    mov edi, pstr                           ; адрес результата в -> edi
    mov esi, 0			            ; количество символов в результате						
    mov eax, intfield								
    cdq								; преобразование 2го слова в учетверенное копирование знакового бита регистра eax на все биты регистра edx						
    mov ebx, 10                     ; десятичная система счисления
    idiv ebx						; aex = eax/ebx, остаток -> edx					
    test eax, 80000000h				; результат отрицательный ?							
    jz plus							; если результат предыдущей команды 0, т.е.положительный то на plus							
    neg eax							; eax = -eax			
    neg edx                         ; edx = -edx
    mov cl, '-'                     ; первый символ результата '-'
    mov[edi], cl
    inc edi							; ++edi							
plus:
    push dx                         ; остаток -> стек
    inc esi                         ; ++esi
    test eax, eax					; eax == 0?							
    jz fin                          ; если да то на fin
    cdq                             ; знак распространили с eax на edx
    idiv ebx                        ; aex = eax/ebx, остаток -> edx
    jmp plus
fin:
    mov ecx ,esi                    ; количество ненулевых остатков = количеству символов в результате
write:
    pop bx							; остаток из стека -> bx							
    add bl,'0'                      ; сформировали символ в bl
    mov[edi], bl                    ; bl-> в результат
    inc edi                         ; edi++
    loop write                      ; if (--ecx) > 0 goto write
    ret
int_to_char ENDP

main PROC
	INVOKE SetConsoleTitleA, offset consoleTitle		; вызываем функцию устанвки заголовка окна
	INVOKE GetStdHandle,handleOutput			        ; вызываем ф-ию проверки разрешения на вывод
	mov consoleHandle, eax						        ; копируем полученное разрешение из регистра eax
    INVOKE getmin, offset array,lengthof array
    mov min, eax
    INVOKE getmax, offset array,lengthof array
    sub eax, min
	mov result, eax
	INVOKE WriteConsoleA, consoleHandle, offset mes, sizeof mes, 0, 0	    ;max-min						
    INVOKE int_to_char, offset resultString, result	                        ;рез.в символьную строку
	INVOKE WriteConsoleA, consoleHandle, offset resultString, sizeof resultString, 0, 0			;пишем рез-т
	INVOKE ExitProcess,0
main ENDP
end main   