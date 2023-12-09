.include "macrolib.asm"
.global input

.data
	filename: .space 256
.text
input:
	push(ra)
	push(s0)
	push(s1)
	input_loop:
		request("Enter file name to read", filename, 256)
		bnez a1, end
		open(filename, READ_ONLY)
		mv s0, a0
		li s1, -1
		beq s0, s1, opening_error
		read_file(s0)
		pop(s1)
		pop(s0)
		pop(ra)
		ret
	
opening_error:
	message_dialog("Opening error occured. Please, try again", 0) # Type error
	j input_loop
		
end:
	pop(s1)
	pop(s0)
	pop(ra)
	exit
	