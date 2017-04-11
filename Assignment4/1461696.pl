% load clpfd libiary first 
:- use_module(library(clpfd)). 

% Question1 - Four squares
% fourSquares(+N, [-S1, -S2, -S3, -S4])
% S1 <= S2 <= S3 <= S4
% On backtracking, fourSquares should return all possible answers 
% since there may be more than one solution

% first, all the result should within the range of 0 and N
% a value greater than N will not make its suqare equal to N
% then we should satisfy the constrain that the sum of square equal to N
% Also require the values in ascending order

fourSquares(N, [S1, S2, S3, S4]) :- 
	Vars = [S1, S2, S3, S4],
	Vars ins 0..N,
	S1*S1 + S2*S2 + S3*S3 + S4*S4 #= N,
	S2 #>= S1,
	S3 #>= S2,
	S4 #>= S3,
	label([S1, S2, S3, S4]).




% Question 2 - War and Peace
% the total strength of one month's dismantlement is less than or equal to 
% the total strength of next month's dismantlement
% If there is no solution, then the program should return false

% By solving the problem, I define a sub-prefix to help
% Since we need the dismantlement in an ascending order, 
% it is necessarily to store the previous choice, ie Pre in subdisarm.
% Since we have different choices that can choose from Adivisions and Bdivisions alternatively,
% I define two prefix, they are almost the same 
% except for the number of vars choose from different divisions.
% Use select to choose from divisions also delete it after selection
% the sum of two vars from the same division should be 
% the value of another var from the other division.
% Keep doing these alternatively until get empty list
% Append the result to final result

disarm(Adivisions, Bdivisions, Solution) :- subdisarm(Adivisions, Bdivisions, Solution, 0).
subdisarm([],[],[],_).
subdisarm(Adivisions, Bdivisions, Solution, Pre) :-
	Vars = [A1, A2, B],
	select(A1, Adivisions, Temp),
	select(A2, Temp, ResultA),
	select(B, Bdivisions, ResultB),
	A1 #=< A2,
	A1+A2 #= B,
	B #>= Pre,
	subdisarm(ResultA, ResultB, Subsolution, B), !,
	label(Vars),
	append([[[A1, A2], [B]]], Subsolution, Solution).

subdisarm(Adivisions, Bdivisions, Solution, Pre) :-
	Vars = [A, B1, B2],
	select(B1, Bdivisions, Temp),
	select(B2, Temp, ResultB),
	select(A, Adivisions, ResultA),
	B1 #=< B2,
	B1+B2 #= A,
	A #>= Pre,
	subdisarm(ResultA, ResultB, Subsolution, A), !,
	label(Vars),
	append([[[A], [B1, B2]]], Subsolution, Solution).




