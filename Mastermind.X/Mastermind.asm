
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
    
;*******************************************************************************
;Random number generator for code
;*******************************************************************************
;store a digit in a seperate file loop. 
    MOVLB 0x3
    DIG1 EQU 0x17
    DIG2 EQU 0x18
    DIG3 EQU 0x19
    DIG4 EQU 0x1A
    COUNT_BLACK EQU 0x57    ;keep tally of black.
    COUNT_WHITE EQU 0x67
 GENERATOR
    MOVLW 5H
    MOVWF DIG1, 1
    MOVWF DIG2, 1
    MOVWF DIG3, 1
    MOVWF DIG4, 1
    
	LOOP1b
	BTFSS PORTA, 4
	BRA WT_RELEASE1
	    MOVWF DIG2, 1
		LOOP2b
		BTFSS PORTA, 4
		BRA WT_RELEASE1
		MOVWF DIG3, 1
		    LOOP3b
		    BTFSS PORTA, 4
		    BRA WT_RELEASE1
		    MOVWF DIG4, 1
			LOOP4b
			BTFSS PORTA, 4
			BRA WT_RELEASE1
			    DECF DIG4, 1, 1
			    BNZ LOOP4b
		    DECF DIG3, 1, 1
		    BNZ LOOP3b
		DECF DIG2, 1, 1
		BNZ LOOP2b
	    DECF DIG1, 1, 1
	    BNZ LOOP1b  
   GOTO GENERATOR

WT_RELEASE1
   BTFSS PORTA, 4
   BRA $-2
   NOP
   
;*******************************************************************************
   ;Start display at beginning. 
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
    
;Wait before clearing the display
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
    
    ;Return home
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
    
    ;Wait before clearing the display
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
    
    ;Delay
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
    ;selecting SW3 to digital port
    MOVLB 0xF
    MOVLW 0xF0
    MOVWF ANSELB
    MOVLW 0xCF
    MOVWF TRISB
    
    ;initialize locations for guesses
    MOVLB 0x3
    GUESS1 EQU 0x00
    GUESS2 EQU 0x01
    GUESS3 EQU 0x02
    GUESS4 EQU 0x03
    CNT EQU 0X04
    DisplayCNT EQU 0x05
    GUESS_COUNTER EQU 0x06
    COUNT_BLACK EQU 0x57
    COUNT_WHITE EQU 0x67
    INNERCOUNTER EQU 0x07
 
    MOVLW 0H
    MOVWF GUESS1, 1
    MOVWF GUESS2, 1
    MOVWF GUESS3, 1
    MOVWF GUESS4, 1
    MOVWF CNT, 1
    MOVWF COUNT_BLACK, 1
    MOVWF COUNT_WHITE, 1
    ;ASCII conversion
    MOVLW 30H
    MOVWF DisplayCNT, 1
    MOVLW 31H
    MOVWF GUESS_COUNTER, 1
    ;initializing fsr register locations. 
    LFSR 0, 0x312
    GOTO GUESS_DIGITS
    
GUESS_DIGITS 
    CLRWDT
    ;reset black and white counts (for looping)
    MOVLW 0H
    MOVWF COUNT_BLACK, 1
    MOVWF COUNT_WHITE, 1
    ;clear display
    MOVLW 2H
    MOVWF temp_wr
    call i_write
    
    ;Line 1: GUESS THE DIGITS
    call	LCDLine_1
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
    movLW	A'S'
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
    
    ;reset values once it reaches max digit of 5
    RESET_CNT1
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    ;Selecting Digit 1
    Select_Digit1
	;enables cursor
	call LCDLine_2
	MOVLW 0FH
	MOVWF temp_wr
	call i_write
	
	;display number on screen
	movF	DisplayCNT, 0, 1
	movWF	temp_wr
	call	d_write
	
	;shift to left
	MOVLW 10H
	MOVWF temp_wr
	call i_write
	
	;check if player wants to select digit
	BTFSS PORTB, 0
	BRA SW3_RELEASE1
	BRA SW2_PRESS1
	SW2_PRESS1
	    BTFSS PORTA, 4	    
	    BRA SW2_RELEASE1
	    BRA Select_Digit1
	
	    ;waits for release, the updates counters
    SW2_RELEASE1
	BTFSS PORTA, 4
	BRA SW2_RELEASE1
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT1
	GOTO Select_Digit1	
	
	;officalizes values once SW3 is released
    SW3_RELEASE1
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS1
	MOVWF GUESS1, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE1
	NOP
   	
