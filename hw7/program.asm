.include "macros.asm"

.text
.global subroutine
subroutine:
		li s1 -1
	li t1 1
	print_str("Введите отрицательные номера чтобы выйти из программы\n")
loop:	
	bgtz t1 right
	j left
right:
	li a1 0xffff0011
	li a0 0
	sb a0 (a1)
	li a1 0xffff0010
	
	j print
left:
	li a1 0xffff0010
	li a0 0
	sb a0 (a1)
	
	li a1 0xffff0011
print:
	li a0 128
	sb a0 (a1)
	readInt
	
	bltz a0 end
	change_num_dig(a0)
	sb a0 (a1)
	sleep(1000)
	
	mul t1 t1 s1
	j loop
end:
	ret