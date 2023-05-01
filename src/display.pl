display_target(T0, target(vec2(X, Y)), T) :-
	ansi(fg('255', '0', '0'), A0),
	ansi(reset, Ar),
	build_string([A0, '◎', Ar], R),
	set_element(T0, X, Y, R, T).

display_robots(T, [], T).
display_robots(T0, [robot(_, C, vec2(X, Y))|Rs], T) :-
	display_robots(T0, Rs, T1),
	set_element(T1, X, Y, C, T).

display_build_tile(T0, T) :-
	( nth0(_, ['━', '┏', '┳', '┗', '┻'], T0) -> build_string([T0, '━'], T)
	; T0 = '\n' -> T = T0
	; build_string([T0, ' '], T)).

display_build_string(T, S) :-
	concat_sublists(T, '\n', Cs0),
	maplist(display_build_tile, Cs0, Cs),
	build_string(Cs, S).

display(Puzzle) :-
	Puzzle = puzzle(board(_, _, T0), Robots, Target),
	display_target(T0, Target, T1),
	display_robots(T1, Robots, T2),
	display_build_string(T2, S),
	writeln(S).