;*******************************************************************************
	;Selecting Digit 2
	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT2
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    Select_Digit2
	movF	DisplayCNT, 0, 1
	movWF	temp_wr
	call	d_write
	
	;shift to left
	MOVLW 10H
	MOVWF temp_wr
	call i_write
	
	BTFSS PORTB, 0	    ;check if player wants to select
	BRA SW3_RELEASE2
	BTFSS PORTA, 4	    
	BRA SW2_RELEASE2
	BRA Select_Digit2
	
    SW2_RELEASE2
	BTFSS PORTA, 4
	BRA SW2_RELEASE2
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT2
	GOTO Select_Digit2	
	
    SW3_RELEASE2
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS2
	MOVWF GUESS2, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE2
	NOP   
;*******************************************************************************
	;Selecting Digit 3
	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT3
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    Select_Digit3
	movF	DisplayCNT, 0, 1
	movWF	temp_wr
	call	d_write
	
	;shift to left
	MOVLW 10H
	MOVWF temp_wr
	call i_write
	
	BTFSS PORTB, 0	    ;check if player wants to select
	BRA SW3_RELEASE3
	BTFSS PORTA, 4	    
	BRA SW2_RELEASE3
	BRA Select_Digit3
	
    SW2_RELEASE3
	BTFSS PORTA, 4
	BRA SW2_RELEASE3
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT3
	GOTO Select_Digit3	
	
    SW3_RELEASE3
	MOVF DisplayCNT, 0, 1	 
	MOVWF GUESS3, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE3
	NOP
;*******************************************************************************
	;Selecting Digit 4
	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT4
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    Select_Digit4
	movF	DisplayCNT, 0, 1
	movWF	temp_wr
	call	d_write
	
	;shift to left
	MOVLW 10H
	MOVWF temp_wr
	call i_write
	
	BTFSS PORTB, 0	    ;check if player wants to select
	BRA SW3_RELEASE4
	BTFSS PORTA, 4	    
	BRA SW2_RELEASE4
	BRA Select_Digit4
	
    SW2_RELEASE4
	BTFSS PORTA, 4
	BRA SW2_RELEASE4
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT4
	GOTO Select_Digit4
	
    SW3_RELEASE4
	MOVF DisplayCNT, 0, 1
	MOVWF GUESS4, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE4
	NOP

    ;Convert back from ASCII
    MOVLW 30H
    SUBWF GUESS1, 1, 1
    SUBWF GUESS2, 1, 1
    SUBWF GUESS3, 1, 1
    SUBWF GUESS4, 1, 1
    GOTO BLK_CNT
;*******************************************************************************
;Black and White count   
;*******************************************************************************
BLK_CNT  
    ;reg1 - reg4 for code
    REG1 EQU 0x37   ;MSB
    REG2 EQU 0x38
    REG3 EQU 0x39
    REG4 EQU 0x3A
    ;reg5 - reg8 for guess
    REG5 EQU 0x47
    REG6 EQU 0x48
    REG7 EQU 0x49
    REG8 EQU 0x4A
 
    ;Set registers for code with code generated
    MOVF DIG1, 0, 1	    ;move dig1 into working register
    MOVWF REG1, 1
    MOVF DIG2, 0, 1
    MOVWF REG2, 1
    MOVF DIG3, 0, 1
    MOVWF REG3, 1
    MOVF DIG4, 0, 1
    MOVWF REG4, 1
    
    ;Store guesses. 
    MOVF GUESS1, 0, 1
    MOVWF REG5, 1
    MOVF GUESS2, 0, 1
    MOVWF REG6, 1
    MOVF GUESS3, 0, 1
    MOVWF REG7, 1
    MOVF GUESS4, 0, 1
    MOVWF REG8, 1
    
    GOTO CHECK1
    
;if current check funtion branches, run one of these according 
;to which digit it is comparing. 
INCREMENTCOUNT1
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H		    ;this is for making sure that we never branch
    MOVWF REG1, 1	    ;to zero again, so we put an uncomparable value. 
    MOVLW -6H
    MOVWF REG5, 1
    GOTO CHECK2
 
INCREMENTCOUNT2
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG2, 1
    MOVLW -6H
    MOVWF REG6, 1
    GOTO CHECK3
    
INCREMENTCOUNT3
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG3, 1
    MOVLW -6H
    MOVWF REG7, 1
    GOTO CHECK4
    
INCREMENTCOUNT4
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG4, 1
    MOVLW -6H
    MOVWF REG8, 1
    GOTO DONE1
    
;Using subtraction as a comparison operator. 
;A-B = 0 shows that values are equal. 
CHECK1
    MOVF REG1, 0, 1	;move value of reg1 into working register.
    SUBWF REG5, 0, 1	;subtract the comparing value
    BZ INCREMENTCOUNT1	;if zero, branch to increment black count. 
    GOTO CHECK2		;check next digit
    
