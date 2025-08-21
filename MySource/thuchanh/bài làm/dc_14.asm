;-------------------------------------------------------------------------
DSEG SEGMENT
    TENFILE DB "D:\emu8086\MyBuild\test 5.txt", 0
    THEFILE DW ?
    BUFFER DB 251 DUP ('$')
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG 

BEGIN:                         
    MOV AX, DSEG               
    MOV DS, AX                  
    ;-
    MOV AH, 41H                 ; Mo tap tin da co
    LEA DX, TENFILE             ; Dia chi file
    INT 21H                     ;  ngat 
    ;
    MOV AH, 4CH                 ; Ket thuc
    INT 21H                     ;gat 

CSEG ENDS
END BEGIN

