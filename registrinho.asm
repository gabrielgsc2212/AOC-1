.data 
	comeco: .asciiz "Oi!! Qual seu nome? "
	name: .space 25
	meio1: .asciiz "Bem vindo(a) ao clube "
	meio2: .asciiz "Quantos anos você tem? "
	fim: .asciiz "... Ok, anotado, pode ir! Até mais "
.text
	#imprime a primeira pergunta
	li $v0, 4
	la $a0, comeco
	syscall
	
	#le a primeira resposta
	li $v0, 8
	la $a0, name
	la $a1, 25
	syscall
	
	#imprime as boas vindas
	li $v0, 4
	la $a0, meio1
	syscall
	
	#imprime o nome do usuario
	li $v0, 4
	la $a0, name
	syscall
	move $t0, $a0
	
	#imprime a segunda pergunta
	li $v0, 4
	la $a0, meio2
	syscall
	
	#le a idade do usuario
	li $v0, 5
	syscall
	move $t0, $v0
	
	#retorna a idade do usuario
	li $v0, 1
	move $a0, $t0
	syscall
	
	#termina o dialogo
	li $v0, 4
	la $a0, fim
	syscall
	
	#escreve o nome do usuario uma ultima vez
	move $a0, $t0
	li $v0, 4
	la $a0, name
	la $a1, 25
	syscall	