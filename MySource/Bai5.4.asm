.MODEL SMALL
.STACK 100H
.DATA
    msg1 db 'Nhap ten file thu nhat: $'
    msg2 db 13,10, 'Nhap ten file thu hai: $'
    msg3 db 13,10, 'Nhap ten file dich: $'
    msgOk db 13,10, 'Ghep file thanh cong.$'
    msgErr db 13,10, 'Khong mo duoc file.$'

    ; Vùng nh?p tên file (dùng hàm 0Ah)
    file1_name db 20, ?, 20 dup('$')
    file2_name db 20, ?, 20 dup('$')
    file3_name db 20, ?, 20 dup('$')

    ; Buffer luu n?i dung file
    buffer1 db 2048 dup('$')
    buffer2 db 2048 dup('$')

    bytes1 dw ?
    bytes2 dw ?
.CODE
START:
    ;--------------------------------------
    ; Khoi tao DS
    mov ax, @data
    mov ds, ax

    ;--------------------------------------
    ; Nhap ten FILE1
    lea dx, msg1
    mov ah, 09h
    int 21h

    lea dx, file1_name
    mov ah, 0Ah
    int 21h

    ; Ket thuc chuoi bang NULL
    mov bl, file1_name[1]
    lea si, file1_name+2
    add si, bx
    mov byte ptr [si], 0

    ;--------------------------------------
    ; Nhap ten FILE2
    lea dx, msg2
    mov ah, 09h
    int 21h

    lea dx, file2_name
    mov ah, 0Ah
    int 21h

    mov bl, file2_name[1]
    lea si, file2_name+2
    add si, bx
    mov byte ptr [si], 0

    ;--------------------------------------
    ; Nhap ten FILE3
    lea dx, msg3
    mov ah, 09h
    int 21h

    lea dx, file3_name
    mov ah, 0Ah
    int 21h

    mov bl, file3_name[1]
    lea si, file3_name+2
    add si, bx
    mov byte ptr [si], 0

    ;--------------------------------------
    ; Doc FILE1 vao buffer1
    lea dx, file1_name+2
    mov ah, 3Dh        ; mo file
    mov al, 0          ; mode read-only
    int 21h
    jc error
    mov bx, ax         ; BX = handle FILE1

    lea dx, buffer1
    mov cx, 2048
    mov ah, 3Fh        ; doc file
    int 21h
    mov bytes1, ax     ; luu so byte doc duoc

    ; Dong FILE1
    mov ah, 3Eh
    int 21h

    ;--------------------------------------
    ; Doc FILE2 vao buffer2
    lea dx, file2_name+2
    mov ah, 3Dh
    mov al, 0
    int 21h
    jc error
    mov bx, ax         ; BX = handle FILE2

    lea dx, buffer2
    mov cx, 2048
    mov ah, 3Fh
    int 21h
    mov bytes2, ax

    ; Dong FILE2
    mov ah, 3Eh
    int 21h

    ;--------------------------------------
    ; Tao FILE3
    lea dx, file3_name+2
    mov ah, 3Ch
    mov cx, 0
    int 21h
    jc error
    mov bx, ax         ; BX = handle FILE3

    ;--------------------------------------
    ; Ghi buffer1 vao FILE3
    lea dx, buffer1
    mov cx, bytes1
    mov ah, 40h
    int 21h

    ; Ghi buffer2 vao FILE3
    lea dx, buffer2
    mov cx, bytes2
    mov ah, 40h
    int 21h

    ; Dong FILE3
    mov ah, 3Eh
    int 21h

    ; Thong bao OK
    lea dx, msgOk
    mov ah, 09h
    int 21h
    jmp ket_thuc

error:
    lea dx, msgErr
    mov ah, 09h
    int 21h

ket_thuc:
    mov ah, 4Ch
    int 21h
END START
