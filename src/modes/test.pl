% setup test
test_setup(specification(ID, SD), move(ID, D), P) :-
	string_dir(D, SD),
	read_file_from_stdin(S),
	parse(S, P).

% run a test
test_run(P0, move(ID, Dir), 1) :-
	move(P0, ID, Dir, P1),
	display(puzzle, P1).
test_run(P0, move(ID, Dir), 0) :-
	move(P0, ID, Dir, P1),
	P0 = P1.
