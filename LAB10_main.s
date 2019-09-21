	.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
			.text
			.global	_start
_start:
			//initialize IRQ SP 
			MOV R0, #0b10010 					// IRQ mode 
			MSR CPSR, R0 						// switch to IRQ mode 
			LDR SP,=0x20000 					//set IRQ SP 
			//initialize SVC SP
			MOV R0, #0b10011 					//set to SVC mode 
			MSR CPSR, R0
			LDR SP,= 0x3FFFFFFC

			BL			CONFIG_GIC				// configure the ARM generic interrupt controller
			BL			CONFIG_PRIV_TIMER		// configure the MPCore private timer
			BL			CONFIG_KEYS				// configure the pushbutton KEYs
			
			// enable ARM processor interrupts ...
			MSR 		CPSR, #0b01010011		// change 7th bit to 0 in SVC mode (changing interrupt bit in CPSR to accept interrupts)  


			LDR		R6, =0xFF200000 			// red LED base address
MAIN:
			LDR		R4, LEDR_PATTERN			// LEDR pattern; modified by timer ISR
			STR 		R4, [R6] 				// write to red LEDs
			B 			MAIN



/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
			LDR		R0, =0xFFFEC600 			// Timer base address
			LDR		R1, =20000000				// timeout = 1/(200 MHz) x 2x10^7 = 0.1 sec	
				STR		R1, [R0]				// write to timer load register (load value)
				MOV		R1, #0b111				// set bits: int = 1, mode = 1 (auto), enable = 1
				STR		R1, [R0, #0x8]			// write to timer control register
			MOV 		PC, LR 					// return

/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
			LDR 		R0, =0xFF200050 		// KEYs base address
			MOV			R1, #0xF				// set interrupt mask bits to 1 (to enable)
			STR			R1, [R0, #0x8]			// interrupt mask register is (base + 8)
			MOV 		PC, LR 					// return

			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0							// 0 means left, 1 means right

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x1
