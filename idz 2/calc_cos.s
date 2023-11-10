.include "macrolib.s"
.global calc_cos
.text
calc_cos:
fmv.d ft0 fa0 #ft0 x1
fmv.d ft1 fa1 #ft1 y1
fmv.d ft2 fa2 #ft2 x2
fmv.d ft3 fa3 #ft3 y2

# dlya chitaemosti - te 4isla vsyo esche v a0 i a1
# fmv.d fa0 ft0
# fmv.d fa1 ft1

write_regs
jal get_len
load_regs
fmv.d ft4 fa0

#gets length of vector from points in a0, a1 
#returns vec length in a0
fmv.d fa0 ft2
fmv.d fa1 ft3
write_regs
jal get_len
load_regs
fmv.d ft5 fa0

# ft4, ft5 - lengths of x1y1 and x2y2

#print_double(ft4)
#print_str(" ")
#print_double(ft5)

fmul.d ft6 ft0 ft2 # ft6 = x1*x2
fmadd.d ft7 ft1 ft3 ft6 # ft7 = y1 * y2 + x1 * x2

fmul.d ft6 ft5 ft4 # ft6 = len1 * len2

fdiv.d fa0 ft7 ft6

ret 