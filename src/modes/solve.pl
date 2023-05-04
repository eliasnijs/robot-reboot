:- use_module(library(tabling)).

read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

solve_setup(P) :-
	writeln(''),
	read_file_from_stdin(S),
	parse(S, P).

solve_iterative_deepening(P, D0) :-
	D0 #>= 0,
	format('iterative depth: ~w\n', D0),
	( solve_do(P, D0) ->
		writeln('reached victory')
	;
		D1 #= D0 + 1,
		solve_iterative_deepening(P, D1)
	).


:-table solve_do/2.

solve_do(victory, _) :- !.
solve_do(P0, D0) :-
  	member(Dir, [vec2(-1,0), vec2(0,1), vec2(0,-1), vec2(1,0)]),
  	P0 = puzzle(_, Rs, _),
	length(Rs, RsN),
	ID #>= 0,
	ID #=< RsN,
	D0 #>= 0,

	% format('~w, ~w, ~w\n', [ID, Dir, D0]),

 	move(P0, ID, Dir, P1),
	check_win(P1, P),
	D #= D0 - 1,
 	solve_do(P, D).

