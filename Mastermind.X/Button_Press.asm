RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
#Include p18f46k22.inc
MAIN_PROG CODE                      ; let linker place main program
;*******************************************************************************
;Counter and Switch Press/Release Attempt
;*******************************************************************************
START
    ;store a digit in a seperate file loop. 
    MOVLB 0x5
    DIG1 EQU 0x17
    DIG2 EQU 0x18
    DIG3 EQU 0x19
    DIG4 EQU 0x1A
 
 RELOAD
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
   GOTO RELOAD

WT_RELEASE1
   BTFSS PORTA, 4
   BRA $-2
   GOTO $
   ;BSF PORTB, 3
   
END