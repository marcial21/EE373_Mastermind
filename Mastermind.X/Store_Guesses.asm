
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
#Include    p18f46k22.inc  
MAIN_PROG CODE

START 

    GUESS1 EQU 0x00
    GUESS2 EQU 0x01
    GUESS3 EQU 0x02
    GUESS4 EQU 0x03
 
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
    
    
    END