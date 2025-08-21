
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
    tbao2 DB "Co ky tu 'A' trong chuoi!! $" 
    tbao3 DB "Khong co ky tu 'A' trong chuoi!! $" 
    keyword DB 'A'
    newline DB 0DH, 0AH, '$'
    buffer DB 255, 0, 255 dup('$')      
DSEG ENDS 

CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                      ;
    MOV AX, DSEG            ; chuyen segment address dseg vao ax
    MOV DS, AX              ; gan gia tri trong ax vao thanh ghi ds        
   
    inchuoi tbao1           ;
    MOV AH, 0Ah             ;
    LEA DX, buffer          ; yeu cau nhap dau vao
    INT 21h                 ;    
    
    inchuoi newline         ; xuong dong moi             
    lea si, buffer+2        ; dat con tro si ve vi tri dau tien cua chuoi    

check_loop:                 ;
    lodsb                   ; lay mot ky tu tu SI vao AL tang SI len 1
        cmp al, 0Dh         ; kiem tra ky tu co la nut enter
            je not_found    ;                 
        ; 
        cmp al, keyword     ; kiem tra ky tu co la chu in thuong
            je found        ; 
        ;                       
        jmp check_loop      ; quay lai nhan upper_loop          
        
not_found:                  ;
    inchuoi tbao3           ;  ky tu khong phai chu in thuong
    jmp exit                ;  in ra va tiep tuc lap 

found:                      ;
    inchuoi tbao2           ; ky tu khong phai chu in thuong

exit:                       ;
    mov ah, 4Ch             ; tro ve he dieu hanh
    int 21h                 ; thoat khoi chuong trinh 
   
CSEG ENDS
END start
