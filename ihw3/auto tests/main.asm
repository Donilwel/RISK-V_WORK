.include "macrolib.asm"
.globl main
.data
	input_1: .asciz "../text_data/input_1.txt"
	output_1: .asciz "../text_data/output_1.txt"
	input_2: .asciz "../text_data/input_2.txt"
	output_2: .asciz "../text_data/output_2.txt"
	input_3: .asciz "../text_data/input_3.txt"
	output_3: .asciz "../text_data/output_3.txt"
	input_4: .asciz "../text_data/input_4.txt"
	output_4: .asciz "../text_data/output_4.txt"
	input_5: .asciz "../text_data/input_5.txt"
	output_5: .asciz "../text_data/output_5.txt"
.text
main:
	test(input_1, output_1)
	test(input_2, output_2)
	test(input_3, output_3)
	test(input_4, output_4)
	test(input_5, output_5)
	exit