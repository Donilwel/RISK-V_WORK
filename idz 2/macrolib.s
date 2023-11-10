.macro write_regs
addi sp sp -4
sw ra (sp)
addi sp sp -8
fsd ft0 (sp)
addi sp sp -8
fsd ft1 (sp)
addi sp sp -8
fsd ft2 (sp)
addi sp sp -8
fsd ft3(sp)
addi sp sp -8
fsd ft4 (sp)
addi sp sp -8
fsd ft5 (sp)
addi sp sp -8
fsd ft6 (sp)
addi sp sp -8
fsd ft7 (sp)
.end_macro

.macro load_regs
fld ft7 (sp)
addi sp sp 8
fld ft6 (sp)
addi sp sp 8
fld ft5 (sp)
addi sp sp 8
fld ft4 (sp)
addi sp sp 8
fld ft3 (sp)
addi sp sp 8
fld ft2 (sp)
addi sp sp 8
fld ft1 (sp)
addi sp sp 8
fld ft0 (sp)
addi sp sp 8
lw ra (sp)
addi sp sp 4
.end_macro 

.macro fbeq.d(%x, %y, %z)
   	feq.d a6 %x %y
   	bne a6 zero %z
.end_macro

.macro fbgt.d(%x, %y, %z)
   	fgt.d a6 %x %y
   	bne a6 zero %z
.end_macro

.macro fbge.d(%x, %y, %z)
   	fge.d a6 %x %y
   	bne a6 zero %z
.end_macro

.macro fbgt.d(%x, %y, %z)
   	fgt.d a6 %x %y
   	bne a6 zero %z
.end_macro

.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro


.macro print_double (%x)
	li a7, 3
	fmv.d fa0, %x
	ecall
.end_macro

.macro exit
   	li a7, 93
   	li a0, 0
	ecall
.end_macro

.macro print_str (%x)
   	.data
	str:
	.asciz %x
	.text
   	li a7, 4
   	la a0, str
   	ecall
.end_macro

.macro read_double (%x)
   	li a7, 7
   	ecall
   	fmv.d %x, fa0
.end_macro

