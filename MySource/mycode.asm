
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here

ret


  

I, CAC LENH TRAO DOI DU LIEU
1, MOV: lenh gan gia tri
cu phap: MOV dich, goc --
chuc nang: dich = goc
VD:
MOV AL, BL;
MOV CX, 123FH;
MOV DL, [DI];

2, LEA: lenh gan dia chi hieu dung
cu phap: LEA dich, goc
AL = BL
CX = 123FH
DL = [DS:DI]
chuc nang: nap dia chi cua goc vao dich --
trong do:

dich thuong la mot trong so cac thanh ghi: BX, DX, BP, SI, DI

goc la ten bien trong doan DS duoc chi ro trong lenh hoac o nho cu the
VD:
LEA SI, a;
LEA CX, [BX];
nap dia chi bien a vao thanh ghi SI
nap dia chi o nho co dia chi [DS:BX] vao CX (hay CX = BX)

3, PUSH: day gia tri vao ngan xep
cu phap: PUSH goc
chuc nang: day gia tri cua goc vao ngan xep
VD:
PUSH AX;
PUSH 0ah;
day gia tri cua AX vao ngan xep
day gia tri 0ah vao ngan xep

4, POP: lay gia tri tu ngan xep
cu phap: POP goc
chuc nang: lay gia tri tren cung cua ngan xep va gan vao goc
VD:
POP AX;
lay gia tri tren cung cua ngan xep va gan vao AX

II, CAC PHEP TOAN
1, ADD: cong 2 toan hang
cu phap: ADD dich, goc
chuc nang: Dich = Dich + goc
VD:
ADD AL, 74H; AL = AL + 74H
ADD CL, AL; CL = CL + AL
ADD DL, [SI]; DL = DL + [DS:SI]

2, SUB: tru hai toan hang
cu phap: SUB dich, goc
chuc nang: dich = dich - goc
VD:
SUB AL, 74H; AL = AL - 74H
SUB CL, AL; CL = CL - AL
SUB DL, [SI]; DL = DL - [DS:SI]

3, MUL: nhan hai toan hang
cu phap: MUL goc
chuc nang:

voi goc la so 8 bit: AX = AL x goc

voi goc la so 16 bit: DXAX = AX x goc
VD:
MUL CL; AX = AL x CL
MUL BX; DXAX = AX x BX

Lay so 8 bit nhan voi so 16 bit: Gia su muon lay o nho co dia chi DS:SI 8 bit nhan voi thanh ghi BX 16 bit, ta co the lam bang cach de so 16 bit tai goc, so 8 bit vao AL, sau do mo rong sang AH de thanh 16 bit
MOV [SI], 74; [DS:SI] = 74
MOV BX, 123FH; BX = 123FH
MOV AL, [SI]; AL = [DS:SI]
MOV AH, 00H; AH = 00H -> AX = AL
MUL BX; DXAX = AX x BX

4, DIV: chia hai toan hang
cu phap: DIV goc
chuc nang:

voi goc la so 8 bit: AL = AX / goc; AH = AX % goc

voi goc la so 16 bit: AX = DXAX / goc; DX = DXAX % goc
Thuong duoc lam tron theo so nguyen duoi (VD: AX / goc = 4,9 -> AL = 4)
Neu goc = 0 hoac thuong lon hon FFH (voi phep chia 8 bit) hoac FFFFH (voi phep chia 16 bit) thi CPU thuc hien lenh ngat INT 0
VD:
DIV BL; AL = AX / BL; AH = AX % BL
DIV [SI]; AL = AX / [DS:SI]; AH = AX % [DS:SI]
DIV BX; AX = DXAX / BX; DX = DXAX % BX

5, DEC: tru di 1
cu phap: DEC dich
chuc nang: dich = dich - 1
VD:
DEC AL; AL = AL - 1
DEC BX; BX = BX - 1

6, INC: tang them 1
cu phap: INC dich
chuc nang: dich = dich + 1
VD:
INC AL; AL = AL + 1
INC BX; BX = BX + 1

7, NEG: dao dau
cu phap: NEG dich
chuc nang: dich = 0 - dich
VD:
NEG AL; AL = -AL

III, MOT SO LENH SO SANH BIT:
1, AND:
cu phap: AND dich, goc
chuc nang: dich = dich & goc
thuong dung de lay di mot so bit nhat dinh cua mot toan hang
VD:
AND AL, 0FH; lay 4 bit cao cua AL
(VD: AL = 1011 0111 -> AL = 0000 0111)

