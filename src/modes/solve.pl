read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

solve_setup(session(P, 0, [], _)) :-
	writeln(''),
	read_file_from_stdin(S),
	parse(S, P).

solve_iterative_deepening(S) :-
	S = session(P, D0, _, H),
	D0 #>= 0, format('iterative depth: ~w\n', D0),
	length(H, D0),
	% labeling([], H),
	( solve_do(S) ->
		maplist(stringify_move, H, HS),
		writeln(HS),
		writeln('reached victory')
	;
		D1 #= D0 + 1,
		solve_iterative_deepening(session(P, D1, [], _))
	).

solve_do(session(victory, _, _, _)).
solve_do(S) :-
	S = session(P0, D0, V, [move(ID, Dir)|H]),
	solve_prune(S, ID, Dir),
	D #= D0 - 1,
 	move(P0, ID, Dir, P1),
	check_win(P1, P),
 	solve_do(session(P, D, [P0|V], H)).

solve_prune(session(P0, D, V, _), ID, Dir) :-
	D >= 0,
  	( Dir = vec2(-1,0) ; Dir = vec2(0,1) ; Dir = vec2(0,-1) ; Dir = vec2(1,0) ),
  	P0 = puzzle(_, Rs, _),
	nth0(ID, Rs, _),
	\+ memberchk(P0, V).
