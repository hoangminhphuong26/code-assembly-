.MODEL SMALL
.STACK 100H
.DATA
    msg1 db 'Nhap ten file can xu ly: $'
    msgOK db 13,10, 'File da duoc ghi lai voi chu thuong.$'
    msgErr db 13,10, 'Khong mo duoc file hoac loi doc/ghi.$'

    ; Buffer nhap ten file (ham 0Ah)
    filename db 20, ?, 20 dup('$')

    buffer db 2048 dup('$')
    bytesread dw ?
.CODE
START:
    mov ax, @data
    mov ds, ax

    ;----------------------------
    ; Hien thong bao
    lea dx, msg1
    mov ah, 09h
    int 21h

    ;----------------------------
    ; Nhap ten file bang ham 0Ah
    lea dx, filename
    mov ah, 0Ah
    int 21h

    ; Them ky tu ket thuc NULL
    mov bl, filename[1]
    lea si, filename+2
    add si, bx
    mov byte ptr [si], 0

    ;----------------------------
    ; Mo file o che do doc/ghi
    lea dx, filename+2
    mov ah, 3Dh
    mov al, 2          ; mode read/write
    int 21h
    jc error
    mov bx, ax         ; BX = handle file

    ;----------------------------
    ; Doc noi dung file
    lea dx, buffer
    mov cx, 2048
    mov ah, 3Fh
    int 21h
    jc error
    mov bytesread, ax

    ;----------------------------
    ; Bien doi chu HOA -> chu thuong
    mov cx, bytesread
    jcxz skip_edit

    lea si, buffer
nextchar:
    mov al, [si]
    cmp al, 'A'
    jb skip
    cmp al, 'Z'
    ja skip
    or al, 20h
    mov [si], al
skip:
    inc si
    loop nextchar

skip_edit:

    ;----------------------------
    ; Dua con tro file ve dau
    mov dx, 0
    mov cx, 0
    mov ax, 4200h      ; seek to offset 0
    int 21h

    ;----------------------------
    ; Ghi noi dung moi vao file
    lea dx, buffer
    mov cx, bytesread
    mov ah, 40h
    int 21h
    jc error

    ;----------------------------
    ; Dong file
    mov ah, 3Eh
    int 21h

    ;----------------------------
    ; Thong bao thanh cong
    lea dx, msgOK
    mov ah, 09h
    int 21h
    jmp ketthuc

error:
    lea dx, msgErr
    mov ah, 09h
    int 21h

ketthuc:
    mov ah, 4Ch
    int 21h
END START
