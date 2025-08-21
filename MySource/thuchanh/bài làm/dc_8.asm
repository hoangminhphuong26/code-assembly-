
inchuoi MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 
;
inkytu_al MACRO
    MOV AH, 02h
    MOV DL, AL
    INT 21H
ENDM
;
DSEG SEGMENT    
    tbao1 DB "Nhap vao chuoi ky tu: $"
    tbao2 DB "Chuoi chu in thuong: $"   
    newline DB 0DH, 0AH, '$'
    buffer DB 255, 0, 255 dup('$')   
DSEG ENDS 
;
CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                         
    MOV AX, DSEG                
    MOV DS, AX                 
    ;        
    inchuoi tbao1               ;
    MOV AH, 0Ah                 ;
    LEA DX, buffer              ; yeu cau nhap dau vao
    INT 21h                     ;
    ;        
    inchuoi newline             ; xuong dong moi
    inchuoi tbao2               ; Hien thi thong bao chuoi ky tu hoa              
    lea si, buffer+2            ; dat con tro si ve vi tri dau tien cua chuoi        

lower_loop:                      ;
    lodsb                        ;
        cmp al, 0Dh              ; kiem tra ky tu co la nut enter
            je exit              ; neu co thi ket thuc in chu in thuong
        ;                
        cmp al, 'A'              ; kiem tra ky tu co la chu in hoa
            jb not_uppercase     ; neu khong thi in ra 
        ;                  
        cmp al, 'Z'              ; kiem tra ky tu co la chu in hoa
            ja not_uppercase     ; neu khong thi in ra  
        ;                                                                        
        add al, 32               ; chuyen thanh chu in thuong
        inkytu_al                ; in ra
        jmp lower_loop           ; tiep tuc lap         
        
not_uppercase:               ;
    inkytu_al                ;  ky tu khong phai chu in hoa
    jmp lower_loop           ;  in ra va tiep tuc lap     

exit:                        ;
    mov ah, 4Ch              ; tro ve he dieu hanh
    int 21h                  ; thoat khoi chuong trinh    
    
CSEG ENDS
END start
