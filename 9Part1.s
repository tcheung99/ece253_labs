.text
.global _start
_start:
	LDR R1, = num_list		// address of list
    LDR R2, [R1],#4 //val of R1, shifting R1 by 4	// number of words in list //goes thru words N times
    MOV R9, R1			
    SUB R3, R2, #1		// number of times to go through inner loop (N-1 times)
    MOV R10, R3
outer_loop: 
	MOV R0, #0
    MOV R3, R10
	CMP R2, #0
    BEQ main_end
    B inner_loop 

inner_loop:
	CMP R3, #0
    BEQ inner_end
    SUB R3, R3, #1
    LDR R5,[R1]
    LDR R4,[R1,#4]
    CMP R5, R4
    BLT swap
    ADD R1,R1,#4
    B inner_loop

swap:	
	STR R4,[R1]
    STR R5,[R1,#0x4]
    ADD R1,R1,#4
    MOV R0,#1
    B inner_loop
    
inner_end:
	SUB R2, R2, #1
    MOV R1,R9		//resetting R1 address back to the first number 
    CMP R0,#0
    BEQ main_end
    B outer_loop

main_end: B main_end
num_list: .word 6, 10,55,4, 9, 3, 5
	