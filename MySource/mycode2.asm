CHECK_LOOP:
LODSB                   ; AL = [SI], SI++
CMP AL, [DI]            ; So sánh AL v?i ký t? t?i [DI]
    JNE WRONG_ID        ; N?u không kh?p, nh?y d?n báo l?i
INC DI                  ; DI++
LOOP CHECK_LOOP         ; CX--, l?p ti?p n?u chua h?t
