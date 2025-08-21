
INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM

DSEG SEGMENT
    tb1 DB "Nhap MSV: $"
    msv DB "AT190341","$"
    tb2 DB "Hoang Minh Phuong $"
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
    LEA SI, buffer+2           ; dat con tro SI ve vi tri dau tien cua chuoi
    MOV CL, [buffer+1]         ; lay chieu dai cua chuoi nhap vao
    LEA DI, msv                ; gan MSV vao thanh ghi DI

CHECK_LOOP:
    LODSB

        CMP AL, [DI]           ; so sanh ky tu trong chuoi dau vao voi mau
            JNE WRONG_ID       ; neu khong khop thi in ra thong bao loi
        INC DI                 
        LOOP CHECK_LOOP          

    INCHUOI tb2                
    JMP EXIT                   
      
WRONG_ID:
    INCHUOI tb3              
    JMP EXIT                 

EXIT:
    MOV AH, 4CH              
    INT 21H                  

CSEG ENDS
END START
