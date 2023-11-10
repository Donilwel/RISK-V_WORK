
.global input
.text
.include "macrolib.s"
input:

mv t0 a0
mv t1 a0
print_str("\nInput x cord of A: ")
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput y cord of A: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput x cord of B: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput y cord of B: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput x cord of C: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput y cord of C: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput x cord of D: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)

print_str("\nInput y cord of D: ")
addi t0 t0 8
read_double(fa0)
fsd fa0 (t0)


print_str("\n")
ret