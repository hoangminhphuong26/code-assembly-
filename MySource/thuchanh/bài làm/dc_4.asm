;-------------------------------------------------------------------------
check_divisible macro       ;
    mov al, [si]            ; gan phan tu trong chuoi vao al   
    xor dx, dx              ; xoa dx
    div n                   ; chia ax cho n
    cmp dx, 0               ; so sanh phan du trong dx voi 0
        jz is_divisible     ; neu khong du thi chia het
;----------------------------
next:                       ;
    inc si                  ; chuyen den so tiep theo trong chuoi
    loop list_loop          ; tiep tuc lap
    call dec_out            ; neu lap het thi goi ham in ra ket qua 
    MOV AH, 4Ch             ;
    INT 21H                 ;
;----------------------------
is_divisible:               ;
    inc result              ; tang ket qua them 1
    jmp next                ; den so tiep theo      
;----------------------------        
endm

DSEG SEGMENT
    msg1 db "so luong chia het cho 5 la: $"
    chuoi db 0,1,2,3,4,5,6,7,8,9,10,11,54,13,47,50,6,71,8,70,112 
    n dw 5
    result DW 0 
DSEG ENDS  

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    mov ah,9                    ;
    lea dx, msg1                ; in ra tin nhan
    int 21h                     ;
    ;----------------------------
    xor cx,cx                   ;
    mov cx, 21                  ; khoi tao vong lap
    ;----------------------------       
    lea si, chuoi               ; dua chuoi so vao si
;-------------------------------------------------------------------------  
list_loop:                      ;
    check_divisible             ;   kiem tra phan tu co chia het cho 5 khong 
    inc si                      ;   neu co thi tang result
    loop list_loop              ;
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

dec_out ENDP  

CSEG ENDS
END begin
