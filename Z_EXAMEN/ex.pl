
%coada : enqueue and dequeue

enqueue(El, First, [El|Last], First, Last).
dequeue(Item, [Item|First], Last, First, Last).

%deep to left with difference list 

deepflat([], Last, Last):-!.
deepflat([H|T], [H|Tailflat], Last):-atomic(H), !, deepflat(T, Tailflat, Last).
deepflat([H|T], First, Last):- deepflat(H, First, Last1), deepflat(T, Last1, Last).


%subst(OldExpr, NewExpr, OldSub, NewSub).
%subst_args(OldArgs, NewArgs, OldSub, NewSub).




tree(t(
        t(
            t(_, 5, _), 
            3,
            _
        ),
        2, 
        
        t( 
             t(_, 6, _),
             4,
             _
        )
    )
    ).

collect(t(L, _, R), B, B):- var(L), var(R), !.
collect(t(L, Key, R), B, E):-  var(R), !, collect(L, B, [Key|E]).
collect(t(L, Key, R), [Key|B], E) :- var(L), !, collect(R, B, E).
collect(t(L, Key, R), Brez, Erez):- collect(R, Int, Erez), collect(L, Brez, [Key|Int]).


collect2(t(L, Key, R), B, [Key|B]):- var(L), var(R), !.
collect2(t(L, _, R), B, E):-  var(R), !, collect2(L, B, E).
collect2(t(L, _, R), B, E) :- var(L), !, collect2(R, B, E).
collect2(t(L, Key, R), Brez, Erez):- collect2(R, Int, Erez), collect2(L, Brez,Int).



rep(X, [X|T], Y, [Y|T]):-!.
rep(X, [H|T], Y, [H|R]):- rep(X, T ,Y ,R).

rep(_, [], _, []).



a([H|T], L, [H|R]):-a(T, L, R).
a([], L, L).
aa(A, B, C, D):- a(B, C, E), a(A, E, D).


man(john).  
parent(john,david). 
parent(john,edward). 
father(X,Y):-man(X),  parent(X,Y).


parent(1).
parent(2).
parent1(1).
parent1(2).

parent:- parent3, parent(Y).
parent3:-not(parent1(X)),!.



enq(El, First, [El|Last], First, Last).

deq(Item, [Item|First], Last, First, Last).








subst(Old,New,Old,New):-!.
subst(Val,Val,_,_):-atomic(Val),!. 
subst(Val,NewVal,OldSubExpr,NewSubExpr):-Val=..[F|Args],
                                         subst_args(Args,NewArgs,OldSubExpr,NewSubExpr), 
                                         NewVal=..[F|NewArgs]. 
subst_args([],[],_,_).

subst_args([Arg|Args],[NArg|NArgs],Old,New):-subst(Arg,NArg,Old,New), 
                                             subst_args(Args,NArgs,Old,New).


:-dynamic is_ddor/2.
is_door(a,b). is_door(b,a).
 is_door(b,c).  is_door(c,b). 
  is_door(b,e).  is_door(e,b).
  is_door(c,d). is_door(d,c).
   is_door(d,e).  is_door(e,d).
    is_door(e,f). is_door(f,e).
     is_door(e,g). is_door(g,e).
    

is_pass(X, Y):-is_door(X, Y), is_door(Y,X).
is_objective(g).
is_objective(d).

search(X,Y,Way):-try(X,Y,[X],Way),is_objective(Y),!.

try(X,X,L,L).
try(X,Y,Thread,Way):-is_pass(X, Z), not(member(Z,Thread)), try(Z,Y,[Z|Thread],Way).


delete_all(X, [X|T], R):- !,delete_all(X, T,R).
delete_all(X, [H|T], [H|R]):-!, delete_all(X, T, R).
delete_all(_, [], []).


neigh(a, [b,c,e]).
neigh(b, [a,c,d]).
neigh(c, [a,b, f]).
neigh(f, [c,e]).
neigh(e, [a]).