CHECK2
    MOVF REG2, 0, 1
    SUBWF REG6, 0, 1
    BZ INCREMENTCOUNT2
    GOTO CHECK3
    
CHECK3 
    MOVF REG3, 0, 1
    SUBWF REG7, 0, 1
    BZ INCREMENTCOUNT3
    GOTO CHECK4
    
CHECK4
    MOVF REG4, 0, 1
    SUBWF REG8, 0, 1
    BZ INCREMENTCOUNT4
    
DONE1
    GOTO WT_CNT
    
    
;WT_CNT
;Comapres code digit with every other guess digit that is not in the 
;same position. 
WT_CNT
   GOTO CHECKW1

;==============================================================================
;for checkw1
INCREMENT_WHITE2_1
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H		    ;To keep from double counting.
   MOVWF REG2, 1
   GOTO CHECKW2
   
INCREMENT_WHITE3_1
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG3, 1
   GOTO CHECKW2
   
INCREMENT_WHITE4_1
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG4, 1
   GOTO CHECKW2
   
;==============================================================================
;for checkw2
INCREMENT_WHITE1_2
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG1, 1		 
   GOTO CHECKW3
INCREMENT_WHITE3_2
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG3, 1		
   GOTO CHECKW3
INCREMENT_WHITE4_2
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG4, 1		 
   GOTO CHECKW3
   
;==============================================================================
;for checkw3
INCREMENT_WHITE1_3
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG1, 1		 
   GOTO CHECKW4
INCREMENT_WHITE2_3
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG2, 1
   GOTO CHECKW4
INCREMENT_WHITE4_3
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG4, 1		 
   GOTO CHECKW4
   
;==============================================================================
;for checkw4
INCREMENT_WHITE1_4
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG1, 1		 
   GOTO CONTINUE
INCREMENT_WHITE2_4
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG2, 1
   GOTO CONTINUE
INCREMENT_WHITE3_4
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	
   MOVWF REG3, 1		
   GOTO CONTINUE
   
CHECKW1
   ;COMPARE REG5 WITH 2 3 AND 4
   MOVF REG5, 0, 1
   SUBWF REG2, 0, 1
   BZ INCREMENT_WHITE2_1 
   MOVF REG5, 0, 1
   SUBWF REG3, 0, 1
   BZ INCREMENT_WHITE3_1
   MOVF REG5, 0, 1
   SUBWF REG4, 0, 1
   BZ INCREMENT_WHITE4_1
   GOTO CHECKW2
   
CHECKW2
   ;COMPARE REG6 WITH 1 3 AND 4
   MOVF REG6,0, 1
   SUBWF REG1, 0, 1
   BZ INCREMENT_WHITE1_2
   MOVF REG6,0, 1
   SUBWF REG3, 0, 1
   BZ INCREMENT_WHITE3_2
   MOVF REG6,0, 1
   SUBWF REG4, 0, 1
   BZ INCREMENT_WHITE4_2
   GOTO CHECKW3
   
CHECKW3
   ;COMPARE REG7 WITH 1 2 AND 4
   MOVF REG7, 0, 1
   SUBWF REG1, 0, 1
   BZ INCREMENT_WHITE1_3
   MOVF REG7, 0, 1
   SUBWF REG2, 0, 1
   BZ INCREMENT_WHITE2_3
   MOVF REG7, 0, 1
   SUBWF REG4, 0, 1
   BZ INCREMENT_WHITE4_3
   GOTO CHECKW4
   
CHECKW4
   ;COMPARE REG8 WITH 1 2 AND 3
   MOVF REG8, 0, 1
   SUBWF REG1, 0, 1
   BZ INCREMENT_WHITE1_4
   MOVF REG8, 0, 1
   SUBWF REG2, 0, 1
   BZ INCREMENT_WHITE2_4
   MOVF REG8, 0, 1
   SUBWF REG3, 0, 1
   BZ INCREMENT_WHITE3_4
   GOTO CONTINUE		
   
CONTINUE
   MOVLW 3AH
   CPFSLT GUESS_COUNTER, 1
   GOTO CONTINUE_TENS
   GOTO CONTINUE_ONES
