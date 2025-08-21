.MODEL SMALL          ; su dung mo hinh nho
.STACK 100H           ; cap phat stack 256 byte

.DATA
    PATH DB "", 0          ; duong dan rong ? tao file trong thu muc hien tai
    FILENAME DB 64 DUP('$')           ; noi de luu ten file nguoi dung nhap
    FULLNAME DB 128 DUP('$')          ; ket hop PATH + ten file
    MSG1 DB "Nhap ten file: $"        ; cau thong bao nhap ten
    MSG2 DB "Nhap noi dung ghi vao file: $" ; cau thong bao nhap noi dung
    BUFFER DB 32, ?, 32 DUP('$')      ; nhap chuoi kieu 0Ah [max, thuc te, du lieu...]
    NEWLINE DB 0DH, 0AH, '$'          ; ky tu xuong dong

.CODE
MAIN:
    MOV AX, @DATA         ; khoi tao doan du lieu
    MOV DS, AX
    MOV ES, AX

    ; in thong bao nhap ten file
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; nhap ky tu tung chu cai cua ten file
    LEA DI, FILENAME

NHAP_TEN:
    MOV AH, 01H           ; nhap 1 ky tu
    INT 21H
    CMP AL, 0DH           ; neu bam ENTER thi dung
    JE KET_TEN
    STOSB                 ; luu ky tu vao bo dem
    JMP NHAP_TEN

KET_TEN:
    MOV AL, 0             ; ket thuc chuoi bang NULL
    STOSB

    ; ghep PATH + ten file
    LEA SI, PATH
    LEA DI, FULLNAME

COPY_PATH:
    LODSB
    STOSB
    CMP AL, 0
    JNE COPY_PATH
    DEC DI

    ; copy ten file vao sau path
    LEA SI, FILENAME

COPY_NAME:
    LODSB
    STOSB
    CMP AL, 0
    JNE COPY_NAME

    ; xuong dong roi thong bao nhap noi dung
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; nhap noi dung bang ham 0Ah
    LEA DX, BUFFER
    MOV AH, 0AH
    INT 21H

    ; tao file bang ten vua nhap
    LEA DX, FULLNAME
    MOV AH, 3CH           ; tao file moi
    XOR CX, CX
    INT 21H
    JC LOI                ; neu co loi tao file thi nhay den LOI

    MOV BX, AX            ; BX = handle cua file

    ; ghi noi dung vao file
    LEA DX, BUFFER + 2    ; vi tri noi dung
    MOV CL, BUFFER + 1    ; do dai thuc te
    MOV CH, 0
    MOV AH, 40H           ; ghi file
    INT 21H

    ; dong file
    MOV AH, 3EH
    INT 21H

    ; thoat chuong trinh
    MOV AH, 4CH
    INT 21H

LOI:
    ; bao loi neu khong tao duoc file
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    LEA DX, MSG_ERR
    INT 21H
    MOV AH, 4CH
    INT 21H

MSG_ERR DB "Loi tao file! $"

END MAIN
