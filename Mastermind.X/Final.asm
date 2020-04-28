
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
#Include    p18f46k22.inc  
MAIN_PROG CODE

START 
 
; Display Message
;******************************************************************************* 
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
;Counter and Switch Press/Release Attempt
;*******************************************************************************
  
    

    
    Twiddle:
    GoTo	Twiddle

    
; *****************  Low-Level LCD Routines  *******************

#Include LCD_p18LCD_Subs_New.asm  ; Contains:
; --- LCDInit:		>> initialize
; --- LCDLine_1:	>> Cursor to Line_1
; --- LCDLine_2:	>> Cursor to to Line_2
; --- i_write:  	>> instruction write
; --- d_write:		>> data        write
 
 
 
;******************************************************************************* 
;Storing Guesses and Code
;******************************************************************************* 
    ;LOCATION OF GUESSES
    GUESS1 EQU 0x00
    GUESS2 EQU 0x01
    GUESS3 EQU 0x02
    GUESS4 EQU 0x03
 
    ;LOCATION OF CODE
    CODE1 EQU 0x04
    CODE2 EQU 0x05
    CODE3 EQU 0x06
    CODE4 EQU 0x07
 
    ;going down one row
    INNERCOUNTER EQU 0x04
    MOVLW 0CH
    MOVWF INNERCOUNTER
    
    ;counter for # of guess
    OUTERCOUNTER EQU 0x05
    MOVWF OUTERCOUNTER
 
    ;TEST DIGITS
    ;with number generator, we would have to unpack guess inputs first
    MOVLW 1H
    MOVWF CODE1
    MOVLW 2H
    MOVWF CODE2
    MOVLW 3H
    MOVWF CODE3
    MOVLW 4H
    MOVWF CODE4
    
    
 
    ;TEST DIGITS
    ;with number generator, we would have to unpack guess inputs first
    MOVLW 1H
    MOVWF GUESS1
    MOVLW 2H
    MOVWF GUESS2
    MOVLW 3H
    MOVWF GUESS3
    MOVLW 4H
    MOVWF GUESS4
    
    ;starting location
    LFSR 0, 0x12

    ;12 guesses
    EachGuess
	;button press/release implementation not incorporated
	;using testing with dummy digits instead
    
	;update INNERCOUNTER
	MOVLW 0CH
	MOVWF INNERCOUNTER
	
	;Putting GUESS 1-4 across the row
	MOVF GUESS1, 0
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS2, 0
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS3, 0
	MOVWF INDF0
	INCF FSR0L, F

	MOVF GUESS4, 0
	MOVWF INDF0
	INCF FSR0L, F

	;going down 1 column
	NextRow
	    INCF FSR0L, F
	    DECF INNERCOUNTER
	    BNZ NextRow
	
	DECF OUTERCOUNTER 
	BNZ EachGuess
    
	
	
	
	
	
;*******************************************************************************
; Subroutines: Pack
;*******************************************************************************	
    ;register locations
    Ones EQU 0x0C
    Tens EQU 0x0D
    PACKED EQU 0x0E
    MOVLW 0H
    MOVWF Ones
    MOVWF Tens
    MOVWF PACKED
 
    ;testing digits
    TEST1 EQU 0x0F
    TEST2 EQU 0x1C
    MOVLW D'3'
    MOVWF TEST1
    MOVLW D'5'
    MOVWF TEST2
    
    ;extract Ones digit and Tens digit into one register
    PACK
	MOVF TEST1, 0	    ;move ones digit to W
	MOVWF Ones	    ;load into Ones digit location
	ADDWF PACKED, 1	    ;add to final packed location
	MOVF TEST2, 0	    ;load tens digit to W
	MOVWF Tens	    ;move it to Tens location
	
	SWAPF Tens, 0	    ;swap tens
	ADDWF Ones	    ;add together
	MOVWF PACKED
    
	
;*******************************************************************************
; Subroutines: Unpack
;*******************************************************************************
    ;register locations
    OnesUnpack EQU 0x1D
    TensUnpack EQU 0x1E
    PackedDigit EQU 0x1F
    MOVLW 0H
    MOVWF OnesUnpack
    MOVWF TensUnpack
    MOVWF PackedDigit
 
    ;testing digits
    T1 EQU 0x2C
    MOVLW 66H
    MOVWF T1
    
    ;extract values into OnesUnpack and TensUnpack2
    UNPACK
	MOVF T1, 0		;load packed value into W
	MOVWF PackedDigit	;move into PackedDigit location
	MOVWF OnesUnpack	;move same value into OnesUnpack
	
	;implemented a division of 16 to count how many 'tens' there are
	MULLW .128		;2048/16 = 128
	RLNCF PRODH, W		;shift 1 bit to left
	SWAPF WREG		;swap value in W
	ANDLW 0x1F		;AND W with literal value of 1FH
	MOVWF TensUnpack
	
	MOVF TensUnpack, 0	;load # of tens
	MULLW 0x10		;multiply it with ten
	MOVFF PRODL, TensUnpack	;load value from PRODL
	MOVF TensUnpack, 0	
	SUBWF OnesUnpack, 1	;subtract tens value from original
	SWAPF TensUnpack, 1	;literal value gives ones value
	;This is a very ugly way of doing it, but I couldn't
	;think of anything else at the moment
	
	
