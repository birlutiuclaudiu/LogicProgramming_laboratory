%Birlutiu Claudiu-Andrei

:-dynamic neighbor/2.

neighbor(a, [b, d]). 
neighbor(b, [a, c, d]).
neighbor(c, [b, d]).

neighb_to_edge:-retract(neighbor(Node,List)),!, %extrage un predicat neighbor și apoi îl procesează 
   process(Node,List),    
   neighb_to_edge. 
neighb_to_edge.

process(Node, [H|T]):- assertz(edge(Node, H)), process(Node, T). 
process(Node, []):- assertz(node(Node)). 


%%%%   PATH
% path(Source, Target, Path)
path(X,Y,Path):-path(X,Y,[X],Path).   % drumul parțial începe cu punctul de pornire
path(Y,Y,PPath, PPath).  %când ținta este egală cu sursa am terminat

%node(a). node(b). node(c). node(d).
%node(e). node(f). node(g). node(h).
%edge(a, b).     edge(b,a).
%edge(a, d).     edge(d,a).
%edge(b, d).     edge(d,b).
%edge(d, c).     edge(c, d).
%edge(b,c).      edge(c, b).
%edge(e,g). edge(g,e). 
%edge(e,f). edge(f,e).

path(X,Y,PPath, FPath):-edge(X,Z),
            not(member(Z, PPath)),
            path(Z, Y, [Z|PPath], FPath).


% restricted_path(Source, Target, RestrictionsList, Path)
restricted_path(X,Y,LR,P):- path(X,Y,P), 
        reverse(P,PR), 
        check_restrictions(LR, PR).

% verificăm dacă se respectă restricția 
check_restrictions([],_):- !. 
check_restrictions([H|T], [H|R]):- !, check_restrictions(T,R). 
check_restrictions(T, [_|L]):-check_restrictions(T,L). 


%%%% OPTIMAL
optimal_path(X,Y,Path):- asserta(sol_part([],100)),  % distanța maximă inițială 
                        path(X,Y,[X],Path,1).

optimal_path(_,_,Path):-  retract(sol_part(Path,_)).

path(Y,Y,Path,Path,LPath):- retract(sol_part(_,_)),!,
            asserta(sol_part(Path,LPath)),
            fail.

path(X,Y,PPath,FPath,LPath):-edge(X,Z),
            not(member(Z,PPath)),
            LPath1 is LPath+1, 
            sol_part(_,Lopt),
            LPath1<Lopt,
            path(Z,Y,[Z|PPath],FPath,LPath1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% exercitiul 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Scrieți un predicat care convertește din A1B2 (edge-clause)  în  A2B2
:-dynamic edge1/2.
:-dynamic node1/1.

node1(e). node1(f). node1(g). node1(h).
edge1(e,g).      edge1(g,e).
edge1(e,f).      edge1(f,e).
edge1(e, h).     edge1(h,e).
edge1(f,g).      edge1(g,f).

% dupa ideea de la primul 
edge_to_neighb:-retract(node1(X)),!, %extrage un predicat neighbor și apoi îl procesează 
         process2(X, N),  assertz(neighbor1(X, N)),  
        edge_to_neighb. 
edge_to_neighb.

process2(X, N):- retract(edge1(X,Y)), ! ,process2(X, N1), N=[Y|N1].
process2(_, []).
% edge_to_neighb.
% findall([X, N], neighbor1(X, N), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% exercitiul 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
% hamilton(NumOfNodes, Source, Path) 
node2(aa). node2(bb). node2(cc). node2(dd).
edge(aa, bb).     edge(bb,aa).
edge(aa, dd).     edge(dd,aa).
edge(bb, dd).     edge(dd,bb).
edge(dd, cc).     edge(cc, dd).
edge(bb,cc).      edge(cc, bb).


hamilton(NN, X, Path):- hamilton_path(NN,X, X, [X], Path).

validate(Target, Target, 1, _):-!.
validate(Z, _, _, IntPath):-not(member(Z, IntPath)).

hamilton_path(0, Target, Target, Path, Path):-reverse(Path, RevPath),
                                        not(retract(RevPath)),
                                        assertz(Path),!.
hamilton_path(0, Target, Target, Path, Path):-!,fail.  %%pentru a exclude duplicatele
hamilton_path(NN, Source, Target, IntPath, Path):- edge(Source, Z),
                         validate(Z, Target, NN, IntPath),
                         NN1 is NN-1, 
                         hamilton_path(NN1, Z, Target, [Z|IntPath], Path).



% APEL:   hamilton(4, aa, N).   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% exercitiul 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             
:-dynamic edge3/3.
edge3(a, b,1).     edge3(b,a, 1).
edge3(a, d, 2).    edge3(d,a,  2).
edge3(b, d, 3).    edge3(d,b, 3).
edge3(d, c, 1).    edge3(c, d, 1).
edge3(b,c, 4).     edge3(c, b, 4).

optimal_path2(X,Y,Path):- asserta(sol_part2([],100)),  % distanța maximă inițială 
                        path2(X,Y,[X],Path,0).

optimal_path2(_,_,Path):-  retract(sol_part2(Path,_)).

path2(Y,Y,Path,Path,LPath):- retract(sol_part2(_,_)),!,
            asserta(sol_part2(Path,LPath)),
            fail.

path2(X,Y,PPath,FPath,LPath):-edge3(X,Z,COST),
            not(member(Z,PPath)),
            LPath1 is LPath + COST, 
            sol_part2(_,Lopt),
            LPath1<Lopt,
            path2(Z,Y,[Z|PPath],FPath,LPath1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% exercitiul 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%
node4(aaa). node4(bbb). node4(ccc). node4(ddd).
edge4(aaa, bbb).     edge4(bbb, aaa).
edge4(aaa, ddd).     edge4(ddd, aaa).
edge4(bbb, ddd).     edge4(ddd, bbb).
edge4(ddd, ccc).     edge4(ccc, ddd).
edge4(bbb, ccc).     edge4(ccc, bbb).


cycle(Source, Path):- cycle_path(Source, Source, [Source], Path).

validate(Target, Target, IntPath):- length(IntPath, Len), Len>2,!.
validate(Z, _, IntPath):-not(member(Z, IntPath)).


%%se va face o verificare pentru a exclude doua cicluri identice; path reverse 
cycle_path(Target, Target, Path, Path):-length(Path, Len), Len>2, reverse(Path, RevPath),
                                        not(retract(RevPath)),
                                        assertz(Path),!.
cycle_path(Target, Target, Path, Path):-length(Path, Len), Len>2,
                                        !, fail.

cycle_path(Source, Target, IntPath, Path):-  edge4(Source, Z), 
                         validate(Z, Target, IntPath),
                         cycle_path(Z, Target, [Z|IntPath], Path).