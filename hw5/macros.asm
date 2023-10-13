# чтение целых чисел
.macro cin_int (%cin_integer)
	li a7 5
	ecall
	mv %cin_integer a0
.end_macro

# вывод фразы
.macro cout_str(%string_output)
.data
	str: .asciz %string_output
.text
	la a0 str
	li a7 4
	ecall
.end_macro

# ввод массива
.macro cin_array (%lab, %size)
	la t0 %lab 
	li t4 0 #счетчик
fill:   
	cin_int(t2)
	sw      t2 (t0)        	     
        addi    t0 t0 4	       	      
        addi    t4 t4 1      
        bltu    t4 %size fill
.end_macro

# сумма массива
.macro sum_array(%lab, %size)		
		la t0 %lab
		li t3 0				
		li t4 0				
		li t5 -2147483648		
		li t6 2147483647		
sum: 
		lw a0 (t0)
		addi t0 t0 4
		addi t4 t4 1   
		bgtz t3 greater
		j less
		less:
				sub t2 t5 t3		
				blt a0 t2 over
				j push
greater:
		sub t2 t6 t3 		
		blt t2 a0 over
		j push
over:
		lw a0 (t0)
		addi t0 t0 4
		addi t4 t4 1
		blt t4 %size over
		push:
				mv a1 t4 		
				add t3 t3 a0  
				blt t4 %size sum
				after_sum:
						mv a0 t3
.end_macro

#вывод целочисленных значений
.macro cout_int(%cout_integer)
	mv a0 %cout_integer
	li a7 1
	ecall
.end_macro

#вывод символов
.macro cout_char(%cout_char)
	li a0 %cout_char
	li a7 11
	ecall
.end_macro 

#конец программы
.macro break
	li a7 10
	ecall
.end_macro