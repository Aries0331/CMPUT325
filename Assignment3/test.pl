append(nil, X,X).
append(cons(A, L1), L2, cons(A, L3)) :- append(L1, L2, L3).

p(W) :- append([a1, a2], [b1], W).
q(X,Y) :- append(X,Y,  [a1, a2]).

xreverse([], []).
xreverse([F|R], T) :- xreverse(R, RevR) , append(RevR, [F], T).

xunique([],[]).
xunique([F|R], [F|L]) :- delete(R, F, T) , xunique(T, L).

xdiff([], [], []).
xdiff(L1, L2, L) :- subtract(L1, L2, L) , xunique(L, L).

removeLast([X], [], X).
removeLast([F|R], [F|L], Last) :- removeLast(R, L, Last). 

%5.1
connect(_, []).
connect(A, [F|R]) :-  (edge(A, F) ; edge(F, A)) , connect(A, R).
allConnected([]).
allConnected([A|L]) :- connect(A, L) , allConnected(L).

%5.2
clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).
xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).



