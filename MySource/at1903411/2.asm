
INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM 


DSEG SEGMENT
    TENFILE DB "D:\emu8086\MyBuild\teptin.txt" , 0
    THEFILE DW ?
    BUFFER DB 251 DUP ('$')
DSEG ENDS


CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG 


BEGIN:                          
    MOV AX, DSEG                
    MOV DS, AX                 
    ;
    MOV AH, 3DH                  
    LEA DX, TENFILE             ; Dia chi file
    MOV AL, 2                   ; Thuoc tinh tap tin
    INT 21H                     
    MOV THEFILE, AX              
    
    MOV AH, 3FH                  
    MOV BX, THEFILE             ; Handle cua file
    LEA DX, BUFFER              ; Dia chi vung dem
    MOV CX, 250                 
    INT 21H                        
    
    MOV AH, 3EH                
    MOV BX, THEFILE             ; Handle cua file
    INT 21H                     
 
    INCHUOI BUFFER              
    
    MOV AH, 08H                 
    INT 21H                       

    MOV AH, 4CH                 
    INT 21H                     

CSEG ENDS
END BEGIN

