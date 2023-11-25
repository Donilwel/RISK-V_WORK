.text
.global strncpy
strncpy:
	li t0 0 
	bltz a3 end
loop:
	beq t0 a3 end 
	lb t2 (a2)
	beqz t2 end 
	sb t2 (a1) 
	
	addi a1 a1 1 
	addi a2 a2 1 
	addi t0 t0 1 
	j loop
end:
	ret