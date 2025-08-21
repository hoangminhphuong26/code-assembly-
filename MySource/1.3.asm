
.model small
.stack 100h
.data         
    num1   dw  ?
    num2   dw  ?
    num3   dd  3AB45Eh
    result dw  ?
.code
main proc      
    mov ax, @data
    mov ds, ax
    call a  
    call b 
    call c
    call d
    call e
    call f
    
    mov ax, 4ch
    int 21h

main endp 

a proc
    ;a)15h * 250 
    mov num1, 15h
    mov num2, 250
    mov ax, num1
    mov bx, num2    
    mul bx
    mov result, ax
    ret
a endp 

b proc
    ;b)16 * 0AF1h 
    mov num1, 16
    mov num2, 0AF1h
    mov ax, num1
    mov bx, num2    
    mul bx
    mov result, ax
    ret
b endp  

c proc
    ;c)300 * 400 
    mov num1, 300
    mov num2, 400
    mov ax, num1
    mov bx, num2    
    mul bx
    mov result, ax
    ret
c endp  

d proc
    ;d)1000 / 100 
    mov num1, 1000
    mov num2, 100
    mov ax, num1
    mov bx, num2    
    div bx
    mov result, ax
    ret
d endp 
e proc
    ;e)1000 / 100h 
    mov num1, 1000
    mov num2, 100h
    mov ax, num1
    mov bx, num2    
    div bx  
    mov result, ax 
    ret
e endp   

f proc
    ;f)3AB45Eh / 0A1h 
    mov num2, 0A1h
    mov dx, 0B45Eh        ;16bit cao
    mov ax, 003Ah     ;16bit thap
    mov bx, num2    
    div bx
    mov result, ax
    ret
f endp

    ; e f ddang sai kq
    

