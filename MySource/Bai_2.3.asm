.model small
.stack 100h
.data
    msg1 db 'Nhap 1 ky tu: $'
    msg2 db 13,10,'Ky tu ke truoc : $'
    msg3 db 13,10,'Ky tu ke sau   : $'
    char db ?   ; bien luu ky tu nhap tu ban phim
    prev db ?   ; ky tu truoc
    next db ?   ; ky tu sau

.code
start:
    mov ax, @data
    mov ds, ax

    ; hien thi thong bao nhap ky tu
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; doc ky tu tu ban phim va hien thi luon
    mov ah, 01h
    int 21h
    mov char, al

    ; tinh ky tu ke truoc (char - 1) va ke sau (char + 1)
    mov al, char
    mov bl, al
    dec bl        ; ky tu truoc
    mov prev, bl
    mov bl, al
    inc bl        ; ky tu sau
    mov next, bl

    ; hien thi thong bao "Ky tu ke truoc"
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; in ky tu truoc
    mov dl, prev
    mov ah, 02h
    int 21h

    ; hien thi thong bao "Ky tu ke sau"
    lea dx, msg3
    mov ah, 09h
    int 21h

    ; in ky tu sau
    mov dl, next
    mov ah, 02h
    int 21h

    ; ket thuc chuong trinh
    mov ah, 4Ch
    int 21h
end start