;-------------------------------------------------------------------------
INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM 


DSEG SEGMENT
    TENFILE DB "D:\emu8086\MyBuild\test2.txt", 0
    THEFILE DW ?
    BUFFER DB 251 DUP ('$')
DSEG ENDS


CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG 


BEGIN:                          ;
    MOV AX, DSEG                ;
    MOV DS, AX                 
    ;
    MOV AH, 3DH                 ; Mo tap tin da co
    LEA DX, TENFILE             ; Dia chi file
    MOV AL, 2                   ; Thuoc tinh tap tin
    INT 21H                     ; Goi ngat DOS
    MOV THEFILE, AX             ; Luu handle cua file vao THEFILE 
    
    MOV AH, 3FH                 ; Doc noi dung file vao vung dem
    MOV BX, THEFILE             ; Handle cua file
    LEA DX, BUFFER              ; Dia chi vung dem
    MOV CX, 250                 ; So byte can doc tu file da mo
    INT 21H                     ; Goi ngat DOS   
    
    MOV AH, 3EH                 ; Dong tap tin
    MOV BX, THEFILE             ; Handle cua file
    INT 21H                     ; Goi ngat DOS 
 
    INCHUOI BUFFER              ; In noi dung cua file ra man hinh  
    
    MOV AH, 08H                 ; Dung man hinh de xem ket qua
    INT 21H                     ; Goi ngat DOS    

    MOV AH, 4CH                 ; Ket thuc chuong trinh
    INT 21H                     ; Goi ngat DOS

CSEG ENDS
END BEGIN

