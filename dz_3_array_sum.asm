.data
	new_stroka: .asciz "\n"
	mess_1:   .asciz "Введите длину массива от 1 до 10: "
	sum_mess: .asciz "Сумма элементов массива равна: "
	count1_mess: .asciz "Количество четных элементов массива: "
	count2_mess: .asciz "Количество нечетных элементов массива: "
	error_mess: .asciz "Ошибка, некорректная длина массива"
	error_over:  .asciz "Сумма элементов до переполнения: "
	rez_over:  .asciz "Количество элементов до переполнения: "
	.align 2	
	array: .space 40
.text
	la 	a0 mess_1
	li 	a7 4
	ecall
	
	li 	a7 5
	ecall
	mv 	s4 a0 			# Размер массива
	
	li 	s5 0
	la 	s1 array  
	li 	t6 0			# Сумма элементов массива 
	
	li 	a7 1
	blt 	s4 a7 error
	li 	a7 10
	bgt 	s4 a7 error
	li 	a7 5
fill:   
	ecall 
	mv 	t2 a0
	sw      t2 (s1)         	# Запись числа по адресу в t2
        addi    s1 s1 4	       	
        addi    s5 s5 1      
        bltu    s5 s4 fill      	# Если не вышли за границу массива
	la 	s1 array
	li 	s5 0
	li 	t0 -2147483648		# Минимальный инт
	li 	t1 2147483647		# Максимальный инт
sum: 
	lw 	a0 (s1)
	addi 	s1 s1 4
	addi 	s5 s5 1   
	bgtz 	t6 greater		# Если больше нуля введено
	bltz 	t6 less			# Если меньше нуля введено
	
	less:
		sub t5 t0 t6		
		mv  s0 s5
		blt a0 t5 over_flow
		
		add 	t6 t6 a0   	# Добавление
		blt 	s5 s4 sum
	j summator
	
	greater:
		sub t5 t1 t6 	
		mv  s0 s5
		blt t5 a0 over_flow
		
		add 	t6 t6 a0   	# Добавление
		blt 	s5 s4 sum
	j summator
	
j summator

summator:				# Суммируем
	la 	a0 sum_mess
	li 	a7 4
	ecall
	li 	a7 1
	mv 	a0 t6
	ecall
	la   	a0 new_stroka
  	li   	a7 4
  	ecall
  	
  	li 	s5 0
	li 	t2 0				# Количество четных элементов
	li 	t5 0				# Количество нечетных элементов
	la 	s1 array
j counter
        
        
end:	
	la 	a0 count2_mess
	li 	a7 4
	ecall
	
	li 	a7 1
	mv 	a0 t5
	ecall
	
	la   	a0 new_stroka
  	li   	a7 4
  	ecall
	
	la 	a0 count1_mess
	li 	a7 4
	ecall
	
	li 	a7 1
	mv 	a0 t2
	ecall
	
	la   	a0 new_stroka
  	li   	a7 4
  	ecall
	
	j stop

error:
	la 	a0 error_mess
	li 	a7 4
	ecall
j stop

odd:						# Проверка на нечетность
	addi 	t5 t5 1	
	blt 	s5 s4 counter
 j end
        
even:						# Проверка на четность
	addi 	t2 t2 1	
	blt 	s5 s4 counter
j end

over_flow:					# Вывод всего если произошло переполнение
	lw 	a0 (s1)
	addi 	s1 s1 4
	addi 	s5 s5 1
	blt 	s5 s4 over_flow
	
	la 	a0 error_over
	li 	a7 4
	ecall
	
	mv 	a0 t6
	li 	a7 1
	ecall
	
	la   	a0 new_stroka
  	li   	a7 4
  	ecall
	
	la 	a0 rez_over
	li 	a7 4
	ecall
	
	li 	a7 1
	sub 	s0 s0 a7
	mv 	a0 s0
	ecall
	
	la   	a0 new_stroka			# Вывод на некст строку
  	li   	a7 4
  	ecall

	li 	s5 0
	li 	t2 0				# Количество четных элементов
	li 	t5 0				# Количество нечетных элементов
	la 	s1 array
j counter

counter: 
	lw 	a0 (s1)
	addi 	s1 s1 4
	addi 	s5 s5 1   
	li 	a7 2
	rem 	a6 a0 a7
	beqz 	a6 even
	bnez 	a6 odd
	
	blt 	s5 s4 counter
j end
	
stop:						# Конец программы
	li 	a7 10
	ecall
