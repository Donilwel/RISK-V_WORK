# Макробиблиотека с семинара, дополненная макросом strncpy и макросом print_str_reg
# Печать содержимого регистра как целого
.macro print_int(%x)
	push(a0)
	li a7 1
	mv a0 %x
	ecall
	pop(a0)
.end_macro

.macro print_imm_int(%x)
   push(a0)
   li a7 1
   li a0 %x
   ecall
   pop(a0)
.end_macro

.macro read_int_a0
   li a7 5
   ecall
.end_macro

.macro read_int(%x)
   push(a0)
   li a7 5
   ecall
   mv %x a0
   pop(a0)
.end_macro


.macro print_str_imm(%x_imm)
.data
	str: .asciz %x_imm
.text
   push(a0)
   li a7 4
   la a0 str
   ecall
   pop(a0)
.end_macro


.macro print_str_reg(%x_reg)
	mv a0 %x_reg
	li a7 4
	ecall
.end_macro

.macro print_char(%x)
   push(a0)
   li a7, 11
   li a0, %x
   ecall
   pop(a0)
.end_macro

.macro newline
   print_char('\n')
.end_macro

.macro exit
    li a7, 10
    ecall
.end_macro

.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro


.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro strncpy(%dest_reg, %src_reg, %num_imm)
	push(a1)
	push(a2)
	push(a3)
	push(t2)
	push(t0)
	mv a1 %dest_reg
	mv a2 %src_reg
	li a3 %num_imm
	jal strncpy
	pop(t0)
	pop(t2)
	pop(a3)
	pop(a2)
	pop(a1)
end:
.end_macro