display_game_target(T0, target(Pos), T) :-
	add_ansi([bg(50, 10, 15), fg(240, 140, 40)], '◎', R),
	set_element_2d(T0, Pos, R, T).

display_game_robots(T, [], _, T).
display_game_robots(T0, [robot(RID, C, Pos)|Rs], ID, T) :-
	display_game_robots(T0, Rs, ID, T1),
	( RID = ID ->
		A = [fg(180, 230, 255), blink]
	;
		A = [fg(40, 200, 220), bg(10, 25, 40)]
	),
	add_ansi(A, C, S),
	set_element_2d(T1, Pos, S, T).

display_game_build_tile(T0, T) :-
	( nth0(_, ['━', '┏', '┳', '┗', '┻'], T0) -> build_string([T0, '━'], T1)
	; T0 = '\n' -> T1 = T0
	; build_string([T0, ' '], T1)),
	( nth0(_, ['━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻'], T0) ->
		add_ansi([fg(40, 200, 220), bg(10, 25, 40)], T1, T)
	; T = T1).

display_game_build_string(T, S) :-
	concat_sublists(T, '\n', Cs0),
	maplist(display_game_build_tile, Cs0, Cs),
	build_string(Cs, S).

display_game(Puzzle, ID) :-
	Puzzle = puzzle(board(_, _, T0), Robots, Target),
	display_game_target(T0, Target, T1),
	display_game_robots(T1, Robots, ID, T2),
	display_game_build_string(T2, S),
	writeln(S).

display_title :-
	writeln_w_ansi([fg(40, 200, 220), bg(10, 25, 40), bold], ' ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'),
	write_w_ansi([fg(40, 200, 220), bg(10, 25, 40), bold], ' ━━━━━━━━━'),
	write_w_ansi([fg(40, 200, 220), bg(10, 25, 40), bold], ' Robot '),
	write_w_ansi([bg(30, 10, 15), fg(240, 140, 40), bold], ' Reboot '),
	writeln_w_ansi([bg(30, 10, 15), fg(240, 140, 40), bold], ' ━━━━━━━━━'),
	writeln_w_ansi([bg(30, 10, 15), fg(240, 140, 40), bold], ' ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━').

display(Puzzle, ID) :-
	% ansi(clear, 	A0), write(A0),
	% ansi(pos(0,0),	A1), write(A1),
	% display_title,
	% ansi(pos(5,0),	A2), write(A2),
	display_game(Puzzle, ID).

display(victory, _) :-
	ansi(clear, 	A0), write(A0),
	ansi(pos(0,0),	A1), write(A1),
	ansi(bold, 		A2), write(A2),
	ansi(bg(10, 25, 40), 	A3), write(A3),
	ansi(fg(40, 200, 220), 	A4), write(A4),
	static_screen(victory, S),
	writeln(S),
	ansi(cursor_hidden, 	A5), write(A5).

display(quit, _) :-
	ansi(clear, 		A0), write(A0),
	ansi(pos(0,0),		A1), write(A1),
	ansi(bold, 		A2), write(A2),
	ansi(bg(30, 10, 15), 	A3), write(A3),
	ansi(fg(240, 140, 40), 	A4), write(A4),
	static_screen(loss, S),
	writeln(S),
	ansi(cursor_hidden, 	A5), write(A5).
