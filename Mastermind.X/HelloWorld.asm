;	Hello Wordl
;     	    Uses PICdem2 wiring: RA<1:3> = LCD < E, R/W, RS >
;                                RD<0:3> = LCD < DB4, 5, 6, 7 >
;
#Include	 p18f46k22.inc

    
    CBlock  0x00 ; -----  User RAM.Data in Access Bank 
Count2, Count1, Count0   ; counter for Delay
	; ------  for  LCD_p18LCD_Subs.asm  routines
COUNTER		; counter for delay loops
delay		; amount  of  delay for delay subroutines
temp_wr		; temporary register for LCD written data
temp_rd		; temporary register for data read from the LCD controller
ptr_pos, ptr_count, cmd_byte	; used by LCD routines
    EndC

    org		0x00
    GoTo	Main

Main:
    org		0x30
    
    call	LCDInit		; Initialize PORTA, PORTD, and LCD Module
    call	LCDLine_1	;move cursor to line 1
    
; ---------------- Wait a while = 1 x256 x256 x3 uSec = 0.1 sec
    movLW	1
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo	
    decFsZ	Count0
    bra		WLoo
    decFsZ	Count1
    bra		WLoo
    decFsZ	Count2
    bra		WLoo	
        
;   -----  Display Hello World ------
ShowCode:    
    call	LCDLine_1
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'M'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
     movLW	A'M'
    movWF	temp_wr
    call	d_write
     movLW	A'A'
    movWF	temp_wr
    call	d_write
     movLW	A'S'
    movWF	temp_wr
    call	d_write
     movLW	A'T'
    movWF	temp_wr
    call	d_write
     movLW	A'E'
    movWF	temp_wr
    call	d_write
     movLW	A'R'
    movWF	temp_wr
    call	d_write
     movLW	A'M'
    movWF	temp_wr
    call	d_write
     movLW	A'I'
    movWF	temp_wr
    call	d_write
     movLW	A'I'
    movWF	temp_wr
    call	d_write
     movLW	A'N'
    movWF	temp_wr
    call	d_write
     movLW	A'D'
    movWF	temp_wr
    call	d_write
WT_PRESS1
    BTFSS	PORTA, 4		;wait for SW2 to be pressed
    BRA		WT_RELEASE1
    BRA    	WT_PRESS1
    
    WT_RELEASE1    
    BTFSS	PORTA,4
    BRA		$-2			; wait for SW2 release

    
    call	LCDLine_2
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    MOVLW       14H 
    MOVWF       temp_wr
    call        i_write
    
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    MOVLW       14H 
    MOVWF       temp_wr
    call	i_write
    
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    MOVLW       14H 
    MOVWF       temp_wr
    call        i_write
    
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    MOVLW       14H 
    MOVWF       temp_wr
    call        i_write
    
    movLW	A'O'
    movWF	temp_wr
    call	d_write

    
    Twiddle:
    GoTo	Twiddle

    

; *****************  Low-Level LCD Routines  *******************

#Include LCD_p18LCD_Subs_New.asm  ; Contains:
; --- LCDInit:		>> initialize
; --- LCDLine_1:	>> Cursor to Line_1
; --- LCDLine_2:	>> Cursor to to Line_2
; --- i_write:  	>> instruction write
; --- d_write:		>> data        write
 

    End