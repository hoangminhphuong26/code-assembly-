
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
    tbao2 DB "Chuoi ky tu dao nguoc: $"
    newline DB 0DH, 0AH, '$'    
DSEG ENDS 

CSEG SEGMENT     
ASSUME CS: CSEG, DS: DSEG

start:                          ;
    MOV AX, DSEG                ; chuyen segment address dseg vao ax
    MOV DS, AX                  ; gan gia tri trong ax vao thanh ghi ds        
    
    inchuoi tbao1               ; hien thi yeu cau nhap dau vao
    MOV AH, 01h                 ; ham 01h doc 1 ky tu tu ban phim 
    xor cx, cx                  ; xoa cx          
          
input:                          ;
    int 21h                     ; thuc thi 01h doc 1 ky tu
    cmp al, 0Dh                 ; so sanh voi nut enter
        je print_rev            ; la nut enter thi dung nhap, in ket qua
   
    inc cx                      ; tang cx dem so ky tu trong stack
    push ax                     ; dua ky tu vao stack
    jmp input                   ; tiep tuc lap nhap ky tu    
    
print_rev:                      ;in chuoi nguoc
    inchuoi newline             ; xuong dong
    inchuoi tbao2               ; thong bao hien thi chuoi dao nguoc

    print:                      ;
        pop ax                  ; lay ky tu ra tu stack vao ax
        inkytu_al               ; in ra ky tu
        loop print              ; giam cx, tie tuc lap    

exit:                        ;
    mov ah, 4Ch              ; tro ve he dieu hanh
    int 21h                  ; thoat khoi chuong trinh 
 
CSEG ENDS
END start
