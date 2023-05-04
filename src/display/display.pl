display(help) :-
	color(good_2, FG, BG),
	static_screen(help, S),
	writeln_w_ansi([FG, BG], S).

display(victory) :-
	color(good, FG, BG),
	static_screen(victory, S),
	write_w_ansi([clear, pos(0,0), bold, italic, FG, BG], S),
	write_w_ansi([cursor_hidden], '').
display(quit) :-
	color(bad, FG, BG),
	static_screen(loss, S),
	write_w_ansi([clear, pos(0,0), bold, italic, FG, BG], S),
	write_w_ansi([cursor_hidden], '').


display(puzzle, P) :-
	display(puzzle, 0, 0, P, Cs),
	build_string(Cs, S),
	writeln(S).

display(game, P, ID) :-
	writeln_w_ansi([clear], ''),
	write_w_ansi([cursor_hidden], ''),
	color(good, GFG, GBG), color(bad, BFG, BBG),
	write_w_ansi([pos(0,0)], ''),
	write_w_ansi([GFG, GBG, bold], '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n━━━━━━━━━ Robot '),
	writeln_w_ansi([BFG, BBG, bold], ' Reboot ━━━━━━━━━\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'),
	writeln(''),
	display(game, 0, 0, P, ID, Cs),
	build_string(Cs, S),
	writeln(S).

display(game, 0, H, puzzle(board(_, H, _), _, _), _, []).
display(game, W, Y, P, ID, ['\n'|Cs]) :-
	P = puzzle(board(W, _, _), _, _),
	Yn #= Y + 1,
	display(game, 0, Yn, P, ID, Cs).
display(game, X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), _, target(Dv0, Tp)),
	Tp = vec2(X, Y),
	build_string([Dv0, ' '], Dv1),
	ansi_color(bad, Dv1, Dv),
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).
display(game, X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), Rs, _),
	member(robot(ID, Dv0, vec2(X, Y)), Rs),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good_2, Dv1, Dv),
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).
display(game, X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), Rs, _),
	member(robot(_, Dv0, vec2(X, Y)), Rs),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).
display(game, X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, Ws), _, _),
	member(wall(Dv0, vec2(X, Y)), Ws),
	member(Dv0, ['━', '┏', '┳', '┗', '┻', '┣']),
	build_string([Dv0, '━'], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).
display(game, X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, Ws), _, _),
	member(wall(Dv0, vec2(X, Y)), Ws),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).
display(game, X, Y, P, ID, ['  '|Cs]) :-
	Xn #= X + 1,
	display(game, Xn, Y, P, ID, Cs).

display(puzzle, 0, H, puzzle(board(_, H, _), _, _), []).
display(puzzle, W, Y, P, ['\n'|Cs]) :-
	P = puzzle(board(W, _, _), _, _),
	Yn #= Y + 1,
	display(puzzle, 0, Yn, P, Cs).
display(puzzle, X, Y, P, [Dv|Cs]) :-
	P = puzzle(board(_, _, Ws), Rs, target(TDv, Tp)),
	( Tp = vec2(X, Y) ->
		Dv = TDv
	; member(robot(_, Dv, vec2(X, Y)), Rs)
	; member(wall(Dv, vec2(X, Y)), Ws)
	; Dv = ' ' ),
	Xn #= X + 1,
	display(puzzle, Xn, Y, P, Cs).
