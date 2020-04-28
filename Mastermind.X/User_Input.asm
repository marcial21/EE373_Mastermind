
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
 
    MOVLW 0H
    MOVWF GUESS1, 1
    MOVWF GUESS2, 1
    MOVWF GUESS3, 1
    MOVWF GUESS4, 1
    MOVWF CNT, 1
    
    ;ASCII conversion
    MOVLW 30H
    MOVWF DisplayCNT, 1
    
    
 
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
    

    G1
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
	    BRA G1
	
	    ;waits for release, the updates counters
    SW2_RELEASE1
	BTFSS PORTA, 4
	BRA SW2_RELEASE1
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT1
	GOTO G1	
	
	;officalizes values once SW3 is released
    SW3_RELEASE1
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS1
	MOVWF GUESS1, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE1
	NOP
   
	
;*******************************************************************************	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT2
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    G2
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
	BRA G2
	
    SW2_RELEASE2
	BTFSS PORTA, 4
	BRA SW2_RELEASE2
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT2
	GOTO G2	
	
    SW3_RELEASE2
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS2
	MOVWF GUESS2, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE2
	NOP   

;*******************************************************************************
	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT3
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    G3
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
	BRA G3
	
    SW2_RELEASE3
	BTFSS PORTA, 4
	BRA SW2_RELEASE3
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT3
	GOTO G3	
	
    SW3_RELEASE3
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS2
	MOVWF GUESS3, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE3
	NOP
	
;*******************************************************************************
	
	;move cursor to right
	MOVLW 14H
	MOVWF temp_wr
	call i_write
	
    RESET_CNT4
	MOVLW 30H
	MOVWF DisplayCNT, 1
	MOVLW 6H
	MOVWF CNT, 1
	
    G4
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
	BRA G4
	
    SW2_RELEASE4
	BTFSS PORTA, 4
	BRA SW2_RELEASE4
	INCF DisplayCNT, 1, 1
	DECF CNT, 1, 1
	
	BZ RESET_CNT4
	GOTO G4
	
    SW3_RELEASE4
	MOVF DisplayCNT, 0, 1	    ;move value from sw2 into GUESS2
	MOVWF GUESS4, 1
	BTFSS PORTB, 0
	BRA SW3_RELEASE4
	NOP
	
    MOVLW 30H
    SUBWF GUESS1, 1, 1
    SUBWF GUESS2, 1, 1
    SUBWF GUESS3, 1, 1
    SUBWF GUESS4, 1, 1
	
	
Twiddle:
    GoTo	Twiddle   
    
    #Include LCD_p18LCD_Subs_New.asm
END