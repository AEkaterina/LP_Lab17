.586														; система команд (процессор Pentium)
.model flat, stdcall										; модель памяти(плоская), соглашение о вызовах
includelib kernel32.lib										; компановщику: компоновать с kernel32
ExitProcess PROTO: DWORD									; прототип функции для завершения процесса Windows 

.stack 4096

.const
	array sdword -1, 25, 23, -4, 2, 5, 3, -31, 16, 27

.data
	min sdword ?

.code

getmin PROC elem :DWORD, count :DWORD
	mov esi, elem          
    mov ecx, count											;счетчик цикла
    mov eax, [esi]											;1 элемент
	
FINDMIN:
	cmp [esi], eax
	jl FINISH												;if [esi] < eax goto finish
	jmp NEXT												;goto next

FINISH:
	mov eax, [esi]

NEXT:
	add esi, 4
	loop FINDMIN											;цикл
	ret          
getmin ENDP

main PROC													; точка входа main
    INVOKE getmin, offset array, lengthof array				; вызов процедуры getmin
    mov min, eax											; результат в min												
	INVOKE ExitProcess, 0									; завершение процесса Windows
main ENDP													; конец процедуры
end main  