parse_entities([_], _, _, [], target(0, 0)).
parse_entities([C|Cs], X, Y, Robots, Target) :-
	% Next parsing step
	(C = '\n'-> Xnew = 0, Ynew is Y + 1 ; Xnew is X + 1, Ynew = Y),
	parse_entities(Cs, Xnew, Ynew, Robots0, Target0),

	% Handle current character
	( nth0(ID, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ], C) ->
		Robots = [robot(ID, C, vec2(X, Y))|Robots0]
	; Robots = Robots0),
	( C = '◎' -> Target = target(C, vec2(X, Y)) ; Target = Target0).

parse_board(Cs0, board(W, H, Tiles)) :-
	replace_chars(Cs0, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ,◎], ' ', Cs1),
	split_string(Cs1, '\n', '', Rows),
	maplist(string_chars, Rows, Tiles),
	length(Tiles, H0),
	H #= H0 - 1,
	(Tiles = [] -> W = 0 ; Tiles = [R0|_], length(R0, W) ).

parse(S, puzzle(Board, Robots, Target)) :-
	string_chars(S, Cs),
	parse_board(Cs, Board),
	parse_entities(Cs, 0, 0, Robots, Target).
