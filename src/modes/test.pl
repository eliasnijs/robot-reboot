
test_setup(specification(ID, SD), move(ID, D), P) :-
	string_dir(D, SD),
	read_file_from_stdin(S),
	parse(S, P).

test_run(P0, move(ID, Dir)) :-
	move(P0, ID, Dir, P1),
	display(puzzle, P1).

