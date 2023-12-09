# Graphical dialog windows
.macro message_dialog(%message, %type)
	.data
		message: .asciz %message
	.text
		push (a0)
		push (a1)
		li a7, 55
		la a0, message
		li a1, %type
		ecall
		pop (a1)
		pop (a0)
.end_macro
.macro request(%message, %buffer, %size)
	.data
		message: .asciz %message
	.text
		la a0, message
		la a1, %buffer
		li a2, %size
		li a7, 54
		ecall
		push (s0)
		push (s1)
		push (s2)
		bnez a1, end
		li s0, '\n'
		la s1, %buffer
		next:
			lb s2, (s1)
			beq s0, s2, replace
			addi s1, s1, 1
			j next
		replace:
			sb zero, (s1)
		end:
			pop (s2)
			pop (s1)
			pop (s0)
.end_macro
.macro confirm_dialog(%message)
	.data
		message: .asciz %message
	.text
		la a0, message
		li a7, 50
		ecall
.end_macro

# Open a file
.eqv READ_ONLY	0
.eqv WRITE_ONLY 1
.eqv APPEND	9
.macro open (%file_name, %opt)
    li a7, 1024
    la a0, %file_name
    li a1, %opt
    ecall
.end_macro

# Write info to a file
.macro write(%descriptor, %register, %size)
    li a7, 64
    mv a0, %descriptor
    mv a1, %register
    mv a2, %size
    ecall
.end_macro

# Allocation memory
.macro allocate(%size)
    li a7, 9
    li a0, %size
    ecall
.end_macro

# Printing string
.macro print_str (%x)
   	.data	
		str: .asciz %x
   	.text
	   	push(a0)
	   	li a7, 4
	   	la a0, str
	   	ecall
	   	pop(a0)
.end_macro

# Pushing register to stack
.macro push(%x)
	addi sp, sp, -4
	sw %x, (sp)
.end_macro

# Popping register from stack
.macro pop(%x)
	lw %x, (sp)
	addi sp, sp, 4
.end_macro

# Reading info from file to buffer
.macro read_addr_reg(%file_descriptor, %register, %size)
    li   a7, 63
    mv   a0, %file_descriptor
    mv   a1, %register
    li   a2, %size
    ecall
.end_macro

# Input
.macro input
	jal input
.end_macro

# Output
.macro output(%address, %size)
	mv a0, %address
	mv a1, %size
	jal output
.end_macro

# Check
.macro check(%address, %size)
	mv a0, %address
	mv a1, %size
	jal check
.end_macro

# Read contents of file
.macro read_file(%descriptor)
	mv a0, %descriptor
	jal read_file
.end_macro

# Exit
.macro exit
	li a7, 10
	ecall
.end_macro

# Testing
.macro test(%label_input, %label_output)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	push(s4)
	.data
		a_palindrome: .asciz "The string is a palindrome\n"
		not_a_palindrome: .asciz "The string is not a palindrome\n"
	.text
		open(%label_input, READ_ONLY)
		mv s0, a0
		read_file(s0)
		mv s0, a0
		mv s1, a1
		check(s0, s1)
		beqz a0, is_not_a_palindrome
		la s3, a_palindrome
		li s4, 26
		j continue
		is_not_a_palindrome:
			la s3, not_a_palindrome
			li s4, 30
		continue:
			open(%label_output, WRITE_ONLY)
			mv s0, a0
			write(s0, s3, s4)
			li a7, 4
			mv a0, s3
			mv a1, s4
			ecall
			pop(s4)
			pop(s3)
			pop(s2)
			pop(s1)
			pop(s0)
.end_macro
