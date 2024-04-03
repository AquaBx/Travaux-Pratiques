SECTION .data
count db 0,10;
dataLen: equ $-count;
max  db 9;

SECTION    .text
  GLOBAL    _start

_start:
  ;; compteur
  add       byte [count], 48        ; ajout de 48 pour correspondre à l'ascii

  mov       rax, 1                  ; system call for write
  mov       rdi, 1                  ; file handle 1 is stdout
  mov       rsi, count              ; address of string to output
  mov       rdx, dataLen          ; address of string to output
  syscall                           ; invoke operating system to do the write

  sub       byte [count], 48        ; retrait pour retrouver la vrai valeur de count

  inc byte [count]                  ; j'incrémente mon count
  mov r14b, byte [count]            ; je déplace la valeur de count dans r14 en bytes
  mov r15b, byte [max]              ; je déplace la valeur de max dans r15 en bytes
  cmp r14,r15                       ; je compare les deux valeurs
  jle _start                        ; si r14 < r15 alors je recommence à start

  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
