.data
	inicio: .asciiz "Digite um n�mero: "
	par: .asciiz "O n�mero � par."
	impar: .asciiz "O n�mero � impar."

.text
		li $v0, 4
		la $a0, inicio
		syscall
	
		li $v0, 5
		syscall
		move $t0, $v0
		
		li $t1, 2
		div $t0, $t1
		mfhi $t2
		
		beq  $t2, $zero, label
	
		li $v0, 4
		la $a0, impar
		syscall
		li $v0, 10
		syscall
	
label:	li $v0, 4
		la $a0, par
		syscall
		li $v0, 10
		syscall