;*******************************************************************************
; Subroutines: BLK_CNT
;*******************************************************************************
BLK_CNT  
    ;reg1 - reg4 for code
    REG1 EQU 0x37
    REG2 EQU 0x38
    REG3 EQU 0x39
    REG4 EQU 0x3A
    ;reg5 - reg8 for guess
    REG5 EQU 0x47
    REG6 EQU 0x48
    REG7 EQU 0x49
    REG8 EQU 0x4A
    BYTE1 EQU 0x07
    BYTE2 EQU 0x08
    COUNT_BLACK EQU 0x57
    MOVLW 0H
    MOVWF COUNT_BLACK
 
   MOVLW 5H
   MOVWF REG1
   MOVWF REG3
   MOVWF REG6
   MOVWF REG8
   MOVLW 6H
   MOVWF REG2
   MOVWF REG4
   MOVWF REG5
   MOVWF REG7
    
    GOTO CHECK1
    
INCREMENTCOUNT1
    INCF COUNT_BLACK
    MOVLW -1H
    MOVWF REG1
    GOTO CHECK2

INCREMENTCOUNT2
    INCF COUNT_BLACK
    MOVLW -1H
    MOVWF REG2
    GOTO CHECK3
    
INCREMENTCOUNT3
    INCF COUNT_BLACK
    MOVLW -1H
    MOVWF REG3
    GOTO CHECK4
    
INCREMENTCOUNT4
    INCF COUNT_BLACK
    MOVLW -1H
    MOVWF REG4
    GOTO DONE1
    ;code for comparision
CHECK1
    MOVF REG1, 0
    SUBWF REG5, 0
    BZ INCREMENTCOUNT1
    GOTO CHECK2
    
CHECK2
    MOVF REG2, 0
    SUBWF REG6, 0
    BZ INCREMENTCOUNT2
    GOTO CHECK3
    
CHECK3 
    MOVF REG3, 0
    SUBWF REG7, 0
    BZ INCREMENTCOUNT3
    GOTO CHECK4
    
CHECK4
    MOVF REG4, 0
    SUBWF REG8, 0
    BZ INCREMENTCOUNT4
    
DONE1
    GOTO WT_CNT
    
;*******************************************************************************
; Subroutines: WT_CNT
;*******************************************************************************
WT_CNT
    ;UsInG same registers as declared above.
   COUNT_WHITE EQU 0x67
   MOVLW 0H
   MOVWF COUNT_WHITE
   GOTO CHECKW1

INCREMENT_WHITE
   INCF COUNT_WHITE
   MOVLW -1H
   MOVWF REG1
   GOTO CHECKW2

INCREMENT_WHITE2
   INCF COUNT_WHITE
   MOVLW -1H
   MOVWF REG2
   GOTO CHECKW3
   
INCREMENT_WHITE3
   INCF COUNT_WHITE
   MOVLW -1H
   MOVWF REG3
   GOTO CHECKW4
   
INCREMENT_WHITE4
   INCF COUNT_WHITE
   MOVLW -1H
   MOVWF REG4
   GOTO DONE2
   
CHECKW1
   ;Compare reg1 with 6 7  and8
   MOVF REG1, 0
   SUBWF REG6, 0
   BZ INCREMENT_WHITE
   MOVF REG1, 0
   SUBWF REG7, 0
   BZ INCREMENT_WHITE
   MOVF REG1, 0
   SUBWF REG8, 0
   BZ INCREMENT_WHITE
   GOTO CHECK2
CHECKW2
   ;COMPARE REG2 WITH 5 7 AND 8
   MOVF REG2,0
   SUBWF REG5, 0
   BZ INCREMENT_WHITE2
   MOVF REG2,0
   SUBWF REG7, 0
   BZ INCREMENT_WHITE2
   MOVF REG2,0
   SUBWF REG8, 0
   BZ INCREMENT_WHITE2
   GOTO CHECK3
CHECKW3
   ;COMPARE REG3 WITH 5 6 AND 8
   MOVF REG3, 0
   SUBWF REG5, 0
   BZ INCREMENT_WHITE3
   MOVF REG3, 0
   SUBWF REG6, 0
   BZ INCREMENT_WHITE3
   MOVF REG3, 0
   SUBWF REG8, 0
   BZ INCREMENT_WHITE3
   GOTO CHECK4
CHECKW4
   ;COMPARE REG4 WITH 5 6 AND 7
   MOVF REG4, 0
   SUBWF REG5, 0
   BZ INCREMENT_WHITE4
   MOVF REG4, 0
   SUBWF REG6, 0
   BZ INCREMENT_WHITE4
   MOVF REG4, 0
   SUBWF REG7, 0
   BZ INCREMENT_WHITE4
   GOTO DONE2
   
DONE2
	
    END