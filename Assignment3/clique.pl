node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).

xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).

xappend([H|T], L, [H|R]) :- xappend(T, L, R).

connect(_, []).
connect(A, [F|R]) :-  (edge(A, F) ; edge(F, A)) , connect(A, R).
allConnected([]).
allConnected([A|L]) :- connect(A, L) , allConnected(L).