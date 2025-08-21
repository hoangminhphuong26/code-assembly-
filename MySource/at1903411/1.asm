
INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM

DSEG SEGMENT
    tb1 DB "Nhap MSV: $"
    msv DB "128","$"
    tb2 DB "AT190341 $"
    tb3 DB "MSV khong khop!!$"
    newline DB 0DH, 0AH, '$'
    buffer  DB 100,0,100 DUP('$')
DSEG ENDS

CSEG SEGMENT
ASSUME CS: CSEG, DS: DSEG

START:
    MOV AX, DSEG              
    MOV DS, AX                
 
    INCHUOI tb1                
    MOV AH, 0AH                 
    LEA DX, buffer             
    INT 21H                     
  
    INCHUOI newline             
    XOR CX, CX                  
    LEA SI, buffer+2           
    MOV CL, [buffer+1]         ; LAY CHIEU DAI CHUOI NHAP VAO
    LEA DI, msv                ; GAN msv VAO THANH GHI DI

CHECK_LOOP:
    LODSB

        CMP AL, [DI]           ;
            JNE WRONG_ID       ; G
        INC DI                 ; TANG DI -> KY TU TIEP THEO DUOC SO SANH
        LOOP CHECK_LOOP          

    INCHUOI tb2                ; NEU KHONG PHAT HIEN KY TU KHONG KHOP
    JMP EXIT                   ; IN RA + thoat
      
WRONG_ID:
    INCHUOI tb3              
    JMP EXIT                 

EXIT:
    MOV AH, 4CH              
    INT 21H                  

CSEG ENDS
END START
      ...