% setup solve
solve_setup(P) :-
	read_file_from_stdin(S),
	parse(S, P).

% do iterative deepening
solve_iterative_deepening(P, D0, MD) :-
	D0 #>= 0, D0 #< MD,
	solve_do(P, D0, H),
	solve_log(end, H).
solve_iterative_deepening(P, D0, MD) :-
	D0 #>= 0, D0 #< MD,
	solve_log(running, D0),
	\+ solve_do(P, D0, _),
	D1 #= D0 + 1,
	solve_iterative_deepening(P, D1, MD).

% use dfs to explore possible solutions until a given depth
:-table solve_do/3.
solve_do(victory, _, []) :-
	!.
solve_do(P0, D0, [move(ID, Dir)|H0]) :-
	D0 #>= 0,
  	member(Dir, [vec2(-1,0), vec2(0,1), vec2(0,-1), vec2(1,0)]),
  	P0 = puzzle(_, Rs, _),
	length(Rs, RsN),
	ID #>= 0,
	ID #=< RsN,

 	move(P0, ID, Dir, P1),
	check_win(P1, P),
	D #= D0 - 1,
 	solve_do(P, D, H0).

% log step in iterative deepening
solve_log(running, D) :-
	color(bad, FG, BG),
	write_w_ansi([cursor_start_prev], ''),
	format_w_ansi([FG, BG], 'iterative depth ~d', D),
	writeln_w_ansi([FG, BG, blink], '... ').
solve_log(end, H) :-
	maplist(solve_log_stringify_move, H, S0),
	atomic_list_concat(S0, ',', S),
	writeln_w_ansi([cursor_start_prev, erase_line], S).

% maps move to string
solve_log_stringify_move(move(ID, D), S) :-
	string_dir(D, S0),
	build_string([ID, S0], S).
