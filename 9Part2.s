//PSUEDOCODE
//INITIALIZE ALL THE THINGS (PORTS) NECESSARY
//LOAD THE 10000... INTO THE KEYS (LED POSITIONS)
//SHIFT THIS TO THE RIGHT OR LEFT ACCORDINGLY (HAVE A DIRECTION INDICATOR AND 
//POSITION INDICATOR)
//ALWAYS CHECK IF KEYS ARE PRESSED
//IF KEYS ARE PRESSED THEN WAIT UNTIL KEYS RELEASED THEN PAUSE (TIMER)
//IF NOT CONTINUE WITH LOOP
		.text
		.global _start
_start:
		LDR 	SP, = 0x20000		// initialize stack pointer location
		LDR 	R5, = 0xFF200000	// address of ledr lights
		LDR 	R6, = 0xFF200050	// address of keys
		LDR 	R0, = 0xFFFEC600	// address of timer
		
		MOV 	R7, #0b1000000000	// indicates which led to light up (start at 9)
		LDR 	R10, = 0			// counter for position of led (when reach 9, change direction)
		LDR 	R11, = 0			// direction indicator 0 = right, 1 = left
		
loop:	
		STR 	R7, [R5]			// light up ledr as indicated by 7 
		CMP 	R11, #0				// check which direction to move nnext
		LSREQ 	R7, R7, #1			// if r7 = 0 move right
		LSLNE 	R7, R7, #1			// else move left
		ADD 	R10, #1				// count up one as youve moved over one position
		CMP 	R10, #9				// check if reach end of line 
		BEQ 	change_direction	//if so change directions
		BNE 	continue			//otherwise continue
		
change_direction:
		CMPEQ 	R11, #0				//check current direction
		LDREQ 	R11, = 1			//if right, change to left
		LDRNE 	R11, = 0			//if left change to right
		LDR 	R10, = 0			// reinitialize position counter to zero
		
continue:
		BL 		start_timer			//start the timer
		LDR 	R9, = 0				// initialize variable to count if key is pressed down
		LDR 	R8, [R6]			//read the keys
		CMP 	R8, #0				// see if any are pressed down
		BLNE 	wait				// if any are pressed, stop/pause/wait
		CMP 	R9, #0				// see if key was pressed before
		BLNE 	start_pause			//if no, start pausing
		
		
		B 		loop					//BRANCH BACK TO LOOP
		
		
main_end:	
		B		main_end

wait:
		LDR 	R8, [R6]			//load/read the keys
		CMP 	R8, #0				//see if any are pressed
		BNE 	wait				//if so, keep waiting
		LDR 	R9,= 1				//flag indicates key was already, but no longer pressed
		MOV 	PC, LR				//go back to wherever this branch was called in
		

start_pause:
		PUSH 	{LR}				// store the linked address
pause:	LDR 	R8, [R6]			// load/read keys
		CMP 	R8, #0				// check if any are pressed
		BEQ 	pause				// if not pressed, continue pausing
		BLNE 	wait 				// if pressed, go back to the waiting loop until key is no longer pressed
		POP 	{LR}				// retreive stacked address
		MOV 	PC, LR				//return to the original linked address (in stack)
		
start_timer:	
		LDR 	R1, = 20000000		// initialize load value for 20MHz timer->1 second
		STR 	R1, [R0]			// load this value to timer
		MOV 	R1, #0b011			// initialize conditions A = 1, E = 1
		STR 	R1, [R0,#8]			// load this value to the control of timer
  
delay:	LDR 	R1, [R0,#0xC]		// load the interupt signal 
		CMP 	R1, #0b0			// check to see when timer is done
		BEQ		delay				
		STR 	R1, [R0,#0xC]		// if "time", returtn to the continue/main 
		MOV 	PC, LR
		
		.end