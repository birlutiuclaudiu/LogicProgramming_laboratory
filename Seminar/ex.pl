edge(a,e). edge(e,a).
edge(b,e). edge(e,b).
edge(c,e). edge(e,c).
edge(c,f). edge(f,c).
edge(c,g). edge(g,c).
edge(d,f). edge(f,d).
edge(d,g). edge(g,d).




collect_reverse(L,P):-  retract(nod_vizitat(X)), !,   collect_reverse([X|L],P). 
collect_reverse(L,L).

b_search(X,_):- % parcurgerea nodurilor 
    assert(color(X, red)), 
    assertz(nod_de_expandat(X)),  
    bf_search. 


bf_search:-  retract(nod_de_expandat(X)),!,
                expand(X), 
                bf_search.
bf_search.

negate(blue, red).
negate(red, blue). 

process_notColor(X, Y):- not(color(Y, _)), !, color(X, Color),
        negate(Color, YColor), 
        assert(color(Y, YColor)),
        assertz(nod_de_expandat(Y)).

process_notColor(X, Y):-color(X, Color), color(Y, Color), !, fail.
process_notColor(_, _).


expand(X):- edge(X,Y), not(process_notColor(X, Y)), !, fail. 
expand(_).