2, OR:
cu phap: OR dich, goc
chuc nang: dich = dich | goc
thuong dung de lap 1 so bit cua toan hang
VD:
OR AL, F0H; bien 4 bit dau cua AL thanh 1
(VD: AL = 1001 1011 -> AL = 1111 1011)

3, XOR:
cu phap: XOR dich, goc
chuc nang: dich = dich ^ goc
thuong dung de xoa mot toan hang ve 0 bang cach XOR voi chinh no, co the dung de dao bit
VD:
XOR BL, BL; BL = BL ^ BL = 0000 0000
XOR AL, BL; AL = AL ^ BL
(VD: AL = 1011 0110, BL = 1111 1111 -> AL = 0100 1001)

4, CMP:
cu phap: CMP dich, goc
chuc nang: so sanh hai toan hang dich va goc
sau khi so sanh hai toan hang khong thay doi, khong luu ket qua so sanh, lenh chi tac dong den cac co cua thanh ghi FR
thuong dung de tao co cho cac lenh nhay

IV, CAC LENH DICH VA QUAY
1, ROL: quay trai (chieu nguoc kim dong ho)
cu phap: ROL dich, CL
chuc nang: quay toan hang sang trai CL bit
neu chi quay 1 bit thi co the viet: ROL dich, 1
VD:
ROL BL, CL; quay trai BL CL bit
(VD: BL = 1000 0000, CL = 2 -> BL = 0000 0010)
ROL AL, 1; quay trai AL 1 bit
(VD: AL = 1000 0000 -> AL = 0000 0001)

2, ROR: quay phai (chieu kim dong ho)
cu phap: ROR dich, CL
chuc nang: quay phai toan hang sang phai CL bit
neu chi quay 1 bit thi viet: ROR dich, 1
VD:
ROR BL, CL; quay phai BL CL bit
(VD: BL = 1000 1001, CL = 1 -> BL = 1100 0100)
ROR AL, 1; quay phai AL 1 bit
(VD: AL = 1000 0000 -> AL = 0100 0000)

3, SHL: dich trai
cu phap: SHL dich, CL
chuc nang: dich trai toan hang CL bit
neu chi dich 1 bit thi viet: SHL dich, 1
VD:
SHL AL, CL; dich trai AL CL bit
(VD: AL = 1111 1111, CL = 5 -> AL = 1110 0000)
SHL BL, 1; dich trai BL 1 bit
(VD: BL = 1111 1111 -> BL = 1111 1110)

4, SHR: dich phai
cu phap: SHR dich, CL
chuc nang: dich phai toan hang CL bit
neu chi dich 1 bit thi viet: SHR dich, 1
VD:
SHR AL, CL; dich phai AL CL bit
(VD: AL = 1111 1111, CL = 5 -> AL = 0000 0111)
SHR BL, 1; dich phai BL 1 bit
(VD: BL = 1111 1111 -> BL = 0111 1111)

V, CAC LENH NHAY
cu phap: <ten lenh> Nhan
chuc nang: IP = IP + dich chuyen (nhay den nhan neu phu hop voi dieu kien cua lenh)
thuong dung voi lenh CMP
1, JMP (Jump): nhay khong dieu kien
2, JG (Jump if Greater): nhay neu lon hon
3, JNG (Jump if Not Greater): nhay neu khong lon hon (be hon hoac bang)
4, JLE (Jump if Lower or Equal): tuong tu JNG
5, JL (Jump if Lower): nhay neu be hon
6, JNL (Jump if Not Lower): nhay neu khong be hon (lon hon hoac bang)
7, JGE (Jump if Greater or Equal): tuong tu JNL
8, JE (Jump if Equal): nhay neu bang
9, JNE (Jump if Not Equal): nhay neu khong bang
10, JZ (Jump if Zero): nhay neu bang 0 (tuong tu JE)
11, JNZ (Jump if Not Zero): nhay neu khac 0 (tuong tu JNE)
12, JS (Jump if Signed): nhay neu co dau (SF == 1)
13, JNS (Jump if Not Signed): nhay neu khong co dau (SF == 0)
12, JC (Jump if Carry): nhay neu co nho (CF == 1)
13, JNC (Jump if Not Carry): nhay neu khong co nho (CF == 0)
12, JO (Jump if Overflow): nhay neu tran (OF == 1)
13, JNO (Jump if Not Overflow): nhay neu khong tran (OF == 0)
VD:
CMP AL, BL; so sanh AL va BL
JE bangnhau; nhay den nhan bangnhau neu ket qua bang nhau
CMP [SI], CL; so sanh [DS:SI] va CL
JG lonhon; nhay den nhan lonhon neu ket qua lon hon
SUB AL, AH; AL = AL - AH
JZ bangkhong; nhay den nhan bangkhong neu ket qua bang 0
CMP AL, 00H; so sanh AL voi 00H
JS am; nhay den nhan am neu co dau (SF == 1)
ADD AL, AH; AL = AL + AH
JO tran; nhay den nhan tran neu co tran (gia tri AL + AH vuot qua 8 bit, OF == 1)

