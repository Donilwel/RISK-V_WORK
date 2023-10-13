.include "macros.asm"
.data	
	.align 2
	array: .space 40
.text
main:
	cout_str("Введите длину массива от 1 до 10: ")
	cin_int (s0)	# s0 - запись размера
	
	li a7 1
	blt s0 a7 error
	li a7 10
	bgt s0 a7 error
	
	cin_array(array, s0) # s0 запись
	sum_array(array, s0)  # s0 запись
	
	mv a2 a0 
	beq a1 s0 good_branch
	
	cout_str("Возникло переполение, последняя сумма введенных элементов равно:  ")
	cout_int(a2)
	
	li a7 1
	beq a1 a7 only_one
	
	cout_str(". It is an aggregation of first ")
	cout_int(a1)
	break
	
only_one:
	cout_str(". Это все элементы до переполнения\n")
	break
	
good_branch:
	cout_str("Сумма элементов массива равна:  ")
	cout_int(a2)
	cout_char('\n')
	break
	
error:
	cout_str("Ошибка, некорректная длина массива")
	break