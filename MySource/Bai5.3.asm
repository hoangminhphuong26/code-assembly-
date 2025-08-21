.MODEL SMALL
.STACK 100H
.DATA
    msg1 db 'Nhap ten file: $'
    msg2 db 13,10,'Nhap chuoi can chen: $'
    msgOk db 13,10,'Chen file thanh cong.$'
    msgErr db 13,10,'Khong mo duoc file.$'
    
    ; Vung dem nhap ten file
    fname db 20, ?, 20 dup('$')
    
    ; Vung dem nhap chuoi can chen
    buffer db 100, ?, 100 dup('$')

    ; Vung dem luu noi dung file cu (toi da 1024 bytes de test)
    old_data db 1024 dup('$')
    old_size dw 0
.CODE
START:
    ; Khoi tao DS
    mov ax, @data
    mov ds, ax

    ; Hien thong bao nhap ten file
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Nhap ten file
    lea dx, fname
    mov ah, 0Ah
    int 21h

    ; Ket thuc ten file bang NULL
    mov bl, fname[1]
    lea si, fname+2
    add si, bx
    mov byte ptr [si], 0

    ; Mo file (che do doc)
    lea dx, fname+2
    mov ah, 3Dh
    mov al, 0      ; open existing read-only
    int 21h
    jc open_error

    mov bx, ax     ; BX = file handle

    ; Doc noi dung cu cua file vao old_data
    lea dx, old_data
    mov cx, 1024
    mov ah, 3Fh
    int 21h

    ; luu so byte doc duoc
    mov old_size, ax

    ; Dong file
    mov ah, 3Eh
    int 21h

    ; Hien thong bao nhap chuoi
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Nhap chuoi can chen
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Ket thuc chuoi nhap bang NULL
    mov bl, buffer[1]
    lea si, buffer+2
    add si, bx
    mov byte ptr [si], 0

    ; Mo lai file de ghi moi (truncate file)
    lea dx, fname+2
    mov ah, 3Ch          ; create or truncate file
    mov cx, 0
    int 21h
    jc open_error

    mov bx, ax           ; BX = file handle

    ; Ghi chuoi moi
    mov cl, buffer[1]
    jcxz skip_write

    lea dx, buffer+2
    mov ah, 40h
    int 21h

skip_write:

    ; Ghi lai noi dung cu
    cmp old_size, 0
    jz skip_old

    lea dx, old_data
    mov cx, old_size
    mov ah, 40h
    int 21h

skip_old:
    ; Dong file
    mov ah, 3Eh
    int 21h

    ; Thong bao thanh cong
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
END START
