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

next_pos(Rp0, Dir, _, Rs, Rp0) :-
	vec2_mult(2, Dir, Dir2),
	vec2_add(Rp0, Dir2, Rp),
	member(robot(_, _, Rp), Rs),
	!.
next_pos(Rp0, Dir, Ws, _, Rp0) :-
	vec2_add(Rp0, Dir, Rp),
	member(wall(_, Rp), Ws),
	!.
next_pos(Rp0, Dir, Ws, Rs, Rp) :-
	vec2_mult(2, Dir, Dir2),
	vec2_add(Rp0, Dir2, Rp1),
	next_pos(Rp1, Dir, Ws, Rs, Rp).
