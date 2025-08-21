
INCHUOI MACRO chuoi
    MOV AH, 09h
    LEA DX, chuoi
    INT 21h
ENDM 

DSEG SEGMENT
    msg1 DB "Nhap mot so nguyen duong (1-8): $" ; yeu cau nhap
    msg2 DB "Giai thua n! = $"                  ; in ket qua
    error_msg DB "So nhap vao khong hop le!$"   ; tbao loi
    newline   DB 10, 13, "$"                    ; xuong dong
    sobin DB ?                                  ; Luu tru gia tri n
    result DW 1                                 ; Ket qua giai thua
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG

begin:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds
    ;----------------------------
    inchuoi msg1                ;
    MOV AH, 01h                 ; yeu cau nhap dau vao
    INT 21h                     ;
    ;----------------------------    
    SUB AL, 30h                 ; chuyen ky tu tu chu thanh so <ascii>
    MOV sobin, AL               ; chuyen al vao sobin
    ;----------------------------
    MOV AX, 1                   ; gan 1 cho ax - chua ket qua nhan 
    MOV BL, sobin               ; chuyen sobin 8bit vao bl 8bit
    MOV CX, BX                  ; chuyen bx 16bit vao cx 16bit BL nhap so CX bo dem lap
;------------------------------------------------------------------------- 
giaithua:                       ;
    CMP CX, 0                   ; kiem tra de thoat vong lap
    JE print_result             ; neu cx = 0, nhay den print_result
    ;----------------------------
    MUL CX                      ; nhan cx cho ax
    LOOP giaithua               ; giam cx, nhay ve giaithua 
;-------------------------------------------------------------------------
print_result:                   ;
    MOV result, AX              ;
    inchuoi newline             ;
    inchuoi msg2                ;   in ra ket qua
    CALL dec_out                ;
    ;----------------------------
    MOV AH, 4Ch                 ; ket thuc chuong trinh,
    INT 21h                     ; tro lai he dieu hanh

dec_out PROC                    ;
    MOV AX, result              ; chuyen resutl vao ax
    XOR CX, CX                  ; xoa cx
    MOV BX, 10                  ; BX= 10 de chia lay chu so thap phan
;--------------------------------
    chia:                       ;
        XOR DX, DX              ; xoa dx
        DIV BX                  ; ax/ 10 - ax : thuowng dx du
        PUSH DX                 ; day phan du phep chia vao stack          
        INC CX                  ; cx de dem so luong so trong stack 
        ;------------------------               
        CMP AX, 0               ; kiem tra thoat vong lap   
        JNZ chia                ; ket qua phep chia!=0 thi lap tiep
;--------------------------------
    xuat:                       ;
        MOV AH,02h              ; ham ah2 de in 1 ky tu ra man hinh
        POP DX                  ; lay tung chu so ra 
        ADD DL,30h              ; chuyen so thanh chu <acii>
        INT 21h                 ;
        ;------------------------
        LOOP xuat               ; giam cx, nhay ve xuat 
        RET                     ;
;--------------------------------
dec_out ENDP  

CSEG ENDS
END begin
