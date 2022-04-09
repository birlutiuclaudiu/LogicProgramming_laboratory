%Birlutiu Claudiu-Andrei
%pentru fibbonacci 
fib(X,R) :- X>1, X1 is X-1,fib(X1,Y1),X2 is X-2,fib(X2,Y2), R is Y1+Y2.
fib(1,0).                     
fib(0,1).
fib(N,0) :- N<0.

%doar un apel recursiv 
fib2(N, R) :- N>1,fib2(0,1,1,N,R).
fib2(1, 1).
fib2(0, 0).
fib2(_, F1, N, N, F1).
fib2(F0, F1, Interm, N, R) :-  I2 is Interm + 1, F2 is F0+F1,fib2(F1, F2, I2, N, R).


