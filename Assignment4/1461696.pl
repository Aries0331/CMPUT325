% load clpfd libiary first 
:- use_module(library(clpfd)). 

% Question1 - Four squares
% fourSquares(+N, [-S1, -S2, -S3, -S4])
% S1 <= S2 <= S3 <= S4
% On backtracking, fourSquares should return all possible answers 
% since there may be more than one solution

fourSquares(N, [S1, S2, S3, S4]) :- 
	S1 #>= 0,
	S2 #>= 0,
	S3 #>= 0,
	S4 #>= 0,
	S1*S1 + S2*S2 + S3*S3 + S4*S4 #= N,
	S2 #>= S1,
	S3 #>= S2,
	S4 #>= S3,
	label([S1, S2, S3, S4]).




% Question 2 - War and Peace
% the total strength of one month's dismantlement is less than or equal to 
% the total strength of next month's dismantlement
% If there is no solution, then the program should return false

%disarm(+Adivisions, +Bdivisions,-Solution) :- 
