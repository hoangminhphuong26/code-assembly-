.model small
.stack 100h
.data
 msg1 db 10,13,'Good morning!$'
 msg2 db 10,13,'Good afternoon!$'
 msg3 db 10,13,'Good everning!$' 
 msg4 db 10,13,'Nhap Lai :$'
.code
main proc
    mov ax ,@data
    mov ds, ax
    nhap:
    mov ah, 01h
    int 21h
    
    mov dl , al
    cmp dl , 'S'
    je nhan1
    cmp dl , 's'
    je nhan1
    cmp dl , 'T'
    je nhan2
    cmp dl,'t'
    je nhan2
    cmp dl, 'C'
    je nhan3
    cmp dl, 'c'
    je nhan3
    nhan4:
    mov ah, 09h
    lea dx, msg4
    int 21h
     jmp nhap      ; nhay
    nhan1:
     mov ah , 09
     lea dx, msg1
     int 21h
     
     mov ah ,4ch
     int 21h
    nhan2: 
     mov ah , 09
     lea dx, msg2
     int 21h
     
     mov ah ,4ch
     int 21h 
    nhan3:
    mov ah, 09
    lea dx, msg3
    int 21h
    
    mov ah ,4ch
     int 21h
     
main endp
end