;*******************************************************************************
;                                                                              *
;    Microchip licenses this software to you solely for use with Microchip     *
;    products. The software is owned by Microchip and/or its licensors, and is *
;    protected under applicable copyright laws.  All rights reserved.          *
;                                                                              *
;    This software and any accompanying information is for suggestion only.    *
;    It shall not be deemed to modify Microchip?s standard warranty for its    *
;    products.  It is your responsibility to ensure that this software meets   *
;    your requirements.                                                        *
;                                                                              *
;    SOFTWARE IS PROVIDED "AS IS".  MICROCHIP AND ITS LICENSORS EXPRESSLY      *
;    DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING  *
;    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS    *
;    FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL          *
;    MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL,         *
;    INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO     *
;    YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR    *
;    SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY   *
;    DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER      *
;    SIMILAR COSTS.                                                            *
;                                                                              *
;    To the fullest extend allowed by law, Microchip and its licensors         *
;    liability shall not exceed the amount of fee, if any, that you have paid  *
;    directly to Microchip to use this software.                               *
;                                                                              *
;    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF    *
;    THESE TERMS.                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Filename:                                                                 *
;    Date:                                                                     *
;    File Version:                                                             *
;    Author:                                                                   *
;    Company:                                                                  *
;    Description:                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation    *
;    for information on assembly instructions.                                 *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Known Issues: This template is designed for relocatable code.  As such,   *
;    build errors such as "Directive only allowed when generating an object    *
;    file" will result when the 'Build in Absolute Mode' checkbox is selected  *
;    in the project properties.  Designing code in absolute mode is            *
;    antiquated - use relocatable mode.                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:                                                         *
;                                                                              *
;*******************************************************************************



;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks.  Include your
; device .inc file - e.g. #include <device_name>.inc.  Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X.  You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************

; TODO INSERT INCLUDE CODE HERE

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code.  See the device datasheet for additional information
; on configuration word settings.  Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code.  Go to
; Window > PIC Memory Views > Configuration Bits.  Configure each field as
; needed and select 'Generate Source Code to Output'.  The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************

; TODO INSERT CONFIG HERE

;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)).  Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
;   GPR_VAR        UDATA
;   MYVAR1         RES        1      ; User variable linker places
;   MYVAR2         RES        1      ; User variable linker places
;   MYVAR3         RES        1      ; User variable linker places
;
;   ; Example of using Access Uninitialized Data Section (when available)
;   ; The variables for the context saving in the device datasheet may need
;   ; memory reserved here.
;   INT_VAR        UDATA_ACS
;   W_TEMP         RES        1      ; w register for context saving (ACCESS)
;   STATUS_TEMP    RES        1      ; status used for context saving
;   BSR_TEMP       RES        1      ; bank select used for ISR context saving
;
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE

;*******************************************************************************
; Reset Vector
;*******************************************************************************

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
    COUNT_BLACK EQU 0x57    ;keep tally of black.
    COUNT_WHITE EQU 0x67
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
   GOTO BLK_CNT
   ;BSF PORTB, 3
   
   
   
BLK_CNT  
    ;reg1 - reg4 for code
    ;MOVLB 0x4
    REG1 EQU 0x37   ;MSB
    REG2 EQU 0x38
    REG3 EQU 0x39
    REG4 EQU 0x3A
    ;reg5 - reg8 for guess
    REG5 EQU 0x47
    REG6 EQU 0x48
    REG7 EQU 0x49
    REG8 EQU 0x4A
    BYTE1 EQU 0x07	;not used yet
    BYTE2 EQU 0x08
    MOVLW 0H
    MOVWF COUNT_BLACK, 1
 
    ;Set registers for code with code generated
    ; and set a dummy guess test case
    MOVF DIG1, 0, 1	    ;move dig1 into working register
    MOVWF REG1, 1
    MOVF DIG2, 0, 1
    MOVWF REG2, 1
    MOVF DIG3, 0, 1
    MOVWF REG3, 1
    MOVF DIG4, 0, 1
    MOVWF REG4, 1
    
    ;WHERE GUESS WILL BE STORED.
    MOVLW 1H
    MOVWF REG5, 1
    MOVWF REG6, 1
    MOVWF REG7, 1
    MOVWF REG8, 1
    
    GOTO CHECK1
    
;if current check funtion branches, run one of these according 
;to which digit it is comparing. 
INCREMENTCOUNT1
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H		;this is for making sure that we never branch
    MOVWF REG1, 1		;to zero again, so we put an uncomparable value. 
    GOTO CHECK2

;second digit is marked black, then go check third digit. 
INCREMENTCOUNT2
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG2, 1
    GOTO CHECK3
    
INCREMENTCOUNT3
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG3, 1
    GOTO CHECK4
    
INCREMENTCOUNT4
    INCF COUNT_BLACK, 1, 1
    MOVLW -1H
    MOVWF REG4, 1
    GOTO DONE1
    
;code for comparision
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
   ;Using same registers as declared above because
   ;WT_CNT depends works on the results of BLK_CNT
   MOVLW 0H
   MOVWF COUNT_WHITE, 1
   GOTO CHECKW1

INCREMENT_WHITE
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H	;Again store an uncomparable value to keep from
   MOVWF REG1, 1		;double counting. 
   GOTO CHECKW2

INCREMENT_WHITE2
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG2, 1
   GOTO CHECKW3
   
INCREMENT_WHITE3
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG3, 1
   GOTO CHECKW4
   
INCREMENT_WHITE4
   INCF COUNT_WHITE, 1, 1
   MOVLW -1H
   MOVWF REG4, 1
   GOTO DONE2
   
CHECKW1
   ;COMPARE REG1 WITH 6 7 AND 8
   MOVF REG1, 0, 1
   SUBWF REG6, 0, 1
   BZ INCREMENT_WHITE
   MOVF REG1, 0, 1
   SUBWF REG7, 0, 1
   BZ INCREMENT_WHITE
   MOVF REG1, 0, 1
   SUBWF REG8, 0, 1
   BZ INCREMENT_WHITE
   GOTO CHECK2
CHECKW2
   ;COMPARE REG2 WITH 5 7 AND 8
   MOVF REG2,0, 1
   SUBWF REG5, 0, 1
   BZ INCREMENT_WHITE2
   MOVF REG2,0, 1
   SUBWF REG7, 0, 1
   BZ INCREMENT_WHITE2
   MOVF REG2,0, 1
   SUBWF REG8, 0, 1
   BZ INCREMENT_WHITE2
   GOTO CHECK3
CHECKW3
   ;COMPARE REG3 WITH 5 6 AND 8
   MOVF REG3, 0, 1
   SUBWF REG5, 0, 1
   BZ INCREMENT_WHITE3
   MOVF REG3, 0, 1
   SUBWF REG6, 0, 1
   BZ INCREMENT_WHITE3
   MOVF REG3, 0, 1
   SUBWF REG8, 0, 1
   BZ INCREMENT_WHITE3
   GOTO CHECK4
CHECKW4
   ;COMPARE REG4 WITH 5 6 AND 7
   MOVF REG4, 0, 1
   SUBWF REG5, 0, 1
   BZ INCREMENT_WHITE4
   MOVF REG4, 0, 1
   SUBWF REG6, 0, 1
   BZ INCREMENT_WHITE4
   MOVF REG4, 0, 1
   SUBWF REG7, 0, 1
   BZ INCREMENT_WHITE4
   GOTO DONE2
   
DONE2
;initialize the values back to the way they were. 

END