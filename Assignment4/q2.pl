%Q2 disarm/3
% A, B are two lists represents two contries divisions, S is the solution to solve Peace and War
disarm(A, B, S) :- disarm(A, B, S, 0), !.

% Basecase
disarm([], [], [], _).

% disarm/4
% There is an extra parameter I, which record the power of dismantled divs for each country in this row
% When we are in the case of A dismantle 2 div and B dismantle 1
disarm(A, B, [[[X, Y], [T]]|S], I) :-
  % select 2 div from A, and 1 div from B
  select(X, A, A1),
  select(Y, A1, A2),
  select(T, B, B1),
  % Just want to have the smaller one element which is X here, in the first place in ([X, Y], T)
  X #=< Y,
  % A and B want to 'play a fair game' in each row
  X + Y #= T,
  % to make the result start from the smallest dismantle, we store the sum to the next time
  T #>= I,
  disarm(A2, B1, S, T).

% When we are in the case of B dismantle 2 div and A dismantle 1
% Same analysis as above
disarm(A, B, [[[T], [X, Y]]|S], I) :-
  select(X, B, B1),
  select(Y, B1, B2),
  select(T, A, A1),
  X #=< Y,
  X + Y #= T,
  T #>=  I,
  disarm(A1, B2, S, T).