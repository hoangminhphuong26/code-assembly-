.MODEL SMALL
.STACK 100H
.DATA
    ;NUM DB '8$'     
    NUM DB '89$'

.CODE  
MAIN PROC
    MOV AX, @DATA    ; Initialize data segment
    MOV DS, AX         ;thanh DS k chua dia chi trong segment sai
     ;neu khong co 6 7 du lieu khong chinh sac in sai 
    ; Display the number 89
    MOV AH, 09H      ; DOS function to display string
    LEA DX, NUM      ; Load address of NUM into DX
    INT 21H          ; Call DOS interrupt
    
    ; Exit program
    MOV AH, 4CH      ; DOS function to terminate program
    INT 21H          ; Call DOS interrupt
MAIN ENDP
END MAIN


