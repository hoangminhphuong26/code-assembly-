DSEG SEGMENT
    tbao1 DB 'Hay go 1 phim: $'
    tbao2 DB 13,10, 'Ky tu nhan duoc la: $' ; xuong dong
    kyTu  DB ?         ; bien luu ky tu vua nhap
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

start:
    mov ax, DSEG
    mov ds, ax

    ; in thong bao yeu cau nhap phim
    mov ah, 09h
    lea dx, tbao1
    int 21h

    ; nhan 1 ky tu tu ban phim (ham 07h)
    mov ah, 07h
    int 21h
    mov kyTu, al        ; luu ky tu vao bien kyTu

    ; in thong bao ky tu nhan duoc
    mov ah, 09h
    lea dx, tbao2
    int 21h

    ; in ky tu da nhap
    mov dl, kyTu
    mov ah, 02h         ; ham in 1 ky tu
    int 21h

    ; ket thuc chuong trinh
    mov ah, 4Ch
    int 21h

CSEG ENDS
END start