VI, LENH DIEU KHIEN CO:
1, CLD: xoa co huong
cu phap: CLD
chuc nang: DF = 0

2, STD: lap co huong
cu phap: STD
chuc nang: DF = 1

3, CLC: xoa co nho
cu phap: CLC
chuc nang: CF = 0

4, STC: lap co nho
cu phap: STC
chuc nang: CF = 1

5, CMC: dao co nho
cu phap: CMC
chuc nang: CF = !CF (CF = 0 -> CF = 1; CF = 1 -> CF = 0)

VII, CAC LENH DI CHUYEN CHUOI
1, LODSB/LODSW:
cu phap: --
chuc nang: --
VD: --

2, STOSB/STOSW:
cu phap: --
chuc nang: --
VD: --

3, MOVSB/MOVSW:
cu phap: --
chuc nang: --
VD: --

VIII, LENH NGAT INT 21H
cu phap: INT 21H
chuc nang cua lenh dua theo gia tri cua AH

1, Ngat loai 1: doc mot ky tu tu ban phim
thuc hien khi AH = 1
chuc nang: doc mot ky tu duoc nhap vao tu ban phim, AL se luu ma ASCII cua phim vua nhap. Neu phim vua nhap la phim chuc nang, AL = 0
VD:
MOV AH, 1; AH = 1
INT 21H;
chuong trinh luc nay se dung lai den khi ban nhap vao mot phim

2, Ngat loai 2: hien mot ky tu len man hinh
thuc hien khi AH = 2
chuc nang: hien mot ky tu co ma ASCII la gia tri cua DL len man hinh
VD:
MOV AH, 2;
MOV DL, 30H;
INT 21H;
AH = 2
DL = 30H (30H la ma ASCII cua ‘0’)
man hinh se in ra ky tu ‘0’

3, Ngat loai 9: hien xau ky tu co ky tu ‘$’ o cuoi
thuc hien khi AH = 9
chuc nang: hien xau ky tu co dia chi lech la gia tri cua DX
VD:
tb DB ‘co lam thi moi co an$’;
MOV AH, 9;
LEA DX, tb;
INT 21H;
khai bao xau ky tu tb
AH = 9
gan dia chi lech cua tb vao DX
man hinh in ra xau tb (khong hien ky tu ‘$’)

4, Ngat chuong trinh (ngat 4CH): dung chuong trinh
thuc hien khi AH = 4CH
chuc nang: dung chuong trinh
VD:
MOV AH, 4CH;
INT 21H;
AH = 4CH
dung chuong trinh

 chuong trinh hop ngu
IX, KHAI BAO BIEN, HANG, MANG, CHUOI KY TU

Bien
Cu phap: <ten bien> <kieu du lieu> <gia tri khoi dau>
Trong do:

Ten bien: la ten cua bien

Kieu du lieu: la mien gia tri cua bien, co 3 kieu du lieu:

DB (define byte): bien byte, do dai 8 bit

DW (define word): bien word, do dai 16 bit

DD (define double word): bien double word, do dai 32 bit

Gia tri khoi dau: la gia tri duoc gan vao khi bien duoc khoi tao. Neu muon khoi tao bien ma khong co gia tri ban dau, su dung ky tu ?

Vi du:

nginx
Copy
Edit
B1 DB 16             ; khoi tao bien B1 co gia tri la 16  
x DW ff0ah           ; khoi tao bien x co gia tri la ff0ah  
y DB ?               ; khoi tao bien y khong co gia tri ban dau
Mang
Cu phap: <ten mang> <kieu du lieu> <gia tri 1>,<gia tri 2>,...
Trong do:

Ten mang: la ten cua mang

Kieu du lieu: la mien gia tri cua cac phan tu trong mang, co 3 kieu du lieu:

DB (define byte): bien byte, do dai 8 bit

DW (define word): bien word, do dai 16 bit

DD (define double word): bien double word, do dai 32 bit

Gia tri 1, gia tri 2,...: la gia tri duoc gan vao khi cac bien duoc khoi tao. Neu muon khoi tao bien ma khong co gia tri ban dau, su dung ky tu ?. Neu muon khoi tao nhieu bien co cung mot gia tri, su dung lenh:

php-template
Copy
Edit
<so luong phan tu> DUP(<gia tri>)
Lenh DUP co the long nhau.

