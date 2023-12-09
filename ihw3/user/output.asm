.include "macrolib.asm"
.globl output
.data
	filename: .space 256
	is_a_palindrome: .asciz "The string is a palindrome"
	is_not_a_palindrome: .asciz "The string is not a palindrome"
.text
output:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	push(s4)
	beqz a0, not_a_palindrome
	la s3, is_a_palindrome
	li s4, 26
	j continue
	not_a_palindrome:
		la s3, is_not_a_palindrome
		li s4, 30
	continue:
		request("Enter file name to write", filename, 256)
		beqz a1, output_filename_loop
		exit
	output_filename_loop:
		open(filename, WRITE_ONLY)
		mv s0, a0
		li s1, -1
		beq s0, s1, opening_error
	console:
		confirm_dialog("Do you want to see the result in console?")
		beqz a0, print # User pressed yes
		li s1, 1 
		beq a0, s1, continue_output # User pressed no
		message_dialog("You should choose yes or no", 2) # Type warning
		j console
	continue_output:
		write(s0, s3, s4)
		pop(s4)
		pop(s3)
		pop(s2)
		pop(s1)
		pop(s0)
		pop(ra)
		ret
	opening_error:
		message_dialog("Opening error occured. Please, try again", 0)
		j continue
	print:
		mv a0, s3
		mv a1, s4
		li a7, 4
		ecall
		j continue_output
	