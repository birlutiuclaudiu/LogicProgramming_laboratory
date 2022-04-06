%%%%%%%%%%%%%%%%%%%% Birlutiu Claudiu-Andrei, gr 30236 %%%%%%%%%%%%%%%%%%%%%%%%

max(A, B, A):- A>B, !.
max(_, B, B).
depth([],1). 
depth([H|T],R):- atomic(H), !, depth(T,R).
depth([H|T],R):- depth(H,R1), depth(T,R2), R3 is R1+1, max(R3,R2,R).


flatten([],[]).
flatten([H|T], [H|R]):- atomic(H), !, flatten(T,R). 
flatten([H|T], R):- flatten(H,R1), flatten(T,R2), append(R1,R2,R). 

heads([],[],_).
heads([H|T],[H|R],1):-  atomic(H), !, heads(T,R,0).
heads([H|T],R,0):-      atomic(H), !, heads(T,R,0).
heads([H|T],R,_):-      heads(H,R1,1), heads(T,R2,0), append(R1,R2,R).
heads_pretty(L,R):-     heads(L, R, 1).

%%%%%%%%%%%%%%%%%%%%%%%%%EX1
count_atomic([],0).
count_atomic([H|T], R):- atomic(H),!, count_atomic(T, R1), R is R1+1.
count_atomic([H|T], R):- count_atomic(H, R1), count_atomic(T, R2), R is R1 +R2. 


%%%%%%%%%%%%%%%%%%%%%%%%%EX2
sum_atomic([],0).
sum_atomic([H|T], R):- atomic(H),!, sum_atomic(T, R1), R is R1+H.
sum_atomic([H|T], R):- sum_atomic(H, R1), sum_atomic(T, R2), R is R1 +R2.

%%%%%%%%%%%%%%%%%%%%%%%%%EX3
member(X, [X|_]) :- !.
member(X, [_|T]) :- member(X, T).
member2(X,L):- flatten(L,L1), member(X,L1).

%%%%%%%%%%%%%%%%%%%%%%%%%EX4
lasts([], []).
lasts([H],[H]):-  atomic(H), !.
lasts([H|T],R) :- atomic(H),!, lasts(T, R).
lasts([H|T],R) :- lasts(H, R1), lasts(T, R2), append(R1,R2,R), !.
%%%%%%%%%%%%%%%%%%%%%%%%%EX5
replace(_,_,[],[]).
replace(X, Y, [X|T], R):- replace(X, Y, T, R1), R=[Y|R1], !.
replace(X, Y, [H|T], R):- atomic(H), X\=H, ! , replace(X, Y, T, R1), R=[H|R1].
replace(X, Y, [H|T], R) :-    replace(X, Y, H, R1), replace(X, Y, T, R2), R=[R1|R2].

%%%%%%%%%%%%%%%%%%%%%%%%%EX6


sort_depth([H|T], R):- % alegem pivot primul element 
        partition(H, T, Sm, Lg),  
        sort_depth(Sm, SmS), % sortam sublista cu elementele mai mici decât pivotul 
        sort_depth(Lg, LgS), % sortam sublista cu elementele mai mari decât pivotul
        append(SmS, [H|LgS], R). 
sort_depth([], []).


partition(_, [], [], []):- !.
partition(H, [X|T], [X|Sm], Lg):- depth([X], X1), depth([H], H1), X1<H1, !, partition(H, T, Sm, Lg). 
partition(H, [X|T], Sm, [X|Lg]):- depth([X], X1), depth([H], H1), X1>H1, !, partition(H, T, Sm, Lg).
partition(H, [X|T], [X|Sm], Lg):- greater(H, X), !, partition(H, T, Sm, Lg).
partition(H, [X|T], Sm, [X|Lg]):- partition(H, T, Sm, Lg), !.


%%ordoneaza dupa primul element atomic gasit intr-o lista
greater([], []):-  false, !.
greater([_], []):- true, !.
greater([], [_]):- false, !.
greater(X, H) :- atomic(X),atomic(H), X<H, !, false.
greater(X, H):- atomic(X), atomic(H), !,  true, !.
greater(X, _) :- atomic(X), !, false, !.
greater(_, H) :- atomic(H), !, true, !.
greater([X|_], [H|_]) :- atomic(X), atomic(H), X>H,!, true.
greater([X|_], [H|_]) :- atomic(X), atomic(H), !, false.
greater([X|_], _) :- atomic(X), !, false.
greater( _, [H|_]) :- atomic(H), !, true.
greater([X|T1], [X|T2]) :- greater(T1, T2).





