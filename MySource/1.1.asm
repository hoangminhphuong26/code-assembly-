.model small
.code
org 100h

start:
    mov ax, 10 ;10
    add ax, 8086  ; +8086
    sub ax, 0100h  ; -100h
    add ax, 350   ; +350
    add ax, 00FAh ;+0FAh
    
    int 21h
end start