.data
maxim:  .word 0

.text
.globl _start

_start:
    li a0, 1          	# start n
    li a1, 1          	# start pointer factorial
    jal find  
    
    la t3, maxim      	# save maxim in t3
    sw a0, 0(t3)      	# save res 

    mv a1, a0
    li a7, 1
    ecall
    
    j stop

find:
    addi t0, t0, -8  
    sw ra, 0(t0)      	# save 

    li t3, 0x7FFFFFFF 	# max int_32
    divu t1, t3, a0   	# max int_32 / n
    bltu t1, a1, overflow # res < factor -> overflow

    addi a0, a0, 1    	# n++
    mul a1, a1, a0    	# update factorial
    jal find   		#recursion

overflow:
    lw ra, 0(t0)      	# return exp 
    addi t0, t0, 8    
    jr ra             	# return from function
    
stop:
    li a7, 10
    ecall
