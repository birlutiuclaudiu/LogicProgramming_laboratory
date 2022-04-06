%Birlutiu Claudiu
member(X , [X|T]).
member(X, [H|T]) :- member(X,T).

delete_all(X, [X|T], R) :- delete_all(X, T, R). % dacă s-a ștersprima apariție se va continua și pe restul elementelor
delete_all(X, [H|T], [H|R]) :- delete_all(X, T, R).
delete_all(_, [], []).

delete(X, [X|T], T).
delete(X, [H|T], R):- delete(X, T, R2), R = [H | R2].
%sau delete(X, [H|T], [H|R]):- delete(X, T, R).
delete(X, [], []).

append([H|T], L2, R) :- append(T, L2, R2), R = [H|R2].
%append([H|T], L2, [H|R]) :- append(T, L2, R).
append([], L, R):- R=L.

%ex1
append3(L1,L2,L3,R):-append(L1, L2, R2), append(R2,L3, R).

%ex2 
add_first(X,L,R) :- R=[X|L].

%ex3
sum_elements([H|T],S):- sum_elements(T, S2), S is S2 + H.
sum_elements([], S):- S=0.

%ex4 
separate_parity([H|T], E, O):- R is H mod 2, R == 0, separate_parity(T, R1, O), E = [H|R1].
separate_parity([H|T], E, O):- R is H mod 2, R \= 0, separate_parity(T, E, R2), O = [H|R2].
separate_parity([], [], []).

%ex5 -- prima aparitie
remove_duplicates([H|T], R):-  delete_all(H, T, Tint), remove_duplicates(Tint, R2), R = [H|R2].
remove_duplicates([],[]).
%ultima aparitie pastrata
remove_duplicates2([H|T], R):- member(H, T), remove_duplicates2(T, R).
remove_duplicates2([H|T], R):- \+member(H, T), remove_duplicates2(T, R2), R = [H|R2].
remove_duplicates2([],[]).


%ex6
replace_all(X, Y, [H|T], R):- X == H, replace_all(X,Y, T, R2), R= [Y|R2].
replace_all(X, Y, [H|T], R):- X \= H, replace_all(X,Y, T, R2), R= [H|R2].
replace_all(X, Y, [], []).

%ex7
drop_k_1([H|T], K, R ,Acc):- Acc==1, drop_k_1(T, K, R, K).
drop_k_1([H|T], K, R ,Acc):- Acc\=1, Acc2 is Acc-1, drop_k_1(T, K, R2, Acc2), R = [H|R2].
drop_k_1([], K, [], _).

drop_k(L, K, R) :- drop_k_1(L, K, R, K).