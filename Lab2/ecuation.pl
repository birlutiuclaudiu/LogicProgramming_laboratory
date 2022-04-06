
delta(A, B, C, D):- D is B*B - 4*A*C.
eq(A,B,C,X):-  delta(A,B,C,Delta), Delta == 0, X is -B/2*A.
eq(A,B,C,X):-  delta(A,B,C,Delta), Delta>0, X is ((-1*B-sqrt(Delta))/2*A).
eq(A,B,C,X):-  delta(A,B,C,Delta), Delta>0, X is ((-1*B+sqrt(Delta))/2*A).