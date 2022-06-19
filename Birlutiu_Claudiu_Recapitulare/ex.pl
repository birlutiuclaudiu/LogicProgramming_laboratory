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
divizori(X, X, [X]):-!.
divizori(X, Div, R):- Rez is X mod Div, Rez = 0, !, Div1 is Div + 1, divizori(X, Div1, R1), R=[Div|R1].
divizori(X, Div, R):- Div1 is Div + 1, divizori(X, Div1, R).
divizor(X, R):- divizori(X, 1, R).

%4 conversion
 
 to_binary_acc(0, Acc, Acc):-!.
 to_binary_acc(X, Acc, R):- H is X mod 2, X1 is X div 2, Acc1=[H|Acc], to_binary_acc(X1, Acc1, R).
 to_binary(X, R):- to_binary_acc(X, [], R).

 %5  reverse 
reverse_acc(0, Acc, Acc):-!.
reverse_acc(X, Acc, R):- Cif is X mod 10, Acc1 is Acc*10+ Cif, X1 is X div 10, reverse_acc(X1,Acc1,R).
reverse_cif(X, R):-reverse_acc(X, 0, R).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    OPERATII PE LISTE %%%%%%%%%%%%%%%%%
%6   Calculați suma elementelor unei liste.   
suma([], 0):-!.
suma([H|T], R):- suma(T, R1), R is H+R1.

%7 Dublați elementele impare și ridicați la pătrat cele pare. 
even(X):- X1 is X mod 2, X1=0, !.
numbers([], []):-!.
numbers([H|T], [H1|R]):- even(H),!, H1 is H*H,  numbers(T, R).
numbers([H|T], [H1|R]):- H1 is 2*H,  numbers(T, R).

%8Extrageți numerele pare în E și numerele impare în O. 

separate_parity([], [], []).
separate_parity([H|T], [H|E], O):- even(H), !, separate_parity(T, E, O).
separate_parity([H|T], E, [H|O]):-separate_parity(T, E, O).

%9Înlocuiți toate aparițiile lui X cu Y.  
replace_all(_, _, [], []):-!.
replace_all(X, Y, [X|T], [Y|R]):-!,replace_all(X,Y, T, R).
replace_all(X, Y, [H|T], [H|R]):-replace_all(X, Y, T, R).

%10 Înlocuiți toate aparițiile lui of X într-o listă diferență (al doilea si al treilea argument) cu secvența [Y,X,Y]. 

%11  Sțergeți aparițiile lui X pe poziții pare (numerotatea poziției începe de la 1). 
delete_pos_even([], _, []):-!.
delete_pos_even([H],_, [H]):-!.
delete_pos_even([H,X|T], X, [H|R]):- !, delete_pos_even(T, X, R).   
delete_pos_even([H1,H2|T], X, [H1,H2|R]):- delete_pos_even(T, X, R).  

%12 Ștergeți elementele de pe poziții divizibile cu K.  
divided(X, Y):- R is X mod Y, R=0,!.
sterge_k_w([],_, _, []).
sterge_k_w([_|T],Pos, K, R):- divided(Pos, K), !, Pos2 is Pos + 1, sterge_k_w(T, Pos2, K, R). 
sterge_k_w([H|T],Pos, K, [H|R]):- Pos2 is Pos + 1, sterge_k_w(T, Pos2, K, R). 
sterge_k(L, K, R):-sterge_k_w(L, 1, K, R).

%13. Ștergeți elementele de pe poziții divizibile cu K de la finalul listei.
sterge_k_final_w([],_, _, []).
sterge_k_final_w([_|T],Pos, K, R):- divided(Pos, K), !, Pos2 is Pos - 1, sterge_k_final_w(T, Pos2, K, R). 
sterge_k_final_w([H|T],Pos, K, [H|R]):- Pos2 is Pos - 1, sterge_k_final_w(T, Pos2, K, R). 
sterge_k_final(L, K, R):- length(L, Len), sterge_k_final_w(L, Len, K, R).

%14. Ștergeți toate aparițiile elementului minim/maxim dintr-o listă.  
delete_all(_, [], []):-!.
delete_all(X, [X|T], R):- !, delete_all(X, T, R).
delete_all(X, [H|T], [H|R]):-delete_all(X, T, R).

find_min([], _):- fail.
find_min([H], H):-!.
find_min([H|T], H):- find_min(T, M), H<M,!.
find_min([_|T], M):- find_min(T, M).

delete_all_min(L, R):-find_min(L, M), delete_all(M, L, R).


%15 Ștergeți elementele duplicate dintr-o listă (păstrează prima sau ultima apariție).
%lasa ultima aparitie 
sterge_duplicate([], []):- !.
sterge_duplicate([H|T], R):- member(H, T), !, sterge_duplicate(T, R).
sterge_duplicate([H|T], [H|R]):-sterge_duplicate(T, R).


%16 inverseaza o lista incompleta

reveres_in_acc(L, Acc, R):-var(L), !, append(Acc, _, R).
reveres_in_acc([H|T], Acc, R):- Acc1 = [H|Acc], reveres_in_acc(T, Acc1, R).

reverse_in(L, R):- reveres_in_acc(L, [], R).

%17 inversati elementele dintr-o lista, dupa pozitia k
reverse_comp_acc([], Acc, Acc):-!.
reverse_comp_acc([H|T], Acc, R):- reverse_comp_acc(T, [H|Acc], R).
reverse_comp(L, R):- reverse_comp_acc(L, [], R).
reverse_k([], _, []):-!.
reverse_k(L, 0, R):- !, reverse(L, R).
reverse_k([H|T], K, [H|R]):- K1 is K-1, reverse_k(T, K1, R).

%18   Codificați o listă cu RLE (Run-length encoding). Doua sau mai multe elementele consecutive 
%se înlocuiesc cu (element, nr_apariții). Dacă nr_aparitii=1 atunci se scrie doar elementul.  
delete_all_count(_, [], [], 1):-!.
delete_all_count(X, [X|T], R, Count):- !, delete_all_count(X, T, R, Count1), Count is Count1 +1.
delete_all_count(X, [H|T], [H|R], Count):-delete_all_count(X, T, R, Count).
rle_encode([], []):-!.
rle_encode([H|T], [(H, Count)|R]):- member(H, T), !, delete_all_count(H, T, Rnew, Count), rle_encode(Rnew, R).
rle_encode([H|T], [H|R]):- rle_encode(T, R).


%19 Rotiți lista K poziții în dreapta. 
%rotate_k([1,2,3,4,5,6|_], 2, R). 