man(john). 

parent(john,david).
parent(john,edward). 
father(X,Y):- man(X), parent(X,Y).

member(H,[H|T]). 
member(X,[H|T]):- member(X,T).
%member(X,[]):-fail.




list_length1([],R). 
list_length1([_|T],PR):-NPR is PR+1,list_length1(T,NPR).

reverse1([],[]).
reverse1([H|T],R):-reverse1(T,PR),  append(PR,[H],R).


delete(X, [X|T], T):-!.
delete(X, [H|T], [H|R]):- delete(X, T, R).
delete(_, [], []).


append3_3([Head|Tail],List2,List3,[Head|Rest]):- append3_3(Tail,List2,List3,Rest). 
append3_3([],[Head|Tail],List,[Head|Rest]):-append3_3([],Tail,List,Rest).
append3_3([],[],List,List).

deleteall(H,[H|T],R):- !,deleteall(H,T,R). 
deleteall(X,[H|T],[H|R]):-!,deleteall(X,T,R).
deleteall(_,[],[]).