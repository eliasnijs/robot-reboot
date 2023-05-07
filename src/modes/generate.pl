% 0 0 1 1 2 2 3 3 4
% W R W R W R W R W
% ┏ ━ ━ ━ ━ ━ ━ ━ ┓

generate(S) :-
	generate_max_depth(MD),
	generate_puzzle(S, P),
	( solve_iterative_deepening(P, 0, MD) -> display(puzzle,P)
	; generate(S)).

generate_puzzle(specification(RC, SW, SH), P) :-
	regime_S_to_L(entity, vec2(SW, SH), vec2(W, H)),
	generate_obstacles(W, H, Os),
	generate_border(W, H, Bs),
	append(Bs, Os, Ws),
	generate_entities(SW, SH, RC, entities(Rs, T)),
	generate_wall_dvs(board(W, H, Ws), B),
	P = puzzle(B, Rs, T).


generate_border(W, H, Ws) :-
	findall(wall(_, P), at_border(W, H, P), Ws).

generate_entities(SW, SH, RC, entities(Rs, T)) :-
    	findall(vec2(X, Y), (range(0, SW, X), range(0, SH, Y)), ERP0),
	random_permutation(ERP0, ERP),

	N #= RC - 1,
	numlist(0, N, I),
	zip(I, ERP, ISL),
	maplist(generate_robot, ISL, Rs),

	nth0(RC, ERP, TP0),
	regime_S_to_L(entity, TP0, TP),
	tile(target, TDv),
	T = target(TDv, TP).

generate_robot((ID, P0), robot(ID, Dv, P)) :-
	regime_S_to_L(entity, P0, P),
	tileset(robots, Tiles),
	nth0(ID, Tiles, Dv).

generate_obstacles(W, H, Os) :-
	H0 #= H - 1, W0 #= W - 1,
	setof(vec2(X, Y), (range(1, W0, X), range(1, H0, Y), (X /\ 1 #= 0 ; Y /\ 1 #= 0)), WRP0),
	random_permutation(WRP0, WRP),
	MWC #= W*H,
	random_between(1, MWC, WC),
	first_n(WC, WRP, Os0),
	maplist([I,W]>>(W=wall(_,I)), Os0, Os).

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
