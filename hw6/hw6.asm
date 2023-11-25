.include "macros.asm"
.data
input:	.asciz "Введите вашу строку"
input_num:.asciz "Input num of characters to copy"
test_1:	.asciz "&#g6*8"
test_2:	.asciz "f7d3a2"
test_3: .asciz ""

buf1:    .space 100     
buf2:    .space 100     
buf3:    .space 100    
buf4:    .space 100     
buf5:    .space 100     
buf6:    .space 100     

.eqv SIZE 100
.align  2
ans_string:	.space 64

.text
.global main
main:
	la a1 buf1
	la a2 test_1
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, 3)
	print_str_imm("Скопировано первые 3 символа. Скопированная строчка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	newline
	newline
	
	la a1 buf2
	la a2 test_2
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, 100)
	print_str_imm("Скопировано первые 100 символа. Скопированная строчка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	newline
	newline
	
	la a1 buf3
	la a2 test_3
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, 12)
	print_str_imm("Скопировано первые 12 символа. Скопированная строчка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	newline
	newline
	
	# Fourth test
	la a1 buf4
	print_str_imm("Вводимая строку: ")
	li a7 8
	ecall
	mv a2 a0
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, 7)
	print_str_imm("Скопировано первые 7 символа. Скопированная строчка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	
	newline
	
	newline
	
	la a1 buf5
	print_str_imm("Вводимая строку: ")
	li a7 8
	ecall
	mv a2 a0
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, 0)
	print_str_imm("Скопировано 0 символов. копированная строка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	newline
	newline
	
	la a1 buf6
	print_str_imm("Вводимая строку: ")
	li a7 8
	ecall
	mv a2 a0
	
	print_str_imm("Сурс строка \"")
	print_str_reg(a2)
	print_str_imm("\"")
	newline
	
	strncpy(a1, a2, -5)
	print_str_imm("Скопировано первые -5 символов. скопированная строчка \"")
	print_str_reg(a1)
	print_str_imm("\"")
	newline
	
	exit