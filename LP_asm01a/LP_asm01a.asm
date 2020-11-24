.586														; ������� ������ (��������� Pentium)
.model flat, stdcall										; ������ ������(�������), ���������� � �������

getmin PROTO :DWORD, :DWORD									; �������� �������
getmax PROTO :DWORD, :DWORD									; �������� �������

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