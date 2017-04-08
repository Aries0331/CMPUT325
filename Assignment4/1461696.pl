% load clpfd libiary first 
:- use_module(library(clpfd)). 

% Question1 - Four squares
% fourSquares(+N, [-S1, -S2, -S3, -S4])
% S1 <= S2 <= S3 <= S4
% On backtracking, fourSquares should return all possible answers 
% since there may be more than one solution

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
	select(B1, Adivisions, Temp),
	select(B2, Temp, ResultB),
	select(A, Bdivisions, ResultA),
	B1 #=< B2,
	B1+B2 #= A,
	A #>= Pre,
	subdisarm(ResultA, ResultB, Subsolution, A), !,
	label(Vars),
	append([[[B1, B2], [A]]], Subsolution, Solution).




