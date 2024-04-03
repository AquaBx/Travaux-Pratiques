SECTION .data
message: db "HELLO WORLD!",10 ; input message with newline
len_msg: equ $-message ; length of input message

message2: db "SALUT",10 ; input message with newline
len_msg2: equ $-message2 ; length of input message

key: db "DIANA" ; key encoding the shift of the symmetry
len_key: equ $-key ; length of input message

extern _encode


SECTION .bss
    two_bytes resb 2

SECTION    .text
    GLOBAL    _start


_print:
    mov       rax, 1                  ; system call for write
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, r15                ; address of string to output
    mov       rdx, r14                ; address of string to output
    syscall
    ret  

_start:

    mov rax, 3      ; rax <- 0 (syscall number for 'read')
    mov rbx, 1      ; edi <- 0 (stdin file descriptor)
    mov rcx, two_bytes   ; rsi <- address of the buffer.  lea rsi, [rel buffer]
    mov rdx, [two_bytes]  ; rdx <- size of the buffer
    int 0x80

    mov r15, message ; addresse du message
    mov r14, len_msg ; taille du message
    mov r13, key     ; adresse de la clé
    mov r12, len_key ; taille de la clé

    call _encode
    call _print

    mov r15, message  ; addresse du message
    mov r14, len_msg  ; taille du message
    mov r13, key      ; adresse de la clé
    mov r12, len_key  ; taille de la clé

    call _encode
    call _print

    mov r15, message2  ; addresse du message
    mov r14, len_msg2  ; taille du message
    mov r13, key      ; adresse de la clé
    mov r12, len_key  ; taille de la clé

    call _encode
    call _print

    ;; EXITING PROGRAM
    mov       rax, 60                 ; system call for exit
    mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
    syscall                           ; invoke operating system to exit
