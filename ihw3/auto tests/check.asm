.include "macrolib.asm"
.global check

check:
	push(ra)
	push(s0)	
	push(s1)
	push(s2)
	push(s3)
	mv s0, a0
	find_end: # Move the pointer to the end of the string
		lb s1, (s0) # Load byte from the string
		beqz s1, end_found # If the symbol is null terminator, the end is reached
		addi s0, s0, 1 # Increment the pointer
		j find_end
	end_found:
		addi s0, s0, -1 # Move the pointer to the last symbol
	while:
		bge a0, s0, true # The middle of the string has been reached => the string is a palindrome
		lb s1 (a0) # Load byte from the beginning of the string
		lb s2 (s0) # Load byte from the end of the string
		bne s1, s2, false # If symbols differ, the string is not a palindrome
		addi a0, a0, 1 # Increment the pointer of the beginning
		addi s0, s0, -1 # Decrement the pointer of the end
		j while
		
	true:
		pop(s3)
		pop(s2)
		pop(s1)
		pop(s0)
		pop(ra)
		li a0, 1 # The string is a palindrome => function returns 1 in register a0
		ret
	
	false:
		pop(s3)
		pop(s2)
		pop(s1)
		pop(s0)
		pop(ra)
		li a0, 0 # The string is not a palindrome => function returns 0 in register a0
		ret