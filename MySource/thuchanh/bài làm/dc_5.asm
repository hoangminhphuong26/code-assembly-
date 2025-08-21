
inchuoi MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 

DSEG SEGMENT
    msg1 db "so luong so duong la: $" 
    msg2 db "so luong so am la: $"
    newline db 0DH, 0AH, '$'
    chuoi db 0,1,2,3,4,-5,6,-7,8,9,10,11,54,-13,-47,50,-6,71,8,70,112 
    neg_num dw 0     ; bo dem so am
    pos_num dw 0     ; bo dem so duong
DSEG ENDS  

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    xor cx,cx                   ;
    mov cx, 21                  ; gan so luong so trong chuoi vao cx lam bo dem vong lap        
    lea si, chuoi               ; dua chuoi so vao si
       
list_loop:                      ;   vong lap chinh
    mov al, [si]                ; gan phan tu trong chuoi vao al
    cmp al, 0                   ; so sanh voi 0
        jl is_neg               ; neu al be hon 0 thi nhay 
        jg is_pos               ; neu al lon hon 0 thi nhay 

next:                           ;  so khong
    inc si                      ; tang si chuyen den so tiep theo
    loop list_loop              ; tiep tuc vong lap   
    
    inchuoi msg1                ; ket thuc vong lap, in ra msg1
    MOV AX, pos_num             ; dua pos_num vao ax de chuan bi in ra
    call dec_out                ; goi ham in ra so   
    ;----------------------------
    inchuoi newline             ; xuong dong
    inchuoi msg2                ; in ra msg2
    MOV AX, neg_num             ; dua neg_num vao ax de chuan bi in ra
    call dec_out                ; goi ham in ra so    
    ;----------------------------
    MOV AH, 4Ch                 ; ket thuc chuong trinh,
    INT 21h                     ; tro lai he dieu hanh
;-------------------------------------------------------------------------   
is_neg:                         ;
    inc word ptr neg_num        ; tang so dem so am
    jmp next                    ; tiep tuc lap
;-------------------------------------------------------------------------
is_pos:                         ;
    inc word ptr pos_num        ; tang so dem so duong
    jmp next                    ; tiep tuc lap
;-------------------------------------------------------------------------
dec_out PROC                    ;
    ;MOV AX, result              ; chuyen resutl vao ax
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
;-------------------------------------------------------------------------
CSEG ENDS
END begin
;-------------------------------------------------------------------------