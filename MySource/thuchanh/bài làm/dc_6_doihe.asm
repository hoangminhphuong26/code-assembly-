
inchuoi MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 

DSEG SEGMENT
    tb1 db  'Nhap 1 so he thap phan: $'
    tb2 db 10,13, 'He hexa la: $'
    tb3 db 10,13, 'He nhi phan la: $'
    err db 10,13, 'sai dinh dang, nhap lai!$' 
    so1 dw ?     ; gia tri so nhap 
DSEG ENDS  

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG
        
begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    CALL he10_in               
    MOV so1, BX                 ; luu so da nhap tu bx vao bien 'so1'. 
    CALL hexa_out               
    CALL bin_out                ; chuyen doi va xuat he nhi phan   
    
    MOV AH, 4Ch                 ; ket thuc chuong trinh,
    INT 21h                     ; tro lai he dieu hanh
   
he10_in PROC                   
    inchuoi tb1;                

    nhapso:                     
        mov bx, 0               

    nhap:                       ;
        mov ah, 01h             ; lenh 01h doc ky tu dau vao 
        int 21h                 ;
        cmp al, 13              ; so sanh voi ky tu xuong dong(enter key) 
            je return           ; 
        cmp al, '0'             ; nhay neu nho hon  
            jb error            ;
        cmp al, '9'             ; nhay neu lon hon 
            ja error            ;
        
        sub al, 30h             ; chuyen ky tu sang so (ascii)
        mov ah, 0               ; 
        push ax                 ; luu gia tri hien tai cua ax vao ngan xep 

        mov ax, 10              ; gan 10 cho ax
        mul bx                  ; nhan ax voi bx
        pop bx                  ; dua bx vao stack
        add bx, ax              ; cong bx voi ax
        jmp nhap                ; tiep tuc lap 

    error:                      ;
        inchuoi err             ;  in ra thong bao loi
        inchuoi tb1             ;
        jmp nhapso              ;  tiep tuc yeu cau nhap so

    return:                     ;
        RET                     ;

he10_in ENDP
  
hexa_out PROC                   ; xuat ra he hexa
    inchuoi tb2                
    mov cx, 0                   
    mov ax, so1                 ; gan so do vao ax

    chia:                       ; 
        mov bl, 16              ; gan 16 cho bx
        div bl                  ; chia al cho bl
        push ax                 ; luu ket qua phep chia vao stack  
        inc cx                  ; tang cx lam so dem
        
        mov ah, 0               ; xoa thanh ghi ah
        cmp al, 0               ; so sanh al voi 0
            je hienthi          ; neu al=0 thi bat dau in
        jmp chia                ; 

    hienthi:                    ;
        pop bx                  ; lay gia tri tu stack ra bx
        cmp bh, 9               ; ko phai so thi nhay den nhan ht_chu 
            ja ht_chu           ;
        
        add bh, 30h             ; tu 0 ->9 them 30h de chuyen so thanh ky tu so 
        jmp ht2                 ;
        
    ht_chu:                     ;
        add bh, 55              ; de chuyen so thanh ky tu chu 

    ht2:                        ;
        mov dl, bh              ; in ra ky tu trong dl
        mov ah, 2               ;
        int 21h                 ;
        LOOP hienthi            ;

        RET                     ;

hexa_out ENDP 

bin_out PROC                    ; xuat ra he nhi phan
        inchuoi tb3             ;
        mov bx, so1             ; lay so1 ra bx
        mov cx, 16              ; gan cx=16 lam so luong chu so      
    xuat:                       ;
        shl bx, 1               ; dich trai gia tri bx 1 bit ,bit cao nhat vao co CF  
        mov dx, 0               ; xoa thanh ghi dx
        rcl dx, 1               ; dich vong trai dx 1 bit cung co CF, kq bit cao nhat bx chu?n bit thap nhat dx 
        add dx, 30h             ; chuyen gia tri trong dx thanh ASCII cua ky tu so 0 hoac 1 
        mov ah, 2               ; chuyen gia tri trong dx tu so sang ky tu
        int 21h                 ; in ra so trong dx
        loop xuat               ;

        RET                     ;
        
bin_out ENDP

CSEG ENDS
END begin
