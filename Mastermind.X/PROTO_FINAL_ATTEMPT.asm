
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
        
;Displays 'HI, PRESS S2 TO'
;        'START MASTERMIND'
ShowCode:    
    ;1ST LINE
    call	LCDLine_1
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A','
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'P'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'2'
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

    ;2ND LINE
    call	LCDLine_2
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
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
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write  
    
    ;pressing SW2 to begin 
    SW2_BEGIN
	BTFSS PORTA, 4
	GOTO SW2_CONTINUE
	BRA SW2_BEGIN
	
    SW2_CONTINUE
	BTFSS PORTA, 4
	BRA $-2    
;*******************************************************************************
    ;RETURN HOME 
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
	
;Displays " GUESS THE FOUR "
	; "   DIGIT CODE   "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'F'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
;WAIT BEFORE CLEARING DISPLAY
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo1	
    decFsZ	Count0
    bra		WLoo1
    decFsZ	Count1
    bra		WLoo1
    decFsZ	Count2
    bra		WLoo1	
    
    ;RETURN HOME 
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "EACH DIGIT IS IN"
	; "  THE RANGE OF  "
    call	LCDLine_1
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'F'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    ;WAIT BEFORE CLEARING DISPLAY
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo2	
    decFsZ	Count0
    bra		WLoo2
    decFsZ	Count1
    bra		WLoo2
    decFsZ	Count2
    bra		WLoo2	
    
    ;RETURN HOME 
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "  ZERO TO FIVE  "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'Z'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
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
    movLW	A'F'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'V'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write

    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo3	
    decFsZ	Count0
    bra		WLoo3
    decFsZ	Count1
    bra		WLoo3
    decFsZ	Count2
    bra		WLoo3	
     
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "PRESS SW2 TO GO "
	; "THROUGH NUMBERS "
    call	LCDLine_1
    movLW	A'P'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	32H
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
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'M'
    movWF	temp_wr
    call	d_write
    movLW	A'B'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo4	
    decFsZ	Count0
    bra		WLoo4
    decFsZ	Count1
    bra		WLoo4
    decFsZ	Count2
    bra		WLoo4	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "  PRESS SW3 TO   "
	; "  SELECT THE #   "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'P'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	33H
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
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
     ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo5	
    decFsZ	Count0
    bra		WLoo5
    decFsZ	Count1
    bra		WLoo5
    decFsZ	Count2
    bra		WLoo5	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "AFTER GUESSING  "
	; "THE CODE, THE   "
    call	LCDLine_1
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'F'
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
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A','
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
      ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo6	
    decFsZ	Count0
    bra		WLoo6
    decFsZ	Count1
    bra		WLoo6
    decFsZ	Count2
    bra		WLoo6	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays "SCREEN WILL SHOW"
	; "BLACK & WHITE #S"
    call	LCDLine_1
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'B'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'K'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'&'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
	
      ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo7
    decFsZ	Count0
    bra		WLoo7
    decFsZ	Count1
    bra		WLoo7
    decFsZ	Count2
    bra		WLoo7	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays " BLACK = CORRECT"
	; " # AND POSITION "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'B'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'K'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'='
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'P'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo8
    decFsZ	Count0
    bra		WLoo8
    decFsZ	Count1
    bra		WLoo8
    decFsZ	Count2
    bra		WLoo8	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
;Displays " WHITE =        "
	; "CORRECT # BUT   "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'='
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'B'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
     ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo9
    decFsZ	Count0
    bra		WLoo9
    decFsZ	Count1
    bra		WLoo9
    decFsZ	Count2
    bra		WLoo9	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
;Displays " WRONG POSITION "
	; ""
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'P'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
     ;delay
    movLW	10
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo10
    decFsZ	Count0
    bra		WLoo10
    decFsZ	Count1
    bra		WLoo10
    decFsZ	Count2
    bra		WLoo10	
    ;return home
    MOVLW 2H 
    MOVWF temp_wr
    call i_write
    
	
;*******************************************************************************
;Storing Guesses with buttons
;*******************************************************************************

    
    

;*******************************************************************************
;Feedback display     -> SHOULD BE AT THE END OF ALL OUR CALCULATIONS DOWN BELOW.; 
;*******************************************************************************
;displays "               "
;	  "BLACK=# WHITE=#"
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'B'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'K'
    movWF	temp_wr
    call	d_write
    movLW	A'='
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'H'
    movWF	temp_wr
    call	d_write
    movLW	A'I'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'='
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM A MEMORY LOCATION
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    


    
	
	
;subroutine displaying that the game is lost.  
GAME_LOST
    ;displays "   CODE: ####   "
    ;	      "   GAME LOST    "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
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
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '		
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    GOTO GAME_OVER
;subroutine for displaying game won.    
GAME_WON
    ;displays "   CODE: ####   "
    ;	      "   GAME WON!    "
    call	LCDLine_1
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'D'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A'#'		;SHOULD BE COPIED FROM WHERE COUNT IS STORED.
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
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
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'!'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A' '		
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    GOTO GAME_OVER
GAME_OVER
Twiddle:
    GoTo	Twiddle   
    
    #Include LCD_p18LCD_Subs_New.asm
END