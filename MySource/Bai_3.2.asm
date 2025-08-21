.model small
.stack 100h

.data
    msg1 db 'Nhap msv cua ban: $'
    msg2 db 13,10, 'Xin chao $'
    
    ; Bo dem nhap chuoi: max = 50 ky tu, len = so ky tu nhap, chuoi = 50 byte
    buffer db 50       ; so ky tu toi da cho phep nhap
           db ?        ; so ky tu da nhap (tu dong duoc cap nhat)
           db 50 dup(?) ; chuoi nhap vao

.code
start:
    mov ax, @data
    mov ds, ax

    ; hien thong bao nhap ten
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; goi ham nhap chuoi (ham 0Ah) - nhap den khi Enter
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; hien thong bao Xin chao
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; in chuoi da nhap
    mov si, offset buffer + 2   ; SI tro vao ky tu dau tien cua chuoi nhap
    mov cl, buffer[1]           ; CL = so ky tu thuc te nhap vao
    mov ch, 0                   ; CX = do dai chuoi

in_loop:
    mov dl, [si]                ; Lay tung ky tu
    mov ah, 02h
    int 21h                     ; In ra man hinh
    inc si
    loop in_loop

    ; ket thuc chuong trinh
    mov ah, 4Ch
    int 21h
end start