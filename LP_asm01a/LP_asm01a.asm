.586														; система команд (процессор Pentium)
.model flat, stdcall										; модель памяти(плоская), соглашение о вызовах

getmin PROTO :DWORD, :DWORD									; прототип функции
getmax PROTO :DWORD, :DWORD									; прототип функции

.code

getmin PROC elem :DWORD, count :DWORD
	mov esi, elem          
    mov ecx, count
    mov eax, [esi]
	
FINDMIN:
	cmp [esi], eax
	jl FINISH
	jmp NEXT

FINISH:
	mov eax, [esi]

NEXT:
	add esi, 4
	loop FINDMIN
	ret          
getmin ENDP


getmax PROC elem :DWORD, count :DWORD
	mov esi, elem          
    mov ecx, count
    mov eax, [esi]
	
FINDMAX:
	cmp [esi], eax
	jg FINISH												;if [esi] > eax goto finish
	jmp NEXT

FINISH:
	mov eax, [esi]

NEXT:
	add esi, 4
	loop FINDMAX
	ret          
getmax ENDP

END