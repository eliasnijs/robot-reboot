generate_puzzle(specification(RC, W0, H0), P) :-
	W #= W0 * 2 - 1, H #= H0 * 2 - 1,

	generate_board(W, H, B0),
	generate_robots(RC, Rs),
	generate_target(T),

	generate_wall_dvs(B0, B),
	P = puzzle(B, Rs, T).

generate_board(W, H, board(W, H, Ws)) :-
	findall(wall(_, P), at_border(W, H, P), Ws).


generate_robots(RC, Rs) :-
	N #= RC - 1,
	numlist(0, N, I),
	maplist(generate_robot, I, Rs).

generate_robot(ID, robot(ID, Dv, vec2(2, Y))) :-
	Y #= ID + 2,
	tileset(robots, Tiles),
	nth0(ID, Tiles, Dv).

generate_target(T) :-
	tile(target, TDv),
	T = target(TDv, vec2(1,4)).






% Wall utils

generate_wall_dvs(board(W, H, Ws0), board(W, H, Ws)) :-
	maplist({Ws0}/[W,R]>>check_neighbouring_walls(W, Ws0, R), Ws0, Ws1),
	maplist(generte_wall_dv, Ws1, Ws).

at_border(W, H, vec2(X, Y)) :-
	H0 #= H - 1, W0 #= W - 1,
	( X = 0 ; Y = 0 ; X #= W - 1 ; Y #= H - 1),
	between(0, W0, X),
	between(0, H0, Y).

check_neighbouring_walls(wall(_, P), Ws, wall(T, P)) :-
	vec2_add(P, vec2( 0, -1), N0),
	vec2_add(P, vec2( 1,  0), N1),
	vec2_add(P, vec2( 0,  1), N2),
	vec2_add(P, vec2(-1,  0), N3),
	maplist({Ws}/[P,R]>>check_neighbour_wall(P,Ws,R), [N0, N1, N2, N3], T).


check_neighbour_wall(P, Ws, 1) :- member(wall(_, P), Ws).
check_neighbour_wall(_, _, 0).

generte_wall_dv(wall([0,0,0,0], P), wall('━', P)).
generte_wall_dv(wall([0,0,0,1], P), wall('━', P)).
generte_wall_dv(wall([0,0,1,0], P), wall('┃', P)).
generte_wall_dv(wall([0,0,1,1], P), wall('┓', P)).
generte_wall_dv(wall([0,1,0,0], P), wall('━', P)).
generte_wall_dv(wall([0,1,0,1], P), wall('━', P)).
generte_wall_dv(wall([0,1,1,0], P), wall('┏', P)).
generte_wall_dv(wall([0,1,1,1], P), wall('┳', P)).
generte_wall_dv(wall([1,0,0,0], P), wall('┃', P)).
generte_wall_dv(wall([1,0,0,1], P), wall('┛', P)).
generte_wall_dv(wall([1,0,1,0], P), wall('┃', P)).
generte_wall_dv(wall([1,0,1,1], P), wall('┫', P)).
generte_wall_dv(wall([1,1,0,0], P), wall('┗', P)).
generte_wall_dv(wall([1,1,0,1], P), wall('┻', P)).
generte_wall_dv(wall([1,1,1,0], P), wall('┣', P)).
generte_wall_dv(wall([1,1,1,1], P), wall('╋', P)).
