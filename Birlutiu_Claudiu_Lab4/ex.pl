t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   BIRLUTIU Claudiu-Andrei, gr 30236    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      LAB4       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minim([H|T], M) :- minim(T, MT), MT<H, !, M=MT.
minim([H|T], H).

maxim([H|T], M) :- maxim(T, MT), MT>=H, !, M=MT.
maxim([H|T], H).


rev([H|T], R) :- rev(T,RT), append(RT, [H], R).
rev([], []).

member(X, [X|_]):-!.
member(X, [_|T]):-member(X, T).

%append(L, [Last], [1,2,3,4,5])
minim2([], Mp,Mp).
minim2([H|T], Mp, M) :- H <Mp, !, minim2(T, H, M).
minim2([H|T], Mp, M) :- minim2(T, Mp, M). 
minim_pretty([H|T], M) :-  minim2(T, H, M).

union([], L, L).
union([H|T], L2, R) :- member(H, L2), !, union(T, L2, R).
union([H|T], L2, [H|R]) :- union(T, L2, R). 

%lungimea
length1([], 0). 
length1([H|T], Len) :- length1(T, Lcoada), Len is 1+Lcoada.

%ex1 intersectie
inters([], L2, []).
inters([H|T], L2, [H|R]) :- member(H, L2),!,inters(T, L2, R).
inters([H|T], L2, R) :-  inters(T, L2, R). 


%ex2 
diff([], L2, []).
diff([H|T], L2, [H|R]) :- not(member(H, L2)), !, diff(T, L2, R).
diff([H|T], L2, R) :- diff(T, L2, R).

%ex3 
delete_all(X, [X|T], R) :- delete_all(X, T, R). % dacă s-a ștersprima apariție se va continua și pe restul elementelor
delete_all(X, [H|T], [H|R]) :- delete_all(X, T, R).
delete_all(_, [], []).


del_min(L, R) :- minim(L, Min), delete_all(Min, L, R).
del_max(L, R) :- maxim(L, Max), delete_all(Max, L, R).


%ex4 - K =pozitiv
reverse_k([], _, []).
reverse_k(L, K, R) :- K>0, length1(L, Len), K>Len, R=L.
reverse_k(L, K, R) :- K=0, !,rev(L, R1), R=R1.
reverse_k([H|T], K, R) :- K1 is K-1, reverse_k(T, K1, R1), R = [H|R1].

%ex5 -RLE

rle_encode_acc([H], Acc, R) :- R = [[H, Acc]].
rle_encode_acc([H1,H1|T], Acc, R):-  Acc2 is Acc+1, rle_encode_acc([H1|T],Acc2, R).
rle_encode_acc([H1,H2|T], Acc, R):-  rle_encode_acc([H2|T], 1, R1), R  = [ [H1,Acc]|R1].
rle_encode(L, R):- rle_encode_acc(L, 1, R).

%ex 6 rotate_right_k([1, 2, 3, 4, 5, 6], 2, R).
append([],L2,L2).
append([H|L1],L2,[H|L3]):-append(L1,L2,L3).

%rotate_right_acc2(L, K , R, FirstElements) :- K=0,append(FirstElements, L, R).
%rotate_right_acc2([H|T], K, R, FirstElements) :- K1 is K-1, append(FirstElements, [H], Firsts2), rotate_right_acc2(T, K1, R, First2).
%rotate_right2(L, K, R) :- length1(L, Len), K1 is K mod Len, rotate_right_acc2(L, K1, R, []).

rotate_right1([],[]) .         
rotate_right1([H|T],R):-append(Firsts,[Last],[H|T] ), R = [Last|Firsts].
rotate_right_acc_k(L, K, R) :- K>0, !,K1 is K-1, rotate_right1(L, R1), rotate_right_acc_k(R1, K1, R).
rotate_right_acc_k(L, 0, L).
rotate_right_k(L, K, R) :- length1(L, Len), K1 is K mod Len, rotate_right_acc_k(L, K1, R). %pentru a trata cazul K > lungimea listei


%ex7 
%returneaza al k-lea element
get_k([H|T], C, K, R) :- C< K, C1 is C+1, get_k(T, C1, K, R).
get_k([H|T], K, K, H).
%random(start, end, R).  -> R e [start,end)
%in prima faza se va construi MULTIMEA de indici. (sa nu extraga de mai multe ori un un numar din lista initiala)
construct_indexes(Count, K, Indexes, R) :- K>0, random(0, Count, Res), not(member(Res, Indexes)), K1 is K-1, construct_indexes(Count, K1, [Res|Indexes], R). 
construct_indexes(Count, K, Indexes, R) :- K>0, random(0, Count, Res), member(Res, Indexes), construct_indexes(Count, K, Indexes, R).
construct_indexes(_, 0, Indexes, Indexes).
select(_, [], []).
select(L, [Index|T], R):- get_k(L, 0, Index, Num), select(L, T, R1), R = [Num|R1].
rnd_select(L, K, R):- length1(L, Count), K1 is K+1, Count<K1, R=L.
rnd_select(L, K, R):- length1(L, Count), Count> K, construct_indexes(Count, K,[], Indexes), select(L, Indexes, R).
