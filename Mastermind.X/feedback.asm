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
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families.  On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively.  On PIC16's and
; lower the interrupt is at 0x0004.  Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR       CODE    0x0004           ; interrupt vector location
;
;     <Search the device datasheet for 'context' and copy interrupt
;     context saving code here.  Older devices need context saving code,
;     but newer devices like the 16F#### don't need context saving code.>
;
;     RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
; ISRHV     CODE    0x0008
;     GOTO    HIGH_ISR
; ISRLV     CODE    0x0018
;     GOTO    LOW_ISR
;
; ISRH      CODE                     ; let linker place high ISR routine
; HIGH_ISR
;     <Insert High Priority ISR Here - no SW context saving>
;     RETFIE  FAST
;
; ISRL      CODE                     ; let linker place low ISR routine
; LOW_ISR
;       <Search the device datasheet for 'context' and copy interrupt
;       context saving code here>
;     RETFIE
;
;*******************************************************************************

; TODO INSERT ISR HERE

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
#Include    p18f46k22.inc  
MAIN_PROG CODE                      ; let linker place main program

START                   ; let linker place main program
 ;arbitrary guess
 ;LOC EQU 0x00
 ;LFSR 0, 0x00
 ;MOVLW 3H
 ;MOVWF INDF0
 
 ;R2 EQU 0x20
 ;MOVLW 0CH
 ;MOVWF R2
 ;MOVLW 3H
  
 ;LOOP
 ;INCF FSR0L, F
 ;MOVWF INDF0
 ;DECF R2
 ;BNZ LOOP    ;initializing a line of memory with just 3, we read this into the
	      ;guess we made. 
 
       
    R1 EQU 0x00
    R2 EQU 0x01
    ;R3 EQU 0x02
    ;R4 EQU 0x03
 
    MOVLW 10H
    MOVWF R2
 ;1st bit of guess
    MOVLW 0BH
    MOVWF R1
    LFSR 0, 0x12
    MOVLW 1H      ;wreg has 1 and will be put in all 12 cells
    MOVWF INDF0   ;put in first cell
LOOP1		    ;loop for the rest
    LOOP1A
	INCF FSR0L, F
	DECF R2
	BNZ LOOP1A
    ;Reset R2 counter for nested loop
    MOVLW 10H
    MOVWF R2
    ;update what we want to store next
    MOVLW 1H
    MOVWF INDF0	    
    DECF R1
    BNZ LOOP1
    
;2nd bit guess
    MOVLW 10H
    MOVWF R2
    MOVLW 0BH
    MOVWF R1
    LFSR 0, 0x13
    MOVLW 1H      
    MOVWF INDF0
    
LOOP2		    
    LOOP2A
	INCF FSR0L, F
	DECF R2
	BNZ LOOP2A
	
    MOVLW 10H
    MOVWF R2
    MOVLW 1H
    MOVWF INDF0	    
    DECF R1
    BNZ LOOP2
    
 ;3rd bit of guess
    MOVLW 10H
    MOVWF R2
    MOVLW 0BH
    MOVWF R1
    LFSR 0, 0x14
    MOVLW 1H      
    MOVWF INDF0
    
LOOP3		    
    LOOP3A
	INCF FSR0L, F
	DECF R2
	BNZ LOOP3A
	
    MOVLW 10H
    MOVWF R2
    MOVLW 1H
    MOVWF INDF0	    
    DECF R1
    BNZ LOOP3
    
;4th bit of guess
    MOVLW 10H
    MOVWF R2
    MOVLW 0BH
    MOVWF R1
    LFSR 0, 0x15
    MOVLW 1H      
    MOVWF INDF0
    
LOOP4		    
    LOOP4A
	INCF FSR0L, F
	DECF R2
	BNZ LOOP4A
	
    MOVLW 10H
    MOVWF R2
    MOVLW 1H
    MOVWF INDF0	    
    DECF R1
    BNZ LOOP4
    
;Code for counter (Kevins method)
;store a digit in a seperate file loop. 
    DIG1 EQU 0x17
    DIG2 EQU 0x18
    DIG3 EQU 0x19
    DIG4 EQU 0x1A
    MOVLW 5H
    MOVWF DIG1
    MOVWF DIG2
    MOVWF DIG3
    MOVWF DIG4
    
    
LOOP1b
MOVWF DIG2
    LOOP2b
    MOVWF DIG3
	LOOP3b
	MOVWF DIG4
	    LOOP4b
		DECF DIG4
		BNZ LOOP4b
	DECF DIG3
	BNZ LOOP3b
    DECF DIG2
    BNZ LOOP2b
DECF DIG1
BNZ LOOP1b

    
GOTO BLK_CNT
    
;subroutine BLK_CNT
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
;code segment for loop that reads 12 guesses. 
GUESS_COUNTER EQU 0x02
MOVLW 0H
MOVWF GUESS_COUNTER
 
 ;variable to store unpacked guess bytes
GUESS_BYTE1 EQU 0x03
GUESS_BYTE0 EQU 0x04
 
;;GUESS_LOOP
   
    

   
;CODE FOR THE COUNTER (The cursed code)
   ;R4 EQU 0x03 
    ;MOVLW 5H	    ;countdown from 5 to 0
    ;MOVWF R3
    ;MOVLW 5H	    ;COUNTER FOR OUTERLOOP
    ;MOVWF R4 
   ; LFSR 0, 0x11
  ;  MOVLW 37H	    ;55 IN DECIMAL
 ;   MOVWF INDF0
;OUTER
    ;update what is in r3
    ;MOVLW 5H 
    ;SUBWF INDF0, 1
    ;MOVLW 5H
    ;MOVWF R3
   ;INNER
	;DECF INDF0, F
	;DECF R3
	;BNZ INNER
	;32H
    ;DECF R4
    ;BNZ OUTER   ;CURRENT BUG, IT STOPS AT 05 INSTEAD OF 00
    

    END