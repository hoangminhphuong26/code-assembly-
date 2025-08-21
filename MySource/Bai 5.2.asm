.model small
.stack 100h
.data
    ; Vùng d?m nh?p tên file (DOS buffer)
    fname db 20, ?, 20 dup('$')
    
    ; Vùng d?m nh?p chu?i c?n ghi (DOS buffer)
    buff db 100, ?, 100 dup('$')
    
    msg1 db 'Nhap ten file: $'
    msg2 db 13,10,'Nhap chuoi can ghi: $'
    msgOk db 13,10,'Ghi file thanh cong.$'
    msgErr db 13,10,'Khong mo duoc file.$'

.code
start:
    ; Thi?t l?p data segment
    mov ax, @data
    mov ds, ax

    ; In thong bao nhap ten file
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Nhap ten file (dung ham 0Ah)
    lea dx, fname
    mov ah, 0Ah
    int 21h

    ; K?t thúc chu?i tên file b?ng ký t? 0
    mov bl, fname[1]         ; BL = s? ký t? th?c nh?p
    lea si, fname+2
    add si, bx
    mov byte ptr [si], 0     ; thêm 0 d? k?t thúc chu?i tên file

    ; Mo file de doc/ghi (mode 02h)
    lea dx, fname+2
    mov ah, 3Dh
    mov al, 02h
    int 21h
    jc open_error            ; Neu loi thi nhay den open_error

    mov bx, ax               ; BX = file handle

    ; Dua con tro ve cuoi file
    mov cx, 0
    mov dx, 0
    mov al, 02               ; tinh tu cuoi file
    mov ah, 42h
    int 21h

    ; In thong bao nhap chuoi
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Nhap chuoi can ghi
    lea dx, buff
    mov ah, 0Ah
    int 21h

    ; Tinh dia chi chuoi vua nhap
    mov cl, buff[1]          ; so ky tu thuc nhap
    jcxz skip_write          ; neu khong nhap gi thi bo qua

    lea si, buff+2

write_loop:
    ; Ghi tung ky tu (co the ghi ca chuoi 1 lan neu muon)
    mov dl, [si]
    mov ah, 40h
    mov cx, 1
    int 21h

    inc si
    loop write_loop

skip_write:
    ; Dong file
    mov ah, 3Eh
    int 21h

    ; In thong bao thanh cong
    lea dx, msgOk
    mov ah, 09h
    int 21h
    jmp ketthuc

open_error:
    lea dx, msgErr
    mov ah, 09h
    int 21h

ketthuc:
    mov ah, 4Ch
    int 21h
end start
