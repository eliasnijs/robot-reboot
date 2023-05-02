parse_characters([_], _, _, [], target(0, 0), [[]]).
parse_characters([C|Cs], X, Y, Robots, Target, Tiles) :-
	(C = '\n'-> Xnew = 0, Ynew is Y + 1, Tiles = [[]|[Bl0|Bls]] ; Xnew is X + 1, Ynew = Y, Tiles = [[Bc|Bl0]|Bls]),
	parse_characters(Cs, Xnew, Ynew, Robots0, Target0, [ Bl0 | Bls ]),
	( nth0(ID, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ], C) ->
		Robots = [robot(ID, C, vec2(X, Y))|Robots0], Bc = ' '
	; Robots = Robots0),
	( C = '◎' -> Target = target(vec2(X, Y)) ; Target = Target0),
	( nth0(_, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ,◎], C) -> Bc = ' ' ; Bc = C ).

parse(S, puzzle(board(W, H, Tiles), Robots, Target)) :-
	string_chars(S, Cs),
	parse_characters(Cs, 0, 0, Robots0, Target, Tiles),
	length(Tiles, H),
	(Tiles = [] -> W = 0 ; Tiles = [R0|_], length(R0, W) ),
	sort(1, @=<, Robots0, Robots).
