%factorial
 
fact(N, R) :- N>0, N1 is N-1, fact(N1, R1), R is R1*N.
fact(0, 1).
%se tin rezultatele intermediare 
fact2(N, Acc, R) :- N>0, N1 is N-1, Acc1 is Acc*N, fact2(N1, Acc1, R).
fact2(0, Acc, R) :- R=Acc.