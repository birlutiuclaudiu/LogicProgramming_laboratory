%%Birlutiu Claudiu-Andrei

edge(6,4). edge(4,6).
edge(4,3). edge(3,4).
edge(4,5). edge(5,4).
edge(5,2). edge(2,5).
edge(2,3). edge(3,2).
edge(5,1). edge(1,5).
edge(2,1). edge(1,2).

:- dynamic nod_vizitat/1.
d_search(X,_):-df_search(X,_). 
% parcurgerea nodurilor 
d_search(_,L):-!, collect_reverse([],L). % colectarea rezultatelor

df_search(X,L):-  asserta(nod_vizitat(X)),  
                edge(X,Y),  
                not(nod_vizitat(Y)), 
                df_search(Y,L).

collect_reverse(L,P):-  retract(nod_vizitat(X)), !,   
            collect_reverse([X|L],P).
collect_reverse(L,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    BFS     %%%%%%%%%%%%%%%%%%%%%
b_search(X,_):- % parcurgerea nodurilor  
    assertz(nod_vizitat(X)),  
    assertz(nod_de_expandat(X)),  
    bf_search. 
b_search(_,R):-!, collect_reverse([],R). % colectarea rezultatelor


bf_search:-  retract(nod_de_expandat(X)),
                expand(X),!, 
                bf_search.
expand(X):-   edge(X,Y),  
        not(nod_vizitat(Y)),  
        asserta(nod_vizitat(Y)),  
        assertz(nod_de_expandat(Y)),  fail. 
expand(_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EX1%%%%%%%%%%%%%%%%%%%%%%%%
d_search2(X, Depth, _):-df_search2(X, Depth, _). 
% parcurgerea nodurilor 
d_search2(_, _, L):-!, collect_reverse2([],L). % colectarea rezultatelor



df_search2(X,Depth, L):-  asserta(nod_vizitat(X)), 
                edge(X,Y),  
                not(nod_vizitat(Y)), Depth>0, Depth1 is Depth -1,
                df_search2(Y,Depth1, L).

collect_reverse2(L,P):-  retract(nod_vizitat(X)), !,   
            collect_reverse2([X|L],P).
collect_reverse2(L,L).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%