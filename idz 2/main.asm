.data
.global main
.align 2
.include "macrolib.s"
points: .space 64

.text 
main:

# gets array head and fills it with 4 points
la a0 points
jal input

# calculate if points can be writen in circle
# output is int number in a0. 1 = true, 0 = false
la a0 points
jal prog

mv s0 a0
mv a0 s0

jal output

exit
