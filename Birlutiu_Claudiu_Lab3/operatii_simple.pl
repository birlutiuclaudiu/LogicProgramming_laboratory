%Birlutiu Claudiu
member(X , [X|T]).
member(X, [H|T]) :- member(X,T).


append([H|T], L2, R) :- append(T, L2, R2), R = [H|R2].
%append([H|T], L2, [H|R]) :- append(T, L2, R).
append([], L, R):- R=L.


delete(X, [X|T], T).
delete(X, [H|T], R):- delete(X, T, R2), R = [H | R2].
%sau delete(X, [H|T], [H|R]):- delete(X, T, R).
delete(X, [], []).
