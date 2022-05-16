%% Operatii aritmetice 

%varianta2    %1
cmmdc(X, 0, X):-!.
cmmdc(X, Y, Z):- R is X mod Y, cmmdc(Y, R, Z).
%cel mai mic multiplu comun   %2
cmmc(X, Y, R):- cmmdc(X, Y, Cm), R1 is X*Y, R is R1 div Cm. 
%Decodificați o listă cu RLE (Run-length encoding). Ex: ? –  rle_decode([[a,4], [b,1] ,[c,2], [a,2], [d,1] , [e,4]],R).  R = [a,a,a,a,b,c,c,a,a,d,e,e,e,e].  

expand(H1, H2, [H1|R]):- H2>0, !, H is H2-1, expand(H1, H, R).
expand(_, 0, []).

decode( [[H1,H2]|T], R):- expand(H1, H2, L), decode(T, R1), append(L, R1,R). 
decode([], []). 

%3 divizori
divizor(X,1,[X]).
divizor(X,Div, [Div1|R]):-  Rez is X mod Div, Rez = 0, !, Div1 is Div -1, divizor(X, Div1, R).
divizor(X,Div, R):- Div1 is Div -1, divizor(X, Div1, R).