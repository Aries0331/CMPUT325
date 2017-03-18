/**
*	Name: Jinzhu Li
*	Student ID: 1461496
*	Course: CMPUT 325 B1
*	Assignment 3
*/

% Q1 xreverse
%
%
%


%Q2 xunique
xunique([],[]).
xunique([F|R], [F|L]) :- delete(R, F, T) , xunique(T, L).


%Q3 xdiff
xdiff([], [], []).
xdiff(L1, L2, L) :- subtract(L1, L2, L) , xunique(L, L).


%Q4 removeLast
removeLast([X], [], X).
removeLast([F|R], [F|L], Last) :- removeLast(R, L, Last). 