.text 
.global _start

_start: 
		LDR R4, = TEST_NUMS 
		MOV R5, #0
		MOV R6, #0
		MOV R7, #0

MAIN: 
		LDR R1, [R4]
		
				
//Longest 1's 
		BL ONES 
		CMP R5, R0 
		MOVLT R5, R0 

//Longest 0's 
		BL ZEROS
		CMP R6, R0 
		MOVLT R6, R0 	

//Longest 10's 
		BL ALTERNATE
		CMP R7, R0 
		MOVLT R7, R0 
		
		CMP R4, #0
		BEQ MAIN_END		
		ADD R4, #4
		MOV R5, #0
		MOV R6, #0
		MOV R7, #0
		B MAIN

MAIN_END:	B MAIN_END 

ONES: 		MOV R0, #0 //Reset counter to 0 

O_LOOP:		CMP R1, #0 //Check if R1 contains 1's, keep shifting them out	 
		BEQ O_END 
		LSR R2, R1, #1  //Shift R1 one to the right and store in R2 
		AND R1, R2, R1 	//Mask out non-consecutive 1's 
		ADD R0, #1 
		B O_LOOP

O_END: 		MOV PC, LR //Return to next address after branch from MAIN 

ZEROS: 		MOV R0, #0 //Reset counter to 0 
		LDR R1, [R4]
		MVN R1, R1 //Set R1 to its complement

Z_LOOP: 	CMP R1, #0 //Check if R1 contains 1's, keep shifting them out	 
		BEQ Z_END 
		LSR R2, R1, #1  //Shift R1 one to the right and store in R2 
		AND R1, R2, R1 	//Mask out non-consecutive 1's 
		ADD R0, #1 
		B Z_LOOP

Z_END: 		MOV PC, LR 

ALTERNATE: 	MOV R0, #0 //Reset counter to 0 
		LDR R3, = 0xAAAAAAAA //Set to alternating 1010...
		

A_LOOP: 	LDR R1, [R4]
		EOR R1, R3, R1 //Consecutive 10's will be the longest consecutive 0's or 1's stored in R1 now 
		B A_ONES //Branch to ones code 
		

A_ONES: 	CMP R1, #0 //Check if R1 contains 1's, keep shifting them out	 
		BEQ A_RESET 
		LSR R2, R1, #1  //Shift R1 one to the right and store in R2 
		AND R1, R2, R1 	//Mask out non-consecutive 1's 
		ADD R0, #1 
		B A_ONES

A_RESET: 	LDR R1, [R4]
		EOR R1, R3, R1 
		MVN R1, R1
		MOV R9, #0 
		B A_ZEROS 

A_ZEROS:	CMP R1, #0 //Check if R1 contains 1's, keep shifting them out	 
		BEQ ALTERNATE_END 
		LSR R2, R1, #1  //Shift R1 one to the right and store in R2 
		AND R1, R2, R1 	//Mask out non-consecutive 1's 
		ADD R9, #1 
		B A_ZEROS	

ALTERNATE_END:	CMP R0, R9 
		MOVLT R0, R9 
		MOV PC, LR 

TEST_NUMS: 	.word 0x103fe00f // 0001 0000 0011 1111 1110 0000 0000 1111
		.word 0x12345678 // 0001 0010 0011 0100 0101 0110 0111 1000
		.word 0x89ABCDEF // 1000 1001 1010 1011 1100 1101 1110 1111
		.word 0x00000000 // 0000
		.word 0x122d9561 // 0001 0010 0010 1101 1001 0101 0110 0001
		.word 0xca526d2a // 1100 1010 0101 0010 0110 1101 0010 1010
		.word 0x9f0cb7f4 // 1001 1111 0000 1100 1011 0111 1111 0100
		.word 0xbb437342 // 1011 1011 0100 0011 0111 0011 0100 0010
		.word 0xF0F0F0F0 // 1111 0000 1111 0000 1111 0000 1111 0000
		.word 0x88886868 // 1000 1000 1000 1000 0110 1000 0110 1000

		