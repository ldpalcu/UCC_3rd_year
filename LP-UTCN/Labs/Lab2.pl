% 2.1 GCD
gcd(X,X,X).
gcd(X,Y,Z):- X>Y, R is X-Y, gcd(R,Y,Z).
gcd(X,Y,Z):- X<Y, R is Y-X, gcd(X,R,Z).
% 2.2 Factorial
fact(0,1).
fact(N,F):-N>0, N1 is N-1, fact(N1,F1), F is F1*N.

fact1(0,FF,FF).
fact1(N,FP,FF):-N>0, N1 is N-1, FP1 is FP*N, fact1(N1,FP1,FF).
%2.3 FOR loop
do(X, I, R):- R is X+I.

for(In,In,0).
for(In,Out,I):-
    I>0,
    NewI is I-1,
    do(In,I,Intermediate),
    for(Intermediate,Out,NewI).

% 2.2 Quiz Exercises
% 2.2.1 Least Common Multiplier
lcm(X,X,X).
lcm(X,Y,Z):- gcd(X,Y,R), Z is (X*Y)/R.
%Fibonacci Sequence
fib(0,0).
fib(1,1).
fib(X,Y):-X>0, X1 is X-1, X2 is X-2, fib(X1,R1), fib(X2,R2), Y is R1+R2.
%Repeat...until
repeat(Low,High):-
    write(Low),
    nl,
    NewLow is Low+1,
    NewLow =< High,
    repeat(NewLow,High).
%While
while(Low,High):-
    Low =< High,
    write(Low),
    nl,
    NewLow is Low+1,
    while(NewLow,High).
%2.3 Problems
%Triangle Inequality
triangle(X,Y,Z):-
    S1 is X+Y, S1>Z,
    S2 is X+Z, S2>Y,
    S3 is Y+Z, S3>Z.
%2nd order equation
delta(A,B,C,D):- D is B*B - 4*A*C.
solve_eq2_first(A,B,C,X):-
    D is B*B - 4*A*C,
    (D < 0, X is 0;
     D = 0, X is -B/2/A;
     D > 0, X is (-B-sqrt(D))/2/A).
 solve_eq2_second(A,B,C,X):-
      D is B*B - 4*A*C,
      (D < 0, X is 0;
       D = 0, X is -B/2/A;
       D > 0, X is (-B+sqrt(D))/2/A).

