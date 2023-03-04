.data
	pergunta: .asciiz "Forneça seu nome, criatura sub-humana: "
	saida: .asciiz "Tinha que ser "
	name: .space 25
.text
	#imprimir a pergunta
	li $v0, 4
	la $a0, pergunta
	syscall

	#le o nome
	li $v0, 8
	la $a0, name
	la $a1, 25
	syscall
	
	#imprime a resposta
	li $v0, 4
	la $a0, saida
	syscall
	
	#imprime o nome
	li $v0, 4
	la $a0, name
	syscall