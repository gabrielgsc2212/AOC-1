.data
	msgsucess: .asciiz "Sucesso!\n\n"
	pergunta: .asciiz "Escolha sua opcao: \n 1-Catalogar \n 2-Consultar \n 3-Sair \n"
	opcon: .asciiz "Consultar por: \n 1-Nome \n 2-Atributo\n"
	cat1: .asciiz "Insira o nome da criatura: "
	cat2: .asciiz "Insira a forca: "
	cat3: .asciiz "Insira a inteligencia: "
	cat4: .asciiz "Insira a velocidade: "
	cons1: .asciiz "Insira o nome da criatura a ser procurada:\n"
	cons2: .asciiz "Criatura encontrada!\n"
	cons2.1: .asciiz "Força: "
	cons2.2: .asciiz "Inteligencia: "
	cons2.3: .asciiz "Velocidade: "
	cons3: .asciiz "Criatura não encontrada!\n"
	jumplinha: .asciiz "\n"
	forca: .word  1, 2, 3, 4, 5, 6
	.space 16
	inteligencia: 1, 2, 3, 4, 5, 6
	.space 16
	velocidade: 1, 2, 3, 4, 5, 6
	.space 16
	criaturas: .asciiz "Goblin", "Humano", "Elfo", "Orc", "Hidra", "Minotauro"
.text
	comeco:
		la $a0, pergunta
		jal escreveString
		li $v0, 5
		syscall

		beq $v0, 1, catalogar	#Faz o pulo para a opcao selecionada
		beq $v0, 2, consultar
		beq $v0, 3, sair
	
	catalogar:		#Cataloga criatura"
		la $a0, cat1
		jal escreveString		
		li $v0, 8
		la $a1, 25
		for:
			lb $t1, criaturas($t0)
			beq $t1, 0, fimVetor
			addi $t0,$t0, 1
			j for
		fimVetor:
			addi $t0,$t0, 1
			lb $t1, criaturas($t0)
			beq $t1, 0, fimVetorTrue
			j for
		fimVetorTrue:
			la $a0, criaturas($t0)
			syscall
		
		
			la $a0, cat2
			jal escreveString
			
			li $v0, 5	#Le a forca
			syscall
		
			move $t1, $v0
			la $t0, forca
		
		loop:
			lw $t2, 0($t0)
			beq $t2, 0, fimForca
			addi $t0, $t0, 4
			j loop
			
		fimForca:
			addi $t0, $t0, 4
			lw $t2, 0($t0)
			bne $t2, 0, loop
			addi $t0, $t0, -4
	
			sw $t1, 0($t0)
		
			la $a0, cat3
			jal escreveString
			
		
			li $v0, 5	#Le a inteligencia 
			syscall
		
			move $t1, $v0
			la $t0, inteligencia
		
		loop2:
			lw $t2, 0($t0)
			beq $t2, 0, fimIntel
			addi $t0, $t0, 4
			j loop2
			
		fimIntel:
			addi $t0, $t0, 4
			lw $t2, 0($t0)
			bne $t2, 0, loop2
			addi $t0, $t0, -4
	
			sw $t1, 0($t0)
		
			la $a0, cat4
			jal escreveString
			
			li $v0, 5	#Le a velocidade
			syscall
		
			move $t1, $v0
			la $t0, velocidade
		
		loop3:
			lw $t2, 0($t0)
			beq $t2, 0, fimVel
			addi $t0, $t0, 4
			j loop3
		fimVel:
			addi $t0, $t0, 4
			lw $t2, 0($t0)
			bne $t2, 0, loop3
			addi $t0, $t0, -4
	
			sw $t1, 0($t0)
		
			la $a0, msgsucess
			jal escreveString
		
			j comeco
			
			
			
				
			
			
			
	consultar:		#Consulta "criatura"
		la $a0, cons1
		jal escreveString
			
		li $t8, 4
		li $t9, 0
		
		move $t6, $sp
		li $v0, 8
		li $a1, 25
		la $a0, 0($sp)
		syscall
		j loop5

	preloop: 
		addi $t9, $t9, 1
		move $sp, $t6
		addi $t4, $t4, 1
		move $t7, $t0
		addi $t0, $t0, 1
		
	loop5:
		lb $t1, criaturas($t0)		#compara byte a byte os nomes 
		lb $t2, 0($sp)
		beq $t1, 0, fimBusca
		bne $t1, $t2, contagem		#caso sejam diferente vai para contagem 
		addi $t0, $t0, 1
		addi $sp, $sp, 1		
		j loop5
	contagem:
		addi $t4, $t4, 1
	contagem2:
		addi $t0, $t0, 1
		addi $t4, $t4, 1			#percorre toda a string ate um \0
		lb $t1, criaturas($t0)		#assim que acabar a string vai para preloop
		beq $t1, 0, preloop
		j contagem2
		
	fimBusca:				
		mult $t9, $t8
		mflo $t9
		
		lw $s2, forca($t9)
		beq $s2, $zero, semResult	#confere se existem status listados na criatura
		
		sw $s2, forca($t9)		#retorna o valor utilizado na comparaçao pra memoria
		la $a0, cons2
		jal escreveString

		la $a0, cons2.1
		jal escreveString
		li $v0, 1
		lw $a0, forca($t9)
		syscall
				
		la $a0, jumplinha
		jal escreveString
				
		la $a0, cons2.2
		jal escreveString
		li, $v0, 1
		lw $a0, inteligencia($t9)
		syscall
				
		la $a0, jumplinha
		jal escreveString
				
		la $a0, cons2.3
		jal escreveString
		li, $v0, 1
		lw $a0, velocidade($t9)
		syscall
		
		la $a0, jumplinha
		jal escreveString
		
		j sair
		
		
	semResult:	#caso o nome da criatura nao esteja listado
		la $a0, cons3
		jal escreveString
		
		j sair
		
				
	sair:
		li $v0, 10
		syscall

	escreveString:
		li $v0, 4
		syscall
		jr $ra
