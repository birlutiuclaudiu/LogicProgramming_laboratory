%%Birlutiu Claudiu-Andrei

%adaugare element la finalul listei
add1(X, [H|T], [H|R]):- add1(X, T,R).
add1(X, [], [X]).

%add in listele diferenta
add2(X , LS, LE, RS, RE):- RS = LS, LE=[X|RE].

%append
append_dl(LS1, LE1, LS2, LE2, RS, RE):- RS=LS1, LE1 = LS2, RE=LE2.

%% inorder  with different list
inorder_dl(nil, L,L).
inorder_dl(t(K, L, R), LS, LE):-
    inorder_dl(L, LSL, LEL),
    inorder_dl(R, LSR, LER),
    LS = LSL, 
    LEL = [K|LSR],
    LE = LER.

tree(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))). 



%%Sortare rapida 
quicksort_dl([H|T], S, E):- % s-a adăugat un parametru nou 
        partition(H, T, Sm, Lg), % predicatul partition a rămas la fel 
        quicksort_dl(Sm, S, [H|L]), 
        quicksort_dl(Lg, L, E).
 quicksort_dl([], L, L).

partition(H, [X|T], [X|Sm], Lg):-X<H, !, partition(H, T, Sm, Lg). 
partition(H, [X|T], Sm, [X|Lg]):-partition(H, T, Sm, Lg). 
partition(_, [], [], []).

%fibonnaci - dynamic
:-dynamic memo_fib/2.
fib(N, F) :- memo_fib(N,F), !.
fib(N, F) :- N>1, 
             N1 is N-1, 
             N2 is N-2, 
             fib(N1, F1),
             fib(N2, F2),
             F is F1+F2, 
             assertz(memo_fib(N, F)).
fib(0,1).
fib(1,1).
print_all:-memo_fib(N,F),   
        write(N),   
        write('-'),   
        write(F),   
        nl, 
        fail. 
print_all.

perm(L, [H|R]):-append(A, [H|T], L), append(A, T, L1), perm(L1, R). 
perm([], []). 
all_perm(L,_):- perm(L,L1), 
                assertz(p(L1)),    
                fail. 

all_perm(_,R):- collect_perms(R).  
collect_perms([L1|R]):- retract(p(L1)), !, collect_perms(R). 
collect_perms([]).


%%Exercitiu 1
convert_in_def(L, LS, LE, R):- append(L, LE, R), LS=R, !.  
convert_def_in(L, R):- append(L, _, R), !.  

%5Exercitiul 2
convert_com_def(L, RS, RE, R):- append(L, RE, R), RS=R. 
convert_def_com(LS, LE, R):- LE = [], LS = R.
% LS=[1,2,3,4,5|LE], convert_def_com(LS, LE, R).

%%Exercitiul 3
%%explicatii tabla
%%Ex3 cu efecte laterale; compunere si descompunere + cand nu sunt descompuneri
%% append - nederminist pentru a gasi descompuneri
%%o_d(L, R) :- append(A,B,L), assertz( decomp(A, B)), fail.
%%o_d(L, R) :- collect(R).
%%o_d(L, R). 
%% ca la permutari, numai ca predicattul assertat va fi cu 2 argumente (decomposition/2)
all_decompositions(L, _):- append(X, Y, L), assertz(decomposition(X, Y)), fail. 
 %assertul va da true, dar pentru a prelua rezultatul intermediar se da fail 
all_decompositions(_,R) :- collect_decomp(R).
collect_decomp([[X,Y]|R]):- retract(decomposition(X,Y)), !, collect_decomp(R).
collect_decomp([]):-!.


%%Exerciitul 4
flatten([],RS,RS).
flatten([H|T], [H|RS], RE):- atomic(H), !, flatten(T, RS, RE). 
flatten([H|T], RS, RE):- flatten(H, RS1, RE1), flatten(T, RS2, RE2), RS=RS1, RE1=RS2, RE=RE2.

%apel flatten([[1], 2, [3, [4, 5]]], RS, RE).
%% tree extract 

%%Exercitiul 5 - am facut split la inorder
even_keys(nil, L,L).
even_keys(t(K, L, R), LS, LE):-
        Modulo is K mod 2, 
        Modulo = 0, 
        !,
        even_keys(L, LSL, LEL), 
        even_keys(R, LSR, LER),
        LS = LSL, 
        LEL = [K|LSR],
        LE = LER.
even_keys(t(_, L, R), LS, LE):-
        even_keys(L, LSL, LEL),
        even_keys(R, LSR, LER),
        LS = LSL, 
        LEL = LSR,
        LE = LER.
% apel tree(T), even_keys(T, Rs, Re).

%%Exerciutiul 6  --la fel ca 5
interval_key(nil, _, _, L,L).
interval_key(t(K, L, R), K1, K2, LS, LE):-
        K >K1,
        K <K2, 
        !,
        interval_key(L, K1, K2, LSL, LEL), 
        interval_key(R, K1, K2, LSR, LER),
        LS = LSL, 
        LEL = [K|LSR],
        LE = LER.
interval_key(t(_, L, R), K1, K2, LS, LE):-
        interval_key(L, K1, K2, LSL, LEL),
        interval_key(R, K1, K2, LSR, LER),
        LS = LSL, 
        LEL = LSR,
        LE = LER.

%% apel tree(T), interval_key(T, 3,10, Rs, Re).




