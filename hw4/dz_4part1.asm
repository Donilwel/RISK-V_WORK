.data

.text
.global _start

_start:
    li a0, 1          	# start arg
    li s1, 1          	# start factorial
    jal factorial     	# uploading factorial
    
    mv s1, a0
    li a7, 1
    ecall
j stop

factorial:
    li s3, 0        	# change s3 on a max digit
    li a2, 0x7FFFFFFF 	# max 32 digit
loop:
    mv s2, s1    	# this conn in s2
    mul s1, s1, a0 
    mulh s3, s2, a0 
    beqz s3, over 	
    addi a0, a0, -1   
    j rett
    
over:
    addi a0, a0, 1   
    j loop     	# start recursion
rett:
    ret
stop:
    li a7, 10
    ecall
