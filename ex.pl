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

%%Ex3 cu efecte laterale; compunere si descompunere + cand nu sunt descompuneri
%% append - nederminist pentru a gasi descompuneri

%%o_d(L, R) :- append(A,B,L), assertz( decomp(A, B)), fail.
%%o_d(L, R) :- collect(R).
%%o_d(L, R). 

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



%%Exercitiu 1
convert_in_def(L, LS, LE, R):- append(L, LE, R), LS=R, !.  
convert_def_in(L, R):- append(L, _, R), !.  

%5Exercitiul 2
convert_com_def(L, RS, RE, R):- append(L, RE, R), RS=R. 
convert_def_com(LS, _, R):- append(LS, [], R), !.