Vi du:

nginx
Copy
Edit
mang DB 1,2,3,4,5,6,7               ; khoi tao mang co 7 phan tu co gia tri tu 1 den 7  
dl DB 100 DUP(?)                    ; khoi tao mang co 100 phan tu chua co gia tri  
d1 DB 1, 2, 3 DUP(4)                ; khoi tao mang co 5 phan tu: 1, 2, 4, 4, 4  
d2 DB 1,2, 2 DUP(4, 3 DUP(5), 6)    ; d2 = 1, 2, 4, 5, 5, 5, 6, 4, 5, 5, 5, 6
Chuoi
Cu phap: <ten xau> <kieu du lieu> <xau>
La mot kieu dac biet cua mang, trong do moi ky tu cua xau la mot phan tu cua mang. Gia tri cua moi phan tu chinh la ma ASCII cua ky tu do. Ky tu $ bao hieu da het xau.

Vi du:

csharp
Copy
Edit
xau1 DB 'can lao vi tien thu$'        ; xau1 = 'can lao vi tien thu$'  
xau2 DB 30h, 31h, 32h, 33h, '$'       ; xau2 = '0123$'  
CRLF DB 13, 10, '$'                   ; day la xau dung de xuong dong va ve dau dong
                                      ; 13 la ky tu ve dau dong (CR - carriage return)
                                      ; 10 la ky tu them dong moi (LF - line feed)
                                      ; hieu don gian CRLF co tac dung nhu "\n" trong C/C++
Hang
Cu phap: <ten hang> EQU <gia tri>
Chuc nang: tao hang co ten la <ten hang> va co gia tri la <gia tri>. Gia tri cua hang khong the thay doi.

Vi du:

nginx
Copy
Edit
CRLF EQU 13, 10, '$'           ; khai bao hang CRLF  
a1 EQU 19                      ; khai bao hang a1 = 19  
a2 EQU 'Hello '                ; khai bao hang a2 = 'Hello '  
MSG DB a2, 'World$'            ; khai bao MSG = 'Hello World$'
X, CAU TRUC MOT CHUONG TRINH HOP NGU (.EXE)

Khung co ban cua mot chuong trinh:

mathematica
Copy
Edit
.Model
.Stack
.Data
.Code
Khai bao quy mo su dung bo nho (.Model)
Cu phap: .model <kieu kich thuoc bo nho>
Dung de mo ta kich thuoc doan ma va doan du lieu cua chuong trinh:

Tiny: Ma lenh va du lieu nam trong mot doan

Small: Ma lenh nam trong mot doan, du lieu trong mot doan

Medium: Ma lenh khong nam trong mot doan, du lieu trong mot doan

Compact: Ma lenh trong mot doan, du lieu nhieu doan

Large: Ma lenh va du lieu nhieu doan, khong co mang nao lon hon 64KB

Huge: Nhu Large, nhung cho phep mang lon hon 64KB

Vi du:

Copy
Edit
.model small     ; khai bao kieu kich thuoc bo nho la small  
.model tiny      ; khai bao kieu kich thuoc bo nho la tiny
Khai bao ngan xep (.stack)
Cu phap: .stack <kich thuoc>
Dung de khai bao do lon ngan xep cho chuong trinh. Neu khong khai bao, trinh dich tu dong gan kich thuoc la 1KB, kich thuoc nay qua lon so voi nhu cau binh thuong. Thuc te chi can 100-256 byte la du.

Vi du:

cpp
Copy
Edit
.stack 100
Khai bao doan du lieu (.data)
Cu phap:

php-template
Copy
Edit
.data
<khai bao bien 1>
<khai bao bien 2>
...
Tat ca bien, mang, xau deu phai khai bao o day. Nen khai bao hang o day du co the khai bao trong doan ma.

Vi du:

kotlin
Copy
Edit
.data
tb1 DB 'moi nhap xau:$'  
tb2 DB 'xau ma ban vua nhap la:$'  
x DB ?  
CR DB 13  
LF EQU 10
Khai bao doan ma (.code)
La noi chua ma lenh cua chuong trinh, gom chuong trinh chinh va cac chuong trinh con (neu co).

Cu phap chuong trinh chinh:

objectivec
Copy
Edit
<ten CTC> PROC
  ; code nam o day
  CALL <ten chuong trinh con>    ; goi chuong trinh con
<ten CTC> ENDP
Chuong trinh con:

objectivec
Copy
Edit
<ten CTC> PROC
  ; code nam o day
  RET                            ; ket thuc chuong trinh con
<ten CTC> ENDP
 