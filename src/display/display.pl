display(puzzle, P, ID) :-
	color(good, GFG, GBG), color(bad, BFG, BBG),
	% write_w_ansi([clear, pos(0,0)], ''),
	write_w_ansi([GFG, GBG, bold], '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n━━━━━━━━━ Robot '),
	writeln_w_ansi([BFG, BBG, bold], ' Reboot ━━━━━━━━━\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'),
	% write_w_ansi([pos(5,0)], ''),
	display(0, 0, P, ID, Cs),
	build_string(Cs, S),
	writeln(S).
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

display(0, H, puzzle(board(_, H, _), _, _), _, []).
display(W, Y, P, ID, ['\n'|Cs]) :-
	P = puzzle(board(W, _, _), _, _),
	Yn #= Y + 1,
	display(0, Yn, P, ID, Cs).
display(X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), _, target(Dv0, Tp)),
	Tp = vec2(X, Y),
	build_string([Dv0, ' '], Dv1),
	ansi_color(bad, Dv1, Dv),
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
display(X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), Rs, _),
	member(robot(ID, Dv0, vec2(X, Y)), Rs),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good_2, Dv1, Dv),
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
display(X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, _), Rs, _),
	member(robot(_, Dv0, vec2(X, Y)), Rs),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
display(X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, Ws), _, _),
	member(wall(Dv0, vec2(X, Y)), Ws),
	member(Dv0, ['━', '┏', '┳', '┗', '┻', '┣']),
	build_string([Dv0, '━'], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
display(X, Y, P, ID, [Dv|Cs]) :-
	P = puzzle(board(_, _, Ws), _, _),
	member(wall(Dv0, vec2(X, Y)), Ws),
	build_string([Dv0, ' '], Dv1),
	ansi_color(good, Dv1, Dv),
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
display(X, Y, P, ID, ['  '|Cs]) :-
	Xn #= X + 1,
	display(Xn, Y, P, ID, Cs).
