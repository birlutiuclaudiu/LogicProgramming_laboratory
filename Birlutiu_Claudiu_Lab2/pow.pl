%ridicarea la putere inapoi
pow2(N, P, R) :- P>0,N>=0, P1 is P-1, pow(N, P1, R1), R is R1 * N.
pow2(_, 0, 1).

%ridicarea la putere inainte
pow(N, P, Acc, R) :- P>0,N>=0, P1 is P-1, Acc1 is Acc * N, pow(N, P1, Acc1, R).
pow(N, 0, Acc, R) :- R=Acc.
pow(N, P, R) :- pow(N, P, 1,R).