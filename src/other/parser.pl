% maps puzzle string to puzzle object
parse(S, puzzle(board(W, H, Ws), Rs, T)) :-
	string_chars(S, Cs),
	parse(Cs, 0, 0, Ws, Rs0, T, W, H),
	sort(1, @=<, Rs0, Rs).

parse([], _, _, [], [], target(_, vec2(-1, -1)), 0, 0).
parse(['\n'|Cs], _, Y, Ws, Rs, T, 0, H) :-
	Y #= Y0 - 1, H #= H0 + 1,
	parse(Cs, 0, Y0, Ws, Rs, T, _, H0).
parse([C|Cs], X, Y, Ws, Rs, target(C, vec2(X, Y)), W, H) :-
	tile(target, C),
	W #= W0 + 1, X #= X0 - 1,
	parse(Cs, X0, Y, Ws, Rs, _, W0, H).
parse([C|Cs], X, Y, Ws, [robot(ID, C, vec2(X, Y))|Rs], T, W, H) :-
	tileset(robots, Tiles),
	nth0(ID, Tiles, C),
	W #= W0 + 1, X #= X0 - 1,
	parse(Cs, X0, Y, Ws, Rs, T, W0, H).
parse([C|Cs], X, Y, [wall(C, vec2(X, Y))|Ws], Rs, T, W, H) :-
	tileset(walls, Tiles),
	member(C, Tiles),
	W #= W0 + 1, X #= X0 - 1,
	parse(Cs, X0, Y, Ws, Rs, T, W0, H).
parse([' '|Cs], X, Y, Ws, Rs, T, W, H) :-
	W #= W0 + 1, X #= X0 - 1,
	parse(Cs, X0, Y, Ws, Rs, T, W0, H).
