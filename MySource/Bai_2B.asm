DSEG SEGMENT
tbao DB ‘Hay go vao 1 phim: $’ 
DSEG ENDS
CSEG SEGMENT
ASSUME CS: CSEG, DS: DSEG
start:mov ax, DSEG
mov ds, ax
mov ah, 09h 
lea dx, tbao
int 21h
mov ah, 01h 
int 21h 
mov ah, 4Ch 
int 21h
CSEG ENDS
END start  
;tra loi cau hoi
;ky tu duoc luu o thanh ghi AL    
;ham int 21h/ AH=01h cho nhap, sau do ky tu dua vao thanh ghi al
;cpu khong tu luu ky tu vao ram
;



