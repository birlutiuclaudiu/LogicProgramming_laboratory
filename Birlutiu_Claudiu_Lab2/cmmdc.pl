%varianta 1
cmmdc1(X,X,X).
cmmdc1(X,Y,Z) :- X>Y, Diff is X-Y, cmmdc1(Diff, Y, Z).
cmmdc1(X,Y,Z) :- X<Y, Diff is Y-X, cmmdc1(X, Diff, Z).

%varianta2 
cmmdc2(X,0,X). % parametrul 3 îi rezultatul la cmmdc
cmmdc2(X,Y,Z) :- Rest is X mod Y, cmmdc2(Y,Rest,Z).

%cel mai mic multiplu comun
cmmmc(X,Y,Z)  :- cmmdc1(X,Y,R), P is X*Y, Z is P / R.

