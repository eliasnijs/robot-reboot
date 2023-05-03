tile(target, '◎').
tileset(walls, ['━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻']).
tileset(robots, [▣ ,■ ,▲ ,◆ ,◇ ,◈ ,◉ ,◩ ,◭ ,◲ ]).

check_win(puzzle(_, [robot(_,_,P)|_], target(_, P)), victory).
check_win(P, P).

move(P0, ID, Dir, puzzle(B, Rs, T)) :-
	P0 = puzzle(B, Rs0, T),
	B = board(_, _, Ws),
	nth0(ID, Rs0, robot(ID, RDv, Rp0)),
	next_pos(Rp0, Dir, Ws, Rs0, Rp),
	set_element(Rs0, ID, robot(ID, RDv, Rp), Rs).

next_pos(P0, Dir, Ws, Rs, P0) :-
	vec2_add(P0, Dir, P),
	( member(wall(_,P), Ws) ; member(robot(_, _, P), Rs) ).
next_pos(P0, Dir, Ws, Rs, P) :-
	vec2_add(P0, Dir, P1),
	next_pos(P1, Dir, Ws, Rs, P).
