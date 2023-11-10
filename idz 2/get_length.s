.global get_len
.include "macrolib.s"
.text
get_len:

fmul.d ft0 fa1 fa1 #y^2
fmadd.d ft1 fa0 fa0 ft0 # x*x + y^2

fsqrt.d fa0 ft1

ret