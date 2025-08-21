.MODEL SMALL
.STACK 100H
.DATA
    TB1 DB 'Nhap ten file can xoa: $'

    ; buffer nhap ten file (DOS buffer 0Ah)
    FNAME_LEN DB 20
    FNAME_ACT DB ?
    FNAME_BUF DB 20 DUP('$')

    TBOK DB 13,10, 'XOA FILE THANH CONG!$'
    TBERR DB 13,10, 'KHONG XOA DUOC FILE!$'

.CODE
START:
    ; khoi tao data segment
    MOV AX, @DATA
    MOV DS, AX

    ; hien thong bao
    LEA DX, TB1
    MOV AH, 09H
    INT 21H

    ; nhap ten file
    LEA DX, FNAME_LEN
    MOV AH, 0AH
    INT 21H

    ; them ky tu ket thuc NULL (0) vao cuoi ten file
    MOV BL, FNAME_ACT         ; BL = do dai that su nhap
    LEA DI, FNAME_BUF
    ADD DI, BX
    MOV BYTE PTR [DI], 0      ; ket thuc chuoi bang NULL

    ; xoa file su dung ham 41h
    LEA DX, FNAME_BUF
    MOV AH, 41H
    INT 21H

    JC ERROR          ; neu carry flag = 1 thi loi

    ; thong bao xoa thanh cong
    LEA DX, TBOK
    MOV AH, 09H
    INT 21H
    JMP EXIT

ERROR:
    ; thong bao xoa that bai
    LEA DX, TBERR
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
END START
