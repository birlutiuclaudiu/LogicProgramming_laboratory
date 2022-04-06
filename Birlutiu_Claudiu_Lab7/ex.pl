%%LAB 7 %Birlutiu Claudiu-Andrei

inorder(t(K,L,R), List):-inorder(L,LL), inorder(R,LR),  append(LL, [K|LR], List). 
inorder(nil, []). 

preorder(t(K,L,R), List):-preorder(L,LL), preorder(R, LR),  append([K|LL], LR, List).
preorder(nil, []). 

postorder(t(K,L,R), List):-postorder(L,LL), postorder(R, LR),  append(LL, LR,R1), append(R1, [K], List). 
postorder(nil, []).


tree1(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))). 
tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))). 

pretty_print(nil, _).
pretty_print(t(K,L,R), D):-D1 is D+1, pretty_print(L, D1),  print_key(K, D),  pretty_print(R, D1). 

print_key(K, D):-D>0, !, D1 is D-1, write('\t'), print_key(K, D1). 
print_key(K, _):-write(K), write('\n').

search_key(Key, t(Key, _, _)):-!.
search_key(Key, t(K, L, _)):-Key<K, !, search_key(Key, L).
search_key(Key, t(_, _, R)):-search_key(Key, R). 


insert_key(Key, nil, t(Key, nil, nil)).              % inserează cheia în arbore
insert_key(Key, t(Key, L, R), t(Key, L, R)):-!.      % cheia există deja 
insert_key(Key, t(K,L,R), t(K,NL,R)):- Key<K,!,insert_key(Key,L,NL). 
insert_key(Key, t(K,L,R), t(K,L,NR)):- insert_key(Key, R, NR).

delete_key(Key, t(Key, L, nil), L):-!. 
delete_key(Key, t(Key, nil, R), R):-!.
delete_key(Key, t(Key, L, R), t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_key(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_key(Key,L,NL). 
delete_key(Key, t(K,L,R), t(K,L,NR)):-delete_key(Key,R,NR).

get_pred(t(Pred, L, nil), Pred, L):-!. 
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

height(nil, 0). 
height(t(_, L, R), H):-height(L, H1),  height(R, H2), max(H1, H2, H3),  H is H3+1. 


%%% EX1
treeTernar(t(6, t(4, t(2,nil,nil,nil), nil, t(7,nil,nil,nil)), t(5, nil, nil, nil),  t(9,t(3,nil,nil,nil), nil , nil))). 

inorder2(t(K,L,M,R), List):-inorder2(L,LL), inorder2(M, MM), inorder2(R,LR),  append(LL, MM, List1), append(List1, [K|LR], List). 
inorder2(nil, []).

preorder2(t(K,L,M,R), List):-preorder2(L,LL), preorder2(M, MM), preorder2(R,LR),  append([K|LL], MM, List1), append(List1, LR, List). 
preorder2(nil, []).

postorder2(t(K,L,M,R), List):-postorder2(L,LL), postorder2(M, MM), postorder2(R,LR),  append(LL, MM, List1), append(List1, LR, List2), append(List2, [K], List). 
postorder2(nil, []).


%%%% EX 2: Height for ternar tree
max(H1, H2, H1):-H1>H2, !.
max(_, H2, H2).

height2(nil, 0). 
height2(t(_, L,M,R), H):-height2(L, H1), height2(M, H3) ,height2(R, H2), max(H1, H2, H4), max(H3, H4, H5),  H is H5+1. 


%% Ex 3 
delete_key2(Key, t(Key, L, nil), L):-!. 
delete_key2(Key, t(Key, nil, R), R):-!.
delete_key2(Key, t(Key, L, R), t(Succ,L,NR)):-!,get_succ(R,Succ,NR).
delete_key2(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_key2(Key,L,NL). 
delete_key2(Key, t(K,L,R), t(K,L,NR)):-delete_key2(Key,R,NR).

get_succ(t(Succ, nil, R), Succ, R):-!. 
get_succ(t(Key, L, R), Succ, t(Key, NL, R)):-get_succ(L, Succ, NL).


%% Ex4 - frunzele din arbore
get_leaves(t(K, L, R), List):- L=nil, R = nil,!, get_leaves(L, List1), get_leaves(R, List2), append(List1, List2, List3), List= [K|List3].
get_leaves(t(_, L, R), List):- get_leaves(L, List1), get_leaves(R, List2), append(List1, List2, List).
get_leaves(nil, []).


%Ex 5 - determinarea diametrului unui arbore
diameter(t(_, L, R), D):- diameter(L, D1), diameter(R, D2), height(L, H1), height(R, H2), H3 is H1+H2+1, max(D1, D2, D3), max(D3, H3, D).
diameter(nil, 0).

%Ex6 nodurile de la aceeasi adancime: 0 -e radacina
get_depth_acc(t(K, L, R), D, Acc, List):- D=Acc,!, Acc1 is Acc+1, get_depth_acc(L, D, Acc1, List1), get_depth_acc(R, D, Acc1, List2), append(List1, List2, List3), List= [K|List3].
get_depth_acc(t(_, L, R), D, Acc, List):- Acc1 is Acc+1, get_depth_acc(L, D, Acc1, List1), get_depth_acc(R, D, Acc1, List2), append(List1, List2, List).
get_depth_acc(nil, _, _, []).
get_depth(Tree, D, List):- get_depth_acc(Tree, D, 0, List). %functia apelata


%Ex7 pentru simetric; nu conteaza cheile
is_mirror(nil, nil):-true.
is_mirror(t(_, L1, R1), t(_, L2, R2)):- is_mirror(L1, R2), is_mirror(R1, L2).
symmetric(t(_, L, R)):- is_mirror(L, R).

