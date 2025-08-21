
  
DSEG SEGMENT
    chuoi DB 'kma', 10, 13, '2022$' ;10 xuong doong 13 ve dau dong
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

start:
    mov ax, DSEG
    mov ds, ax
                    ; in chuoi
    mov ah, 09h
    lea dx, chuoi    ;nap dia chi
    int 21h      ;goi ngat 21h, ham09 de in chuoi

    mov ah, 08h    ; doi nhan phim(dung man hinh)
    int 21h

    mov ah, 4Ch     ; thoat 
    int 21h

CSEG ENDS
END start





