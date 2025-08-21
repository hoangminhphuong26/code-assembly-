.model small
.stack 100h
.data
    A    dw 1000
    B    dw 10
    C    dw 01Fh
    D    dw 030h
    E    dw 300Ah
    KQUA dw ?

.code
start:
    mov ax, data
    mov ds, ax

    mov ax, A
    add ax, B
    sub ax, C
    add ax, D
    add ax, E
    mov KQUA, ax
    mov ah, 4ch
    int 21h
end start