man(john). 

parent(john,david).
parent(john,edward). 
father(X,Y):- man(X), parent(X,Y).

member(H,[H|T]). 
member(X,[H|T]):- member(X,T).
%member(X,[]):-fail.




list_length1([],R). 
list_length1([_|T],PR):-NPR is PR+1,list_length1(T,NPR).

reverse1([],[]).
reverse1([H|T],R):-reverse1(T,PR),  append(PR,[H],R).


delete(X, [X|T], T):-!.
delete(X, [H|T], [H|R]):- delete(X, T, R).
delete(_, [], []).


append3_3([Head|Tail],List2,List3,[Head|Rest]):- append3_3(Tail,List2,List3,Rest). 
append3_3([],[Head|Tail],List,[Head|Rest]):-append3_3([],Tail,List,Rest).
append3_3([],[],List,List).

deleteall(H,[H|T],R):- !,deleteall(H,T,R). 
deleteall(X,[H|T],[H|R]):-!,deleteall(X,T,R).
deleteall(_,[],[]).

member2(X,L) :- var(L), fail. 
member2(X, [X|_]):-!.
member2(X, [_|T]):- member2(X, T).


max_delete([H|T], Max, [H|Dt]):-
    max_delete(T, Max, Dt), 
    H =< Max, !.
max_delete([H|T], H, T).


count_2_children(t(L, _, R), 0):-
var(L),
var(R),
!.

count_2_children(t(L, _, R), N):-
var(L), !,
count_2_children(R, N).
count_2_children(t(L, _, R), N):-
var(R),
!,
count_2_children(L, N).
count_2_children(t(L, _, R), NN):-
count_2_children(R, NR),
count_2_children(L, NL),
NN is NL + NR + 1.

tree(t(_, 7,_)).



delete3(X, [X|T], T).
delete3(X, [H|T], [H|R]):- delete3(X, T, R).
is_bst(nil).
is_bst( t(LL, KL, LR), K, t(RL, KR, RR)):-
