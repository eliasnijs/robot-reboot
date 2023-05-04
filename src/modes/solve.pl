read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

solve_setup(P) :-
	read_file_from_stdin(S),
	parse(S, P).

solve_iterative_deepening(P, D0) :-
	D0 #>= 0,
	solve_log(running, D0),
	\+ solve_do(P, D0, _),
	D1 #= D0 + 1,
	solve_iterative_deepening(P, D1).
solve_iterative_deepening(P, D0) :-
	solve_do(P, D0, H),
	solve_log(end, H).

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

solve_log(running, D) :-
	color(bad, FG, BG),
	write_w_ansi([cursor_start_prev], ''),
	format_w_ansi([FG, BG], 'iterative depth ~d', D),
	writeln_w_ansi([FG, BG, blink], '... ').
solve_log(end, H) :-
	maplist(solve_log_stringify_move, H, S0),
	atomic_list_concat(S0, ',', S),
	writeln_w_ansi([cursor_start_prev, erase_line], S).

solve_log_stringify_move(move(ID, D), S) :-
	( D = vec2(-1,  0) -> build_string([ID, 'L'], S)
	; D = vec2( 0,  1) -> build_string([ID, 'D'], S)
	; D = vec2( 0, -1) -> build_string([ID, 'U'], S)
	; D = vec2( 1,  0) -> build_string([ID, 'R'], S)).
