
INCHUOI MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 

DSEG SEGMENT
    msg1 DB "Tong phan tu trong chuoi: $" ; yeu cau nhap
    newline DB 10, 13, "$"                      ; xuong dong
    num_list DW 1,2,3,4,5,6,7,8,9                  
    result DW 0                                 ; Ket qua giai thua
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    INCHUOI msg1                ; in thong bao ket qua
    MOV CX, 9                   ; gan so luong so trong danh sach vao dx
    LEA SI, num_list            ; dua danh sach so vao si
    MOV result, 0               ; gan ket qua = 0 
 
sum_loop:                       ;
    MOV AX, [SI]                ; dua so trong si ra ax  
    MOV BX, result              ; dua ket qua vao bx
    ;----------------------------
    ADD AX, BX                  ; cong bx vao ax
    MOV result, AX              ; luu tong vao result
    ADD SI, 2                   ; tang si them 2 vi moi so trong num_list la mot word 2 byte
    LOOP sum_loop               ; tiep tuc lap
    ;----------------------------
    CALL dec_out                ; sau khi lap xong thi goi ham in ket qua         
    MOV AH, 4Ch                 ; ket thuc chuong trinh,
    INT 21h                     ; tro lai he dieu hanh
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
