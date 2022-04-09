animal(elefant).
suntem_in_sala108.

loves(jonh, marry).

mai_inalt(X,Y) :- inaltime(X, Hx), inaltime(Y,Hy), Hx>Hy.

inaltime(florin, 8).
inaltime(claudiu, 4).

%drum
drum(X,Y) :- muchie(X,Y).
drum(X,Y) :- muchie(X, Intermediar), drum(Intermediar, Y).
muchie(a,b).
muchie(b,c).
muchie(c,a).

