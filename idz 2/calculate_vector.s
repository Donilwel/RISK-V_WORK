.global calculate_vector
.include "macrolib.s"
.text
calculate_vector:

fsub.d fa0 fa2 fa0
fsub.d fa1 fa3 fa1

ret