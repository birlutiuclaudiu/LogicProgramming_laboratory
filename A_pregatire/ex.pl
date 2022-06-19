replace_all(_, [], _, RE, RE):-!. 
replace_all(X, [X|T], Y, [Y, X, Y|RS], RE):- !, replace_all(X, T, Y, RS, RE). 
replace_all(X, [H|T], Y, [H|RS], RE):- replace_all(X, T, Y, RS, RE). 