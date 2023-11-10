.global prog
.include "macrolib.s"
.data 
delta: .double 0.00001 # to compare 2 doubles
.text
prog:
mv t0 a0

# claculate vector AB from A and B
# puts AB coords in a0 and a1
fld fa0 (t0) #Ax
fld fa1 8(t0) #Ay
fld fa2 16(t0) #Bx
fld fa3 24(t0) #By
write_regs
jal calculate_vector
load_regs
fmv.d ft1 fa0 # AB x
fmv.d ft2 fa1 # AB y


fld fa0 (t0) #Ax
fld fa1 8(t0) #Ay
fld fa2 48(t0) #Dx
fld fa3 56(t0) #Dy
write_regs
jal calculate_vector
load_regs
fmv.d ft3 fa0 # AD x
fmv.d ft4 fa1 # AD y



fmv.d fa0 ft1 # AB x
fmv.d fa1 ft2 # AB y
fmv.d fa2 ft3 # AD x
fmv.d fa3 ft4 # AD y
write_regs
jal calc_cos
load_regs

fmv.d ft5 fa0
#print_double(ft5)

########## second angle ###############

# claculate vector AB from A and B
# puts AB coords in a0 and a1
fld fa0 32(t0) #Cx
fld fa1 40(t0) #Cy
fld fa2 16(t0) #Bx
fld fa3 24(t0) #By
write_regs
jal calculate_vector
load_regs
fmv.d ft1 fa0 # CB x
fmv.d ft2 fa1 # CB y


fld fa0 32(t0) #Cx
fld fa1 40(t0) #Cy
fld fa2 48(t0) #Dx
fld fa3 56(t0) #Dy
write_regs
jal calculate_vector
load_regs
fmv.d ft3 fa0 # CD x
fmv.d ft4 fa1 # CD y



fmv.d fa0 ft1 # AB x
fmv.d fa1 ft2 # AB y
fmv.d fa2 ft3 # AD x
fmv.d fa3 ft4 # AD y
write_regs
jal calc_cos
load_regs

fmv.d ft6 fa0

fneg.d ft6 ft6

fsub.d ft4 ft5 ft6
fabs.d ft4 ft4

fld ft3 delta t0

fle.d a0 ft4 ft3

ret
