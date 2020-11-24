.586														; ������� ������ (��������� Pentium)
.model flat, stdcall										; ������ ������(�������), ���������� � �������
includelib kernel32.lib										; ������������: ����������� � kernel32
ExitProcess PROTO: DWORD									; �������� ������� ��� ���������� �������� Windows 

.stack 4096

.const
	array sdword -1, 25, 23, -4, 2, 5, 3, -31, 16, 27

.data
	min sdword ?

.code

getmin PROC elem :DWORD, count :DWORD
	mov esi, elem          
    mov ecx, count											;������� �����
    mov eax, [esi]											;1 �������
	
FINDMIN:
	cmp [esi], eax
	jl FINISH												;if [esi] < eax goto finish
	jmp NEXT												;goto next

FINISH:
	mov eax, [esi]

NEXT:
	add esi, 4
	loop FINDMIN											;����
	ret          
getmin ENDP

main PROC													; ����� ����� main
    INVOKE getmin, offset array, lengthof array				; ����� ��������� getmin
    mov min, eax											; ��������� � min												
	INVOKE ExitProcess, 0									; ���������� �������� Windows
main ENDP													; ����� ���������
end main  