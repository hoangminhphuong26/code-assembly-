CHECK_LOOP:
LODSB                   ; AL = [SI], SI++
CMP AL, [DI]            ; So s�nh AL v?i k� t? t?i [DI]
    JNE WRONG_ID        ; N?u kh�ng kh?p, nh?y d?n b�o l?i
INC DI                  ; DI++
LOOP CHECK_LOOP         ; CX--, l?p ti?p n?u chua h?t
