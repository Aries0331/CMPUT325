tag(1).
tag(2).
label(a).
label(b).
label(c).

p([]).
p([T, L|R]) :- tag(T), label(L), p(R).
q([L|R]) :- label(L), p(R).
r(X) :- q(X).
r(X) :- p(X).


member(A, [A|_]).
member(A, [B|L]) :- A\=B, member(A, L).
a(X, L, L) :- member(X, L), !.
a(X, L, [X|L]).


subset([],[]).
subset([A|S],[A|S1]) :- subset(S,S1).
subset(S,[B|S1]) :- subset(S,S1).


divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).

isPrime(2) :- true,!.
isPrime(X) :- not(divisible(X, 2)).


primes(A,B,P) :- findall(X, (between(A,B,X), isPrime(X)), P).


primepairs(A,B,PP) :- findall((X,Y), (between(A,B,X), (between(A,B,Y)),isPrime(X), isPrime(Y),Y =:= X+2), PP).
