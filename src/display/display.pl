display_game_target(T0, target(Pos), T) :-
	color(bad, FG, BG),
	add_ansi([FG, BG], '◎', R),
	set_element_2d(T0, Pos, R, T).

display_game_robots(T, [], _, T).
display_game_robots(T0, [robot(RID, C, Pos)|Rs], ID, T) :-
	display_game_robots(T0, Rs, ID, T1),
	display_game_robots_effects(RID, ID, Effects),
	add_ansi(Effects, C, S),
	set_element_2d(T1, Pos, S, T).
display_game_robots_effects(ID, ID, [FG, blink]) :- color(good_2, FG, _), !.
display_game_robots_effects(_, _, [FG, BG]) :- color(good, FG, BG).

display_game_build_tile(T0, T) :-
	( nth0(_, ['━', '┏', '┳', '┗', '┻'], T0) -> build_string([T0, '━'], T1)
	; T0 = '\n' -> T1 = T0
	; build_string([T0, ' '], T1)),
	( nth0(_, ['━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻'], T0) ->
		color(good, FG, BG),
		add_ansi([FG, BG], T1, T)
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

display(puzzle, Puzzle, ID) :-
	write_w_ansi([clear, pos(0,0)], ''),
	color(good, GFG, GBG),
	color(bad, BFG, BBG),
	write_w_ansi([GFG, GBG, bold], '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n━━━━━━━━━ Robot '),
	writeln_w_ansi([BFG, BBG, bold], ' Reboot ━━━━━━━━━\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'),
	write_w_ansi([pos(5,0)], ''),
	display_game(Puzzle, ID).

display(victory) :-
	color(good, FG, BG),
	static_screen(victory, S),
	write_w_ansi([clear, pos(0,0), bold, FG, BG], S),
	write_w_ansi([cursor_hidden], '').

display(quit) :-
	color(bad, FG, BG),
	static_screen(loss, S),
	write_w_ansi([clear, pos(0,0), bold, FG, BG], S),
	write_w_ansi([cursor_hidden], '').
