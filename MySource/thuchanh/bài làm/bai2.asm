
inchuoi MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 

inkytu_al MACRO
    MOV AH, 02h
    MOV DL, AL
    INT 21H
ENDM

DSEG SEGMENT    
    tbao1 DB "Nhap vao chuoi ky tu: $"
    tbao2 DB "Chuoi ky tu dao nguoc: $"
    newline DB 0DH, 0AH, '$'    
DSEG ENDS 

CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                          
    MOV AX, DSEG                
    MOV DS, AX                       
    
    inchuoi tbao1               
    MOV AH, 01h                 
    xor cx, cx                          
          
input:                          
    int 21h                     
    cmp al, 0Dh                 ; so sanh voi nut enter
        je print_rev            
   
    inc cx                      ; tang cx dem so ky tu trong stack
    push ax                     
    jmp input                      
    
print_rev:                      
    inchuoi newline             
    inchuoi tbao2               

    print:                      
        pop ax                  ; lay ky tu ra tu stack vao ax
        inkytu_al               ; in ra ky tu
        loop print                 

exit:                        
    mov ah, 4Ch             
    int 21h                   
 
CSEG ENDS
END start
