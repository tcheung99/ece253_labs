/***************************************************************************************
 * Pushbutton - Interrupt Service Routine                                
 *                                                                          
 * This routine checks which KEY has been pressed.  If KEY3 it stops/starts the timer.
****************************************************************************************/
					.global	KEY_ISR
KEY_ISR: 		LDR		R0, =KEY_BASE			// base address of KEYs parallel port
					LDR		R1, [R0, #0xC]			// read edge capture register (stores status of KEYs) 
					STR		R1, [R0, #0xC]			// clear the interrupt
					
CHK_KEY3:		TST R1, #0b1000					//TST compares R1 and 1000. If result is 0 (key3 not pressed) then Z=1 and EQ flag is set.
				BEQ END_KEY_ISR

START_STOP:		LDR		R0, =MPCORE_PRIV_TIMER		// timer base address
					LDR		R1, [R0, #0x8]			// read timer control register
					MOV R3, #1
					EOR R1, R3						//changes enable to 1 if it's originally a 0 and vice versa, and stores that into R1
					STR R1, [R0, #0x8]				//stores R1 into timer control register

END_KEY_ISR:	MOV	PC, LR
					.end
	
