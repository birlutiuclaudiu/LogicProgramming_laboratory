member(X, [X|_]):-!.
member(X, [_|T]):-member(X, T).

member_il(_, L):-var(L), !, fail.
member_il(X, [X|_]):-!.
member_il(X, [_|T]):-member_il(X, T).

insert_il(X, L):-var(L), !, L=[X|_]. 
insert_il(X, [X|_]):-!. % elementul există deja 
insert_il(X, [_|T]):- insert_il(X, T). 

delete_il(_, L, L):-var(L), !. % am ajuns la finalul listei 
delete_il(X, [X|T], T):-!. % ștergem prima apariție și ne oprim 
delete_il(X, [H|T], [H|R]):-delete_il(X, T, R).

search_it(_, T):-var(T),!,fail. 
search_it(Key, t(Key, _, _)):-!. 
search_it(Key, t(K, L, _)):-Key<K, !, search_it(Key, L). 
search_it(Key, t(_, _, R)):-search_it(Key, R). 

insert_it(Key, t(Key, _, _)):-!. 
insert_it(Key, t(K, L, _)):-Key<K, !, insert_it(Key, L). 
insert_it(Key, t(_, _, R)):-insert_it(Key, R).

delete_it(_, T, T):-var(T),!. 
delete_it(Key, t(Key, L, R), L):-var(R),!. 
delete_it(Key, t(Key, L, R), R):-var(L),!. 
delete_it(Key, t(Key, L, R), t(Pred,NL,R)):-!,get_pred(L,Pred,NL). 
delete_it(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_it(Key,L,NL). 
delete_it(Key, t(K,L,R), t(K,L,NR)):-delete_it(Key,R,NR). 

get_pred(t(Pred, L, R), Pred, L):-var(R),!. 
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

%%Exercitiul 1 Concatenează 2 liste incomplete 
append_it(L2, L1):-var(L1), !, L1=L2.  
append_it(L2, [_|T]):- append_it(L2, T). 

%%Exercitiul 2 Inversează o listă incompletă 
reverse_fwd(L, R, R1):-var(L), !, append(R, _, R1).
reverse_fwd([H|T], Acc, R):-reverse_fwd(T, [H|Acc], R).
reverse_it(L, R):- reverse_fwd(L, [], R).

%%Exercitiul 3  Convertește o listă incompletă într-o listă completă și viceversa
convert_c_it(L1, R):- append(L1, _, R).  
convert_it_c(L1, R):- append(L1, [], R), !.  

%%Exercitiul 4 Traversează un arbore incomplet în pre-ordine
preorder(T, _):- var(T), !.
preorder(t(K,L,R), List):-preorder(L,LL), preorder(R, LR),  append([K|LL], LR, List), !.
preorder(nil, []):-!. 

%%Exercitiul 5 Calculează înălțimea unui arbore incomplet
max(H1, H2, H1):-H1>H2, !.
max(_, H2, H2).

height(T, 0):-var(T), !. 
height(t(_, L, R), H):-height(L, H1),  height(R, H2), max(H1, H2, H3),  H is H3+1. 

%%Exercitiul 6
%% complet to incomplet
tree1(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))).
convert_tree_c_it(nil, _):-!. 
convert_tree_c_it(t(K, L, R), t(K, NL, NR)):-convert_tree_c_it(L, NL), convert_tree_c_it(R, NR).
%% incomplet to complet
treeIncomplet(t(7, t(5, t(3,_,_), t(6,_,_)), t(11,_,_))).
convert_tree_it_c(T, nil):-var(T),!. 
convert_tree_it_c(t(K, L, R), t(K, NL, NR)):-convert_tree_it_c(L, NL), convert_tree_it_c(R, NR).


%%Exercitiul 7 Aplatizează o listă adâncă incompletă  

