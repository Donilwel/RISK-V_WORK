#читаем массив и записываем элементы
.macro cin_array(%arr, %si_re)
	push(t0)
	push(s0)
	la t0 %arr
	li s0 0 #счетчик
loop:
	bge s0 %si_re break
	cin_integer(a1)
	sw a1(t0)
	addi t0 t0 4
	addi s0 s0 1
	j loop
break:
	pop_reg(s0)
	pop_reg(t0)
.end_macro

#выводим элементы массива
.macro cout_array(%arr, %si_re)
	push(t0)
	push(s0)
	la t0 %arr
	li s0 0 #счетчик
loop:
	bge s0 %si_re break #если счестчик больше размерности -> выходим
	lw a0(t0)
	cout_int(a0)
	cout_char(' ')
	addi s0 s0 1
	addi t0 t0 4
	j loop
break:
	pop_reg(s0)
	pop_reg(t0)
.end_macro

# Создание массива В из элементов массива А по условию который расположен в варианте 30
.macro create_array_b(%arr_a, %arr_b, %si_re)
	push(t0)
	push(t1)
	push(s0)
	la t0, %arr_a     # t0 - массив A
	la t1, %arr_b     # t1 - массив B
	li s0, 0          # s0 - индекс итерации
	li a1, 0          # a1 - предыдущее значение

loop:
	bge s0, %si_re, break   # Если индекс достиг максимального значения, выходим из цикла
	
	lw a0, 0(t0)            # Загрузка текущего элемента массива A
	sub t2, a0, a1          # Вычисление разницы текущего элемента и предыдущего

	bgtz t2, greater        # Если разница больше 0, переходим к метке greater

	addi s0, s0, 1          # Увеличение индекса итерации
	addi t0, t0, 4          # Увеличение адреса массива A
	j loop                  # Переход к началу цикла

greater:
	sw a0, 0(t1)            # Сохранение текущего элемента в массив B
	addi s0, s0, 1          # Увеличение индекса итерации
	addi t0, t0, 4          # Увеличение адреса массива A
	addi t1, t1, 4          # Увеличение адреса массива B
	mv a1, a0             # Сохранение значения текущего элемента как предыдущего
	j loop                  # Переход к началу цикла

break:
	pop_reg(t0)
	pop_reg(t1)
	pop_reg(s0)
.end_macro

# Вариант 30 (создание массива В по условию этого варианта)
.macro checker # в а0 будет содержаться текущий элемент массива А
	#тут будет находиться условие нового массива
.end_macro

# считывание int с клавиатуры 
.macro cin_integer(%val)
	push(a0)
	li a7 5
	ecall
	mv %val a0
	pop_reg(a0)
.end_macro

# Запись в регистр a0 элемента введенного с клави
.macro cin_integer_a0
	li a7 5
	ecall
.end_macro

#вывод int 
.macro cout_int(%int_reg)
	push(a0)
	li a7 1
	mv a0 %int_reg
	ecall
	pop_reg(a0)
.end_macro

#вывод сообщения
.macro cout_str(%str)
.data
	str: .asciz %str
.text
	push(a0)
	la a0 str
	li a7 4
	ecall
	pop_reg(a0)
.end_macro

#вывод элемента
.macro cout_char(%chr)
	push(a0)
	li a7 11
	li a0 %chr
	ecall 
	pop_reg(a0)
.end_macro

#сохраняем регистр на стек
.macro push(%value)
	addi	sp sp -4
	sw	%value (sp)
.end_macro

#pop данного значения на регистр 
.macro pop_reg(%value)
	lw	%value (sp)
	addi	sp sp 4
.end_macro

#проверка длины массива на корректность
.macro check_if(%input)
	li a7 1
	blt %input a7 error
	li a7 10
	bgt %input a7 error
.end_macro 

# выход из программы
.macro stop
	li a7 10
	ecall
.end_macro