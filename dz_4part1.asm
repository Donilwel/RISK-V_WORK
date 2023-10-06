.data

.text
.global _start

_start:
    li a0, 1          	# start arg
    li a1, 1          	# start factorial
    jal factorial     	# uploading factorial
    
    mv a1, a0
    li a7, 1
    ecall
j stop

factorial:
    li a2, 0x7FFFFFFF 	# max 32 digit
    li t0, 20         	# change a0 on a max digit
    bge a0, t0, end 	# if a0 > max digit -> stop
    
    mv a4, a1    	# this conn in a4
    mul a1, a1, a0 
    mulh a3, a4, a0 
    beqz a3, over 	
    
    addi a0, a0, -1   
    ret
    
over:
    addi a0, a0, 1   
    jal factorial     	# start recursion

end:
    ret

stop:
    li a7, 10
    ecall