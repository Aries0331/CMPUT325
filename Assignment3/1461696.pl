/**
*	Name: Jinzhu Li
*	Student ID: 1461496
*	Course: CMPUT 325 B1
*	Assignment 3
*/

% Q1 xreverse
% Define the predicate xreverse(+L, ?R) to reverse a list, 
% where L is a given list and R is either a variable or another given list.

% keep remove the first element of given list and append it to the end of the
% result list. Use [F|R] to split the first and rest of given list.
% RevR is the reverse of rest. T is the resulting list.

xreverse([], []).
xreverse([F|R], T) :- xreverse(R, RevR) , append(RevR, [F], T).



% Q2 xunique
% Define the predicate xunique(+L, ?O) where L is a given list of atoms 
% and O is a copy of L where all the duplicates have been removed. 
% O can be either a variable or a given list. 
% The elements of O should be in the order in which they first appear in L.

%

xunique([],[]).
xunique([F|R], [F|L]) :- delete(R, F, T) , xunique(T, L).



% Q3 xdiff
% Define the predicate xdiff(+L1, +L2, -L) where L1 and L2 are given lists of atoms, 
% and L contains the elements that are contained in L1 but not L2

% the subtract predicate remove the same element in L2 from L1
% but then we may have duplicates in L2, 
% so call xunique defined above to remove all the duplicates in L1
% and store the result in Res

xdiff(L1, L2, Res) :- subtract(L1, L2, L) , xunique(L, Res).


% Q4 removeLast
% Define the predicate removeLast(+L, ?L1, ?Last) where L is a given non-empty list, 
% L1 is the result of removing the last element from L, 
% and Last is that last element. L1 and Last can be either variables or given values.

% the base case is the last element of a list with one element is the element it self
%  

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

% Q5 

% 5.1 allConnected
% allConnected(L) to test if each node in L is connected to each other node in L.

% connect(A,L) is to test if A is connected to every node in L.
% A node A is connected to another node B if either edge(A,B) or edge(B,A) is true.
% first compare A and the first of L, then compare A with rest of L recursively
connect(_, []).
connect(A, [F|R]) :- (edge(A, F); edge(F, A)), connect(A, R).

% allConnected(L) is true for an empty list, L= []
% allConnected([A|L]) if F is connected to every node in L and allConnected(L)
allConnected([]).
allConnected([A|L]) :- connect(A, L), allConnected(L).

% 5.2 maxclique
% maxclique(+N, -Cliques) to compute all the maximal cliques of size N that are contained in a given graph

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).


cliqueflitter(X, N) :- clique(X), length(X, N).

xmaxclique(N, Cluques) :-  findall(Y, cliqueflitter(Y, N), Cluques).

nonmax(N, Cliques) :- clique(Cliques), length(Cliques, N), cliqueflitter(Larger, K), K > N, xsubset(Cliques, Larger).

xremove([],X,X).
xremove([H|T], L, L2) :- delete(L, H, L1), xremove(T, L1, L2).

maxclique(N, Clique) :- findall(X, nonmax(N, X), Nonlist), xmaxclique(N, Candidates), xremove(Nonlist, Candidates, Clique).
