; ----------------------------------------------------------------------------------------
; Writes "Hello, World!" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 helloworld.asm && ld helloworld.o && ./a.out
; ----------------------------------------------------------------------------------------


SECTION     .data
message:    db        "Hello, World!", 10      ; note the newline at the end
msgLen:     equ $-message

SECTION    .text
  GLOBAL    _start

_start:

  ;; PRINTING HELLO WORLD
  mov       rax, 1                  ; system call for write
  mov       rdi, 1                  ; file handle 1 is stdout
  mov       rsi, message            ; address of string to output
  mov       rdx, msgLen             ; number of bytes
  syscall                           ; invoke operating system to do the write

  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
