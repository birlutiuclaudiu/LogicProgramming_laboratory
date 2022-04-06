%append pentru  a lua H random
perm(L, [H|R]):-append(A, [H|T], L), append(A, T, L1), perm(L1, R). 
perm([], []). 

%INSERT SORT 
ins_sort([H|T], R):- ins_sort(T, R1), insert_ord(H, R1, R). 
ins_sort([], []). 

insert_ord(X, [H|T], [H|R]):-X>H, !, insert_ord(X, T, R). 
insert_ord(X, T, [X|T]).


%bubble sort
bubble_sort(L,R):-one_pass(L,R1,F), nonvar(F), !, bubble_sort(R1,R). 
bubble_sort(L,L).

one_pass([H1,H2|T], [H2|R], F):-H1>H2, !, F=1, one_pass([H1|T],R,F).
one_pass([H1|T], [H1|R], F):-one_pass(T, R, F). 
one_pass([], [] ,_).

%%%%%%%%%%%%%%%  QUICK SORT %%%%%%%%%%%%%%%%%%%%%%%%%%
quick_sort([H|T], R):- % alegem pivot primul element 
        partition(H, T, Sm, Lg),  
        quick_sort(Sm, SmS), % sortam sublista cu elementele mai mici decât pivotul 
        quick_sort(Lg, LgS), % sortam sublista cu elementele mai mari decât pivotul
        append(SmS, [H|LgS], R). 
quick_sort([], []).

partition(H, [X|T], [X|Sm], Lg):-X<H, !, partition(H, T, Sm, Lg). 
partition(H, [X|T], Sm, [X|Lg]):-partition(H, T, Sm, Lg). 
partition(_, [], [], []).


%%%%%%%%%%%%%%%%% MERGE  %%%%%%%%%%%%%%
merge_sort(L, R):- split(L, L1, L2), % împarte L în doua subliste de lungimi egale 
        merge_sort(L1, R1),
        merge_sort(L2, R2),
        merge(R1, R2, R). % interclasează sublistele ordonate
merge_sort([H], [H]). % split returnează fail dacă lista ii vidă sau are doar un singur element 
merge_sort([], []).

split(L, L1, L2):- length(L, Len),  Len>1,  K is Len/2, 
                 splitK(L, K, L1, L2). 
splitK([H|T], K, [H|L1], L2):-K>0,!,K1 is K-1,splitK(T, K1, L1, L2). 
splitK(T, _, [], T).

merge([H1|T1], [H2|T2], [H1|R]):-H1<H2, !, merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]):-merge([H1|T1], T2, R). 
merge([], L, L).
merge(L, [], L).
%%%%%%%%%%%%%%%%%%%%%%%%%%%  SEL SORT %%%%%%%%%%%%%%%%%%%%%%%%%%
delete(X, [X|T], T) :- !.
delete(X, [H|T], [H|R]) :- delete(X, T, R).
delete(_, [], []).

min([H|T], M) :- min(T, M), M<H, !.
min([H|_], H).

sel_sort(L, [M|R]):- min(L, M), delete(M, L, L1), sel_sort(L1, R).
sel_sort([], []). 

%%%%%%%%%%%%%%%%%%%% EX 1 %%%%%%%%%%%%%%%%%%%%%%%%%
delete1(X, [X|T], T).
delete1(X, [H|T], [H|R]) :- delete1(X, T, R).


perm2(L, [H|R]) :- delete1(H, L, R1), perm2(R1, R).
perm2([], []). 


%%%%%%%%%%%%%%%%%%%% EX 2 %%%%%%%%%%%%%%%%%%%%%%%%%
maxim([H|T], M) :- maxim(T, MT), MT>=H, !, M=MT.
maxim([H|_], H).

sel_sort_desc(L, [M|R]):- maxim(L, M), delete(M, L, L1), sel_sort_desc(L1, R).
sel_sort_desc([], []).

%%%%%%%%%%%%%%%%%%%% EX 3 %%%%%%%%%%%%%%%%%%%%%%%%%
min_char([H|T], M) :- min_char(T, M), char_code(M,R),char_code(H,Q), R<Q, !.
min_char([H|_], H).

sort_chars(L, [M|R]):- min_char(L, M), delete(M, L, L1), sort_chars(L1, R).
sort_chars([], []). 


%%%%%%%%%%%%%%%%%%%% EX 4 %%%%%%%%%%%%%%%%%%%%%%%%%
length1([], 0). 
length1([_|T], Len) :- length1(T, Lcoada), Len is 1+Lcoada.

min_len([H|T], M) :- min_len(T, M), length1(M, M1),length1(H, H1), M1<H1, !.
min_len([H|_], H).

sort_len(L, [M|R]):- min_len(L, M), delete(M, L, L1), sort_len(L1, R).
sort_len([], []). 

