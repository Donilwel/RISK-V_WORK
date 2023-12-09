.include "macrolib.asm"
.global read_file
.eqv SIZE 512
read_file:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	push(s4)
	push(s5)
	push(s6)
	push(s7)
	mv s0, a0
	li s7, 20
	li s1, -1
    	allocate(SIZE)
    	mv s3, a0
    	mv s5, a0
    	li s4, 512
    	mv s6, zero # Size of already read contents
    	read_loop:
	    	read_addr_reg(s0, s5, SIZE)
	    	beq a0, s1, reading_error
	    	mv s2, a0
	    	add s6, s6, s2
	    	bne s2, s4, finish # If size of read contents is less than buffer size, finish
	    	addi s7, s7, -1
	    	beqz s7, finish
	    	allocate(SIZE)
	    	add s5, s5, s2
	    	j read_loop
	finish:
	    	mv t0, s3
	    	add t0, t0, s6 # Last read symbol
	    	allocate(1) # If size is 10 Kb, allocating memory for terminating null
	    	addi t0, t0, 1 # Increment the pointer to get the terminating null position
	    	sb zero, (t0) # Add a terminating null
	    	addi s6, s6, 1
	    	mv a0, s3
	    	mv a1, s6
	    	pop(s7)
	    	pop(s6)
	    	pop(s5)
	    	pop(s4)
	    	pop(s3)
	    	pop(s2)
	    	pop(s1)
	    	pop(s0)
	    	pop(ra)
	    	ret
reading_error:
	message_dialog("Reading error occured", 0) # Type error
	exit