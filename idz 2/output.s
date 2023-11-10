.global output
.include "macrolib.s"
.text
output:
mv t0 a0
beqz t0 ret_false

j ret_true

ret_true:
print_str("points CAN be fitten in circle")
ret

ret_false:
print_str("points CAN't be fitten in circle")
ret
