% Helpers

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




/*
find_symbol(PuzzleString, Width, Dv, Pos) :-
	sub_string(PuzzleString, TargetIndex, _, _, Dv),
	pos_1d_to_d2(TargetIndex, Pos, Width + 1).

% Parsers

parse_robots(_, _, [], []).
parse_robots(PuzzleString, Width, [Possible0|Possible], Robots) :-
	( find_symbol(PuzzleString, Width, Possible0, RobotPos) ->
		parse_robots(PuzzleString, Width, Possible, Rs),
		Robots = [robot(0, Possible0, RobotPos)|Rs]
	; 	Robots = []
	).

parse_dimensions(Puzzle, dimensions(Width, Height)) :-
	length(Puzzle, Height0),
	Height #= Height0 - 1,
	(Puzzle = [] -> Width = 0 ; Puzzle = [R0|_], length(R0, Width) ).

parse(PuzzleString, puzzle(board(Dimensions, _), Robots, target(◎, TargetPos), [])) :-
	split_string(PuzzleString, '\n', '', Rows),
	maplist(string_chars, Rows, Puzzle),

	% Parse dimensions
	parse_dimensions(Puzzle, Dimensions),
	Dimensions = dimensions(Width, _),

	% Parse target
	find_symbol(PuzzleString, Width, ◎, TargetPos),

	% Parse robots
	parse_robots(PuzzleString, Width, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ], Robots).
*/








