.global _start
_start:
	
.text
.global _start	
_start:
		LDR R4, =TEST_NUMS
		MOV R5, #0
MAIN: 
		LDR R1, [R4] 
		ADD R4, #4
		CMP R1, #0
		BEQ MAIN_END 
		BL ONES  
		CMP R5, R0
		MOVLT R5, R0 
		B MAIN

MAIN_END: 	B MAIN_END 

ONES:		MOV R0, #0 
		

L_LOOP:
		CMP R1, #0 // loop until the data contains no more 1’s
		BEQ L_END
		LSR R2, R1, #1 // perform SHIFT, followed by AND
		AND R1, R1, R2
		ADD R0, #1 // count the string lengths so far
		B L_LOOP
L_END: 		MOV PC, LR 
TEST_NUMS: 	.word 0x103fe00f
		.word 0x013ee00f
		.word 0x2100100f
		.word 0x2200001f
		.word 0x2200011f
		.word 0x2200034f
		.word 0x22002843
		.word 0x22000001
		.word 0x22000000
		.word 0x22088000
		.word 0 		