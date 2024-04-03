SECTION .data
count db 0;
max  db 99;
nombre db 0,0,13;
dataLen: equ $-nombre;
timeval:
	dq 0
	dq 100000000

SECTION    .text
  GLOBAL    _start

_start:
  ;; compteur

  xor dl,dl                         ; reset dl qui va contenir le reste
  mov byte al, [count]              ; on met dans al parce que sinon dans rax tout casse
  mov rcx, 10                       ; on met le diviseur dans rcx
  div rcx                           ; on divise par rcx

  mov byte [nombre],al              ; on met dans l'adresse du nombre le quotient dans le premier byte
  mov byte [nombre+1],dl            ; on met dans l'adresse du nombre le reste dans le second byte

  add byte [nombre], 48             ; ajout de 48 pour correspondre à l'ascii au premier byte
  add byte [nombre+1], 48           ; ajout de 48 pour correspondre à l'ascii au second byte

  mov       rax, 1                  ; system call for write
  mov       rdi, 1                  ; file handle 1 is stdout
  mov       rsi, nombre             ; address of string to output
  mov       rdx, dataLen            ; address of string to output
  syscall                           ; invoke operating system to do the write

  mov rax, 35 ; syscall nanosleep for x86_64, see man nanosleep
  mov rdi, timeval ; pointing to struct encoding duration of sleep
  mov rsi, 0 ; null means 2nd parameter not used
  syscall

  inc byte [count]                  ; j'incrémente mon count
  mov r14b, byte [count]            ; je déplace la valeur de count dans r14 en bytes
  mov r15b, byte [max]              ; je déplace la valeur de max dans r15 en bytes
  cmp r14,r15                       ; je compare les deux valeurs
  jle _start                        ; si r14 < r15 alors je recommence à start

  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
