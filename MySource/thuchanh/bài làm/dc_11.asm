
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
    tbao2 DB "So ky tu trong chuoi: $"
    newline DB 0DH, 0AH, '$'
    result dw 1   
DSEG ENDS 

CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                          
    MOV AX, DSEG               
    MOV DS, AX                  
    ;
    inchuoi tbao1               ;
    MOV AH, 01h                 ; ham 01h doc 1 ky tu tu ban phim 
    xor cx, cx                  ; xoa cx        
           
input:                          ;
    int 21h                     ; nhap
    cmp al, 0Dh                 ; so sanh voi nut enter
        je print_result         ; la nut enter thi dung nhap, in ket qua        
    
    inc cx                      ; tang cx dem so ky tu
    jmp input                   ;
    
print_result:                   ;
    inchuoi newline             ; xuong dong
    inchuoi tbao2               ; thong bao hien thi so ky tu
    mov result, cx              ; luu ket qua trong cx vao result
    call dec_out                ; goi ham in so  
    mov ah, 4Ch                 ; tro ve he dieu hanh
    int 21h                     ; thoat khoi chuong trinh 

dec_out PROC                    ;
    MOV AX, result              ; chuyen resutl vao ax
    XOR CX, CX                  ; xoa cx
    MOV BX, 10                  ; chuyen 10 vao bx de lam so bi chia
;
    chia:                       ;
        XOR DX, DX              ; xoa dx
        DIV BX                  ; chia dx cho bx
        PUSH DX                 ; day phan du phep chia vao stack          
        INC CX                  ; cx de dem so luong so trong stack 
        ;              
        CMP AX, 0               ; kiem tra thoat vong lap   
        JNZ chia                ; ket qua phep chia!=0 thi lap tiep
;
    xuat:                       ;
        MOV AH,2                ; ham ah2 de in 1 ky tu ra man hinh
        POP DX                  ; lay 1 chu so ra tu stack vao dx
        ADD DL,30h              ; chuyen so thanh chu <acii>
        INT 21h                 ;
        ;
        LOOP xuat               ; giam cx, nhay ve xuat 
        RET                     ;
;
dec_out ENDP  

CSEG ENDS
END start
