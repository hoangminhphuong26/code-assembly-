;-------------------------------------------------------------------------
check_prime macro
    MOV BL,2                ; gan bl bat dau bang 2
    MOV AL, [SI]            ; gan phan tu trong chuoi vao al
    ;------------------------    
    CMP AX, 2               ; kiem tra so co bang 2
        JZ is_prime         ; neu co thi la so nguyen to
    CMP AX, 2               ; kiem tra so co be hon 2
        JB not_prime        ; neu co thi ko phai nguyen to
;----------------------------           
check_loop:                 ;
    XOR DX, DX              ; xoa thanh ghi dx
    DIV BX                  ; chia ax cho bx
    CMP DX, 0               ; so sanh phan du trong dx voi 0
        JZ not_prime        ; neu phan du = 0 tuc la chia het, ko nto 
    ;------------------------                
    MOV AL, [SI]            ; gan lai phan tu trong chuoi vao al
    INC BX                  ; tang bx len
    CMP BX, AX              ; so sanh bx voi ax
        JZ is_prime         ; neu bx tang den bang ax thi ax la so nguyen to              
    JMP check_loop          ; quay lai vong lap tiep tuc so sanh
;----------------------------            
is_prime:                   ;
    INC result              ; tang ket qua them 1
    INC SI                  ; tang chi so trong si
    LOOP list_loop          ; quay lai list_loop
    CALL dec_out            ; neu ket thuc lap thi in ra ket qua                                             
    MOV AH, 4Ch             ;
    INT 21h                 ;
;----------------------------
not_prime:                  ;
;----------------------------       
ENDM

DSEG SEGMENT
    msg1 db "so luong so nguyen to la: $"
    chuoi db 0,1,2,3,4,5,7,7,8,9,10,11
    result dw 0 
DSEG ENDS  

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    MOV AH, 09h                 ;
    LEA DX, msg1                ; in ra tin nhan
    INT 21h                     ;
    ;----------------------------
    XOR CX, CX                  ;
    MOV CX, 12                  ; gan so luong so vao cx lam bo dem         
    LEA SI, chuoi               ; dua chuoi so vao si
       
list_loop:                      ;
    check_prime                 ;
    INC SI                      ;
    LOOP list_loop              ;
;-------------------------------------------------------------------------
dec_out PROC                    ;
    MOV AX, result              ; chuyen resutl vao ax
    XOR CX, CX                  ; xoa cx
    MOV BX, 10                  ; chuyen 10 vao bx de lam so bi chia
;--------------------------------
    chia:                       ;
        XOR DX, DX              ; xoa dx
        DIV BX                  ; chia dx cho bx
        PUSH DX                 ; day phan du phep chia vao stack          
        INC CX                  ; cx de dem so luong so trong stack 
        ;------------------------               
        CMP AX, 0               ; kiem tra thoat vong lap   
        JNZ chia                ; ket qua phep chia!=0 thi lap tiep
;--------------------------------
    xuat:                       ;
        MOV AH,2                ; ham ah2 de in 1 ky tu ra man hinh
        POP DX                  ; lay 1 chu so ra tu stack vao dx
        ADD DL,30h              ; chuyen so thanh chu <acii>
        INT 21h                 ;
        ;------------------------
        LOOP xuat               ; giam cx, nhay ve xuat 
        RET                     ;
;--------------------------------
dec_out ENDP  

CSEG ENDS
END begin
