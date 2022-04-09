woman(ana).
woman(sara). 
woman(ema).
woman(maria).
woman(carmen).
woman(irina).
woman(dorina).

man(andrei). 
man(george).
man(alex).
man(mihai). 
man(alex).
man(marius).

parent(maria, ana).   % maria este părintele anei
parent(george, ana).  % george este părintele anei 

parent(maria, andrei).
parent(george, andrei).

parent(marius, maria). 
parent(dorina, maria). 

parent(mihai, george). 
parent(irina, george).

parent(mihai, carmen).
parent(irina, carmen).

parent(carmen, ema).
parent(alex, ema).

parent(carmen, sara).
parent(alex, sara).

mother(X,Y) :- woman(X), parent(X,Y).
father(X,Y) :- man(X), parent(X, Y). 
son(X, Y) :- man(X), parent(Y, X).
daughter(X, Y) :- woman(X), parent(Y, X).

sibling(X, Y) :- parent(Z, X), parent(Z, Y). 
sister(X, Y) :- sibling(X, Y), woman(X).
brother(X, Y) :- sibling(X, Y), man(X).
aunt(X,Y) :- sister(X,Z), parent(Z,Y).
uncle(X,Y) :- brother(X,Z), parent(Z,Y).

grandmother(X, Y) :- mother(X, Z),  parent(Z,Y).
grandfather(X, Y) :- father(X, Z),  parent(Z,Y).

ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z,Y).  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  