.model small
.data
    A    dw 10
    B    dw 8086
    C    dw 100h
    D    dw 350
    E    dw 0FAh
    KQUA dw ?
.code
    mov ax, @data
    mov ds, ax
    mov ax, A       ; ax=a
    add ax, B       ; ax=ax+B
    sub ax, C       ; ax=ax-c
    add ax, D       ; ax=ax+d
    add ax, E       ; ax=ax+e
    mov KQUA, ax
int 21h
end


