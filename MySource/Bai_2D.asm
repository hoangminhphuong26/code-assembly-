
DSEG SEGMENT
    max   DB 60              ; Cho phep nhap toi da 60 ky tu
    len   DB 0               ; Se chua so ky tu thuc su nhap duoc
    chuoi DB 60 DUP(?)       ; Vung dem luu chuoi nhap tu bàn phim
    tbao  DB 'Hay go vao 1 chuoi: $' ; Thong bao
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

start:
    mov ax, DSEG
    mov ds, ax

    ; In  cau thong bao
    mov ah, 09h
    lea dx, tbao
    int 21h

    ; Nhap chuoi toi da 60 ky tu
    mov ah, 0Ah
    lea dx, max      ; DX tro den vung dem gom: max, len, chuoi
    int 21h

    ; Thoat chuong trình
    mov ah, 4Ch
    int 21h

CSEG ENDS
END start




