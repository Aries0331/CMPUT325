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

% the bulit in delete predicate will delete all the element F from the list R
% not only the first appear in R but all of them
% so we can get a list T with all F removed 
% but at the same time, we force to add the first element of L to the beginning of the result
% so we can make sure there will be an element remain with all other duplicates removed

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
% removeLast keeps calling removeLast on rest of list

removeLast([X], [], X).
removeLast([F|R], [F|L], Last) :- removeLast(R, L, Last). 

/*
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
*/


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

%%% clique(L), xsubset and xappend are defined in elcass

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).

%%%

% selector is used to choose cliques with certain length N
% the result L should be a clique first and also with length N
selector(L, N) :- clique(L), length(L, N).

% find is used to find all cliques with certain length N from a list of clique
% every single Y is satisfy with the condition that they are length N and is a connected
find(N, Clique) :-  findall(Y, selector(Y, N), Clique).

% filter get those cliques with length N 
% also there exists a large clique which contains all the element in clique  
% super clique should have length large than given one 
% and the given one should be a subset of super one
filter(N, Cliques) :- clique(Cliques), length(Cliques, N), selector(Superset, K), K > N, xsubset(Cliques, Superset).

% finally we we define maxclique
% first we find all the cliques with length N and have "super" clique 
% and store in RemoveList since they will later be removed from other list
% then we find all cliques with length N as required and store them in Candidates list
% finally we remove all the cliques in RemoveList from Candidates
maxclique(N, Clique) :- findall(X, filter(N, X), RemoveList), find(N, Candidates), xdiff(Candidates, RemoveList, Clique).
