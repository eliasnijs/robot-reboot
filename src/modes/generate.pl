generate_puzzle(specification(RC, SW, SH), P) :-
	W #= SW * 2 - 1, H #= SH * 2 - 1,

	generate_board(W, H, B0),


	% Generate entities
	rectangle_vec2s(vec2(1, SW), vec2(1, SH), ERP0),
	random_permutation(ERP0, ERP),

	generate_robots(RC, ERP, Rs),
	nth0(RC, ERP, TPos),
	generate_target(T, TPos),


	generate_wall_dvs(B0, B),
	P = puzzle(B, Rs, T).

% Board

generate_board(W, H, board(W, H, Ws)) :-
	findall(wall(_, P), at_border(W, H, P), Ws).

% Robots

generate_robots(RC, ERP, Rs) :-
	N #= RC - 1,
	numlist(0, N, I),
	zip(I, ERP, ISL),
	maplist(generate_robot, ISL, Rs).

generate_robot((ID, Pos), robot(ID, Dv, Pos)) :-
	tileset(robots, Tiles),
	nth0(ID, Tiles, Dv).


% Target

generate_target(T, TPos) :-
	tile(target, TDv),
	T = target(TDv, TPos).






% Walls

generate_wall_dvs(board(W, H, Ws0), board(W, H, Ws)) :-
	maplist({Ws0}/[W,R]>>check_neighbouring_walls(W, Ws0, R), Ws0, Ws1),
	maplist(generte_wall_dv, Ws1, Ws).

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

