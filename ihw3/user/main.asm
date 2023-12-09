.include "macrolib.asm"
.globl main

main:
	input
	mv s0, a0
	mv s1, a1
	check(s0, s1)
	mv s0, a0
	mv s1, a1
	output(s0, s1)
	exit