a_way(V, V, [V]).
a_way(V1, V2,[V1|Way]):-
        neigh(V1, L),
        way(L, V2, Way).

way([V1|T], V2, Way):- 
        a_way(V1, V2, Way).
way([_|T], V2, Way):- way(T, V2, Way).       



likes(bill,wine). likes(dick,beer). likes(harry,beer). likes(john,beer). likes(peter,wine). likes(tom,beer). likes(bill,beer). likes(tom,water).


findall2(X , G, S):- bagof(X,G,S), !.
findall2(_, _, []).

:-dynamic neighb/2.
:-dynamic edge2/2.

edge2(a, b, 2).
edge2(b, a, 2).
edge2(b, c, 1).
edge2(c, b, 1).
edge2(c, d, 4).
edge2(d, c, 4).

% g1 to g2  n , p(vec)

generate2:- edge2(X, _, _), 
            not(neighb(X, L)), 
            findall(P, succ(X, P), L),
            assertz(neighb(X, L)), fail.
generate2.


succ(X, Z):- edge2(X, Y,W), Z=p(Y, W).



:-dynamic vsisited/1.
:-dynamic edge/2.

edge(a, b). edge(b, a). 
edge(a, c). edge(c, a). 
edge(b, d). edge(d, b). 
edge(c, e). edge(e, c). 

df_search(X, _):- assertz(visited(X)),
              edge(X, Y), 
              not(visited(Y)),
              df_search(Y, _).
df_search(_, L):- 
        findall(X, visited(X), L).
                
 bf_search(X, _):- assertz(visited(X)),
                  visited(Y),
                  edge(Y, Z), 
                  not(visited(Z)),
                  assertz(visited(Z)),
                  fail.
bf_search(_, L):- findall(X, visited(X), L), retractall(visited(X)).

                

delete2(H,[H|T],T). 
delete2(X,[H|T],[H|R]):-delete2(X,T,R).






dfs_s(X, _):- dfs(X).
dfs_s(_, L):- !, findall(X, visited(X), L), retractall(visited(Y)).

dfs(X):- asserta(visited(X)), 
        edge(X, Z), 
        not(visited(Z)), 
        dfs(Z).

:-dynamic de_exp/1.

bfs_s(X, _):- assertz(visited(X)),
              assertz(de_exp(X)), 
              bfs.
bfs_s(_, L):- !, findall(X, visited(X), L), retractall(visited(Y)).

bfs:- retract(de_exp(X)), 
      expand(X), !, bfs.

expand(X):- edge(X, Y), 
          not(visited(Y)), 
          assertz(visited(Y)), 
          assertz(de_exp(Y)),
          fail.
expand(_).

tree1(t(t(t(nil,2,nil),4,t(nil,5,nil)),6, t(t(nil,7,nil),9,nil))).
toorderedlist(T,L):-to_ord_list(T,[],L).
to_ord_list(t(L,A,t(RL,B,RR)),PR,OL):-to_ord_list(t(t(L,A,RL),B,RR),PR,OL).
to_ord_list(t(L,A,nil),PR,OL):-to_ord_list(L,[A|PR],OL).
to_ord_list(nil,OL,OL).


p(1).
p(2).

check:-1=\=1 ,!, fail.
check.


del([H|T], [H|R], M):-
        del(T, R, M), 
        H>=M,!.
del([H|T], T, H).



bf(X,_):- assertz(visited(X)), 
        assertz(de_exp(X)), 
        bfs2.
bf(_,L):-findall(X, visited(X), L), retractall(visited(D)).

bfs2:- retract(de_exp(X)), 
      expand2(X), 
      !, 
      bfs2.


expand2(X):- edge(X, Y), 
            not(visited(Y)), 
            assertz(visited(Y)), 
            assertz(de_exp(Y)), 
            fail.
expand2(_).

