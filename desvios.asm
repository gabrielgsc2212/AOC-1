.data 
	y: .space 4

.text
	lui $t0, 0x1001
	li $t1, 1
	
Loop:	beq $t1, 334, Fim
	add $t2, $t2, $t1
	addi $t1, $t1, 1
	j Loop
Fim:	
	