%append(nil, X,X).
%append(cons(A, L1), L2, cons(A, L3)) :- append(L1, L2, L3).

%p(W) :- append([a1, a2], [b1], W).
%q(X,Y) :- append(X,Y,  [a1, a2]).

xreverse([], []).
xreverse([F|R], T) :- xreverse(R, RevR) , append(RevR, [F], T).

xunique([],[]).
xunique([F|R], [F|L]) :- delete(R, F, T) , xunique(T, L).

xdiff([], [], []).
xdiff(L1, L2, L) :- subtract(L1, L2, L) , xunique(L, L).

removeLast([X], [], X).
removeLast([F|R], [F|L], Last) :- removeLast(R, L, Last). 

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

linked(A, B) :- edge(A, B); edge(B, A).

connected(_, []).
connected(A, [H|T]) :- linked(A, H), connected(A, T).

llConnected([]).
allConnected([A|L]) :- connected(A, L), allConnected(L).

clique(L) :- findall(X,node(X),Nodes),
             xsubset(L,Nodes),
             allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :-
  append(_, [X|Set1], Set),
  xsubset(Xs, Set1).

cliqueflitter(X, N) :- clique(X), length(X, N).
xmaxclique(N, Cluques) :-  findall(Y, cliqueflitter(Y, N), Cluques).
nonmax(N, Cliques) :- clique(Cliques), length(Cliques, N), cliqueflitter(Larger, K), K > N, xsubset(Cliques, Larger).
xremove([],X,X).
xremove([H|T], L, L2) :- delete(L, H, L1), xremove(T, L1, L2).
maxclique(N, Clique) :- findall(X, nonmax(N, X), Nonlist), xmaxclique(N, Candidates), xremove(Nonlist, Candidates, Clique).