;*******************************************************************************
;Feedback display     
;*******************************************************************************
;*******************************************************************************   
;For guesses below 10
;displays "  GUESS#: ####  "
;	  "BLACK=# WHITE=# "
;*******************************************************************************
CONTINUE_ONES
    MOVLW 30H
    ADDWF GUESS1, 1, 1
    ADDWF GUESS2, 1, 1
    ADDWF GUESS3, 1, 1
    ADDWF GUESS4, 1, 1
    ADDWF COUNT_BLACK, 1, 1
    ADDWF COUNT_WHITE, 1, 1
    
    call	LCDLine_1
    movLW	A' '
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
    movF	GUESS_COUNTER, 0, 1
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movF	GUESS1, 0, 1	
    movWF	temp_wr
    call	d_write
    movF	GUESS2, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	GUESS3, 0, 1	
    movWF	temp_wr
    call	d_write
    movF	GUESS4, 0, 1	
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
    movF	COUNT_BLACK, 0, 1	
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
    movF	COUNT_WHITE, 0, 1		
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    ;Convert values back from ASCII form.
    MOVLW 30H
    SUBWF COUNT_BLACK, 1, 1
    SUBWF COUNT_WHITE, 1, 1
    GOTO Score_Delay
    
;*******************************************************************************   
;For guesses 10 and up 
;*******************************************************************************   
CONTINUE_TENS
    MOVLW 30H
    ADDWF GUESS1, 1, 1
    ADDWF GUESS2, 1, 1
    ADDWF GUESS3, 1, 1
    ADDWF GUESS4, 1, 1
    ADDWF COUNT_BLACK, 1, 1
    ADDWF COUNT_WHITE, 1, 1
    
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
    movLW	A'1'
    movWF	temp_wr
    call	d_write
    MOVLW	0AH
    SUBWF	GUESS_COUNTER, 0, 1
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movF	GUESS1, 0, 1	
    movWF	temp_wr
    call	d_write
    movF	GUESS2, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	GUESS3, 0, 1	
    movWF	temp_wr
    call	d_write
    movF	GUESS4, 0, 1	
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
    movF	COUNT_BLACK, 0, 1		
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
    movF	COUNT_WHITE, 0, 1	
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    
    ;Convert back from ASCII
    MOVLW 30H
    SUBWF COUNT_BLACK, 1, 1
    SUBWF COUNT_WHITE, 1, 1
    GOTO Score_Delay
    
;*******************************************************************************
;Hold display for user to read.    
;*******************************************************************************
Score_Delay
    ;delay
    movLW	15
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo11
    decFsZ	Count0
    bra		WLoo11
    decFsZ	Count1
    bra		WLoo11
    decFsZ	Count2
    bra		WLoo11	
    
;*******************************************************************************
;Store guess into array.   
;******************************************************************************
    ;Subtract 30 from guesses to take them out of ascii form.
	MOVLW 30H
	SUBWF GUESS1, 1, 1
	SUBWF GUESS2, 1, 1
	SUBWF GUESS3, 1, 1
	SUBWF GUESS4, 1, 1
	
	;For moving to next row. 
	MOVLW 0CH
	MOVWF INNERCOUNTER, 1
	
	;Putting GUESS 1-4 across the row
	MOVF GUESS1, 0, 1
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS2, 0, 1
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS3, 0, 1
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS4, 0, 1
	MOVWF INDF0
	INCF FSR0L, F

	;going down 1 column
	NextRow
	    INCF FSR0L, F
	    DECF INNERCOUNTER, 1, 1
	    BNZ NextRow

;*******************************************************************************
;CHECK IF GAME OVER 
; if game won, call GAME_WON subroutine
; if number of guesses equals 12 call GAME_LOST subroutine
; else loop to check next guess. 
;*******************************************************************************
	CLRWDT
	MOVLW 4H
	SUBWF COUNT_BLACK, 0, 1
	BZ TEMP 
	
	MOVLW 3CH
	SUBWF GUESS_COUNTER, 0, 1
	BZ GAME_LOST
	
	;increment guess count
	INCF GUESS_COUNTER, 1, 1
	;loop back to get next guess.
	GOTO GUESS_DIGITS
	 
TEMP
   GOTO GAME_WON
	
;subroutine displaying that the game is lost.  
GAME_LOST
    ;displays "   CODE: ####   "
    ;	      "   GAME LOST    "
    MOVLW 30H
    ADDWF DIG1, 1, 1
    ADDWF DIG2, 1, 1
    ADDWF DIG3, 1, 1
    ADDWF DIG4, 1, 1
    
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
    movF	DIG1, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG2, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG3, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG4, 0, 1		
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
    MOVLW 30H
    ADDWF DIG1, 1, 1
    ADDWF DIG2, 1, 1
    ADDWF DIG3, 1, 1
    ADDWF DIG4, 1, 1
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
    movF	DIG1, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG2, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG3, 0, 1		
    movWF	temp_wr
    call	d_write
    movF	DIG4, 0, 1	
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