display_game_target(T0, target(vec2(X, Y)), T) :-
	ansi(fg(250, 140, 40), A0),
	ansi(bg(80, 30, 20), A1),
	ansi(reset, Ar),
	build_string([A0, A1, '◎', Ar], R),
	set_element(T0, X, Y, R, T).

display_game_robots(T, [], T).
display_game_robots(T0, [robot(_, C, vec2(X, Y))|Rs], T) :-
	display_game_robots(T0, Rs, T1),
	ansi(fg(40, 200, 220), A0),
	ansi(bg(10, 25, 40), A1),
	ansi(reset, Ar),
	build_string([A0, A1, C, Ar], S),
	set_element(T1, X, Y, S, T).

display_game_build_tile(T0, T) :-
	( nth0(_, ['━', '┏', '┳', '┗', '┻'], T0) -> build_string([T0, '━'], T1)
	; T0 = '\n' -> T1 = T0
	; build_string([T0, ' '], T1)),
	( nth0(_, ['━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻'], T0) ->
		ansi(fg(40, 200, 220), A0),
		ansi(bg(10, 25, 40), A1),
		ansi(reset, Ar),
		build_string([A0, A1, T1, Ar], T)
	; T = T1).

display_game_build_string(T, S) :-
	concat_sublists(T, '\n', Cs0),
	maplist(display_game_build_tile, Cs0, Cs),
	build_string(Cs, S).

display_game(Puzzle) :-
	Puzzle = puzzle(board(_, _, T0), Robots, Target),
	display_game_target(T0, Target, T1),
	display_game_robots(T1, Robots, T2),
	display_game_build_string(T2, S),
	writeln(S).

display_title :-
	ansi(bold,		A1), write(A1),
	writeln('Robot Reboot'),
	ansi(reset,	Ar), writeln(Ar).

display(Puzzle) :-
	% ansi(clear, 	A0), write(A0),
	% ansi(pos(0,0),	A1), write(A1),

	% ansi(pos(3,0),	A2), write(A2),
	display_game(Puzzle).

