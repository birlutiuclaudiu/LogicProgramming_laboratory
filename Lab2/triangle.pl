%Birlutiu Claudiu-Andrei

triangle(A,B,C) :- LA is B+C, LB is A+C, LC is A+B, LA >A, LB > B, LC >C.

perm([H|T], Perm):- perm(T, R1), perm(T, R1), Perm = [H|R1].
perm([], []).
