.include "macros.asm"
.data
	.align 2
	A: .space 40
	B: .space 40
.text
main:
	cout_str("Введите размер массива (от 1 до 10): ")
	cin_integer(s1) # s1 stores the size of the array
	check_if(s1)
	
	cout_str("Введите элементы массива:")
	cout_char('\n')
	cin_array(A, s1)
	
	cout_str("Введенный массив: ")
	cout_char('\n')
	cout_array(A, s1)
	cout_char('\n')
	
	cout_str("Новый массив: ")
	cout_char('\n')
	create_array_b(A, B, s1)
	cout_array(B, s1)
	
	stop

error:
	cout_str("Ошибка, количество элементов в массиве не лежит в диапазоне от 1 до 10")
	stop