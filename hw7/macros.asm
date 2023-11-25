.macro print_str(%strim)
.data
	str: .asciz %strim
.text
	push(a0)
	push(a7)
	la a0 str
	li a7 4
	ecall
	pop(a7)
	pop(a0)
.end_macro

.macro sleep(%timee)
	push(a0)
	push(a7)
	li a0 %timee
	li a7 32
	ecall
	
	pop(a7)
	pop(a0)
.end_macro

.macro readInt
	push(a7)
	li a7 5
	ecall
	pop(a7)
.end_macro

.macro change_num_dig(%nure)
	push(s10)
	li s10 16
	blt %nure s10 dig_only
	j need_to_divide
	
dig_only: 
	change_dig_dig(%nure)
	j end
	
need_to_divide:
	rem %nure %nure s10
	change_dig_dig(%nure)
	addi %nure %nure 128
end:
.end_macro

.macro change_dig_dig(%nure)
	beqz a0 is_zero
	
	addi a0 a0 -1
	beqz a0 is_one
	addi a0 a0 1
	
	addi a0 a0 -2
	beqz a0 is_two
	addi a0 a0 2
	
	addi a0 a0 -3
	beqz a0 is_three
	addi a0 a0 3
	
	addi a0 a0 -4
	beqz a0 is_four
	addi a0 a0 4
	
	addi a0 a0 -5
	beqz a0 is_five
	addi a0 a0 5
	
	addi a0 a0 -6
	beqz a0 is_six
	addi a0 a0 6
	
	addi a0 a0 -7
	beqz a0 is_seven
	addi a0 a0 7
	
	addi a0 a0 -8
	beqz a0 is_eight
	addi a0 a0 8
	
	addi a0 a0 -9
	beqz a0 is_nine
	addi a0 a0 9
	
	addi a0 a0 -10
	beqz a0 is_ten
	addi a0 a0 10
	
	addi a0 a0 -11
	beqz a0 is_eleven
	addi a0 a0 11
	
	addi a0 a0 -12
	beqz a0 is_twelve
	addi a0 a0 12
	
	addi a0 a0 -13
	beqz a0 is_thirteen
	addi a0 a0 13
	
	addi a0 a0 -14
	beqz a0 is_fourteen
	addi a0 a0 14
	
	addi a0 a0 -15
	beqz a0 is_fifteen
	addi a0 a0 15
	
is_one:
	li a0 6
	j end
	
is_zero:
	li a0 63 
	j end
	
is_two:
	li a0 0x5b
	j end
	
is_three:
	li a0 79
	j end
is_four:
	li a0 0x66
	j end
	
is_five:
	li a0 109
	j end
	
is_six:
	li a0 125
	j end
	
is_seven:
	li a0 7
	j end
	
is_eight:
	li a0 127
	j end
	
is_nine:
	li a0 111
	j end
	
is_ten:
	li a0 119
	j end
	
is_eleven:
	li a0 124
	j end
	
is_twelve:
	li a0 57
	j end
	
is_thirteen:
	li a0 94
	j end
	
is_fourteen:
	li a0 121
	j end
	
is_fifteen:
	li a0 113
	j end	
	
end:
.end_macro
.macro exit
	li a7 10
	ecall
.end_macro

.macro push(%x_rg)
	addi sp sp -4
	sw %x_rg (sp)	
.end_macro

.macro pop(%x_rg)
	lw %x_rg (sp)
	addi sp sp 4
.end_macro