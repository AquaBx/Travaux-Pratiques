SECTION    .text
  GLOBAL    _encode

_encode: 
    _init:
        xor r9,r9
        xor r8,r8

    _begin:
        cmp [r15+r9], byte 'A'
        jl _end

        cmp [r15+r9], byte 'Z'
        jg _end

        xor rdx,rdx                       ; reset dl qui va contenir le reste
        mov rax, r8                       ; on met dans al parce que sinon dans rax tout casse
        mov rcx, r12                      ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        xor r10, r10
        add r10, 26
        add r10b, byte [r13+rdx]
        sub r10b, byte [r15+r9]

        xor rdx,rdx                       ; reset dl qui va contenir le reste
        mov rax, r10                      ; on met dans al parce que sinon dans rax tout casse
        mov rcx, 26                       ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        mov r11b, dl
        add r11b, 'A' 

        mov byte [r15+r9],r11b

        inc r8

    _end:
        inc r9

        cmp r9,r14-1
        jl _begin

    ret
