check_win(puzzle(_, [robot(_,_,Pos)|_], target(Pos)), victory).
check_win(P, P).

move(P0, ID, Dir, P) :-
	P0 = puzzle(B, Rs0, T),
	B = board(_, _, BL),
	nth0(ID, Rs0, robot(_, RDV, RP0)),
	vec2_add(RP0, Dir, RP),
	( memberchk(robot(_, _, RP), Rs0) ->
		P = P0
	; (get_element_2d(BL, RP, E), E = ' ') ->
		set_element(Rs0, ID, robot(ID, RDV, RP), Rs),
		P1 = puzzle(B, Rs, T),
		move(P1, ID, Dir, P)
	;
		P = P0
	).

tile(target, '◎').
tileset(walls, ['━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻']).
tileset(robots, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ]).
