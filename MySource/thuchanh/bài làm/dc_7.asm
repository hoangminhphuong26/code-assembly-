
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
    tbao2 DB "Chuoi chu in hoa: $"
    newline DB 0DH, 0AH, '$'
    buffer DB 255, 0, 255 dup('$')   
DSEG ENDS 

CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                      
    MOV AX, DSEG            
    MOV DS, AX                
    
    inchuoi tbao1            
    MOV AH, 0Ah              
    LEA DX, buffer           ; yeu cau nhap dau vao
    INT 21h                     
    ;
    inchuoi newline          ; xuong dong moi
    inchuoi tbao2            ; H hong bao chuoi ky tu hoa              
    lea si, buffer+2         ; dat con tro si ve vi tri dau tien cua chuoi   

upper_loop:                  
    lodsb                    ;
        cmp al, 0Dh          ; kiem tra ky tu co la nut enter
            je exit          ; neu co thi ket thuc in chu in hoa        
        ; 
        cmp al, 'a'          ; kiem tra ky tu co la chu in thuong
            jb not_lowercase ; neu khong thi in ra      
        ;
        cmp al, 'z'          ; kiem tra ky tu co la chu in thuong
            ja not_lowercase ; neu khong thi in ra       
        ; 
        sub al, 32           ; chuyen thanh chu in hoa
        inkytu_al            ; hien thi ra
        jmp upper_loop       ; quay lai nhan upper_loop  
       
not_lowercase:               ;  in ky tu
    inkytu_al                ;  ky tu khong phai chu in thuong
    jmp upper_loop           ;  in ra va tiep tuc lap 

exit:                        ;
    mov ah, 4Ch              ; tro ve he dieu hanh
    int 21h                  ; thoat khoi chuong trinh 
    
CSEG ENDS
END start
