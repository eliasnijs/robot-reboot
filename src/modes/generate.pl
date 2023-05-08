% generate a puzzle string to stdout
generate(S) :-
	generate_max_depth(MD),
	generate_puzzle(S, P),
	( solve_iterative_deepening(P, 0, MD) -> display(puzzle,P)
	; generate(S)).

% generate puzzle
generate_puzzle(specification(RC, SW, SH), P) :-
	vec2_mult(2, vec2(SW, SH), P1),
	vec2_add(P1, vec2(1,1), vec2(W, H)),
	generate_obstacles(W, H, Os),
	generate_border(W, H, Bs),
	append(Bs, Os, Ws),
	generate_entities(SW, SH, RC, entities(Rs, T)),
	generate_wall_dvs(board(W, H, Ws), B),
	P = puzzle(B, Rs, T).

% get the outer border
generate_border(W, H, Ws) :-
	findall(wall(_, P), at_border(W, H, P), Ws).

% generate all entities on the map
generate_entities(SW, SH, RC, entities(Rs, T)) :-
    	findall(vec2(X, Y), (range(0, SW, X), range(0, SH, Y)), ERP0),
	random_permutation(ERP0, ERP),

	N #= RC - 1,
	numlist(0, N, I),
	zip(I, ERP, ISL),
	maplist(generate_robot, ISL, Rs),

	nth0(RC, ERP, TP0),
	vec2_mult(2, TP0, TP1),
	vec2_add(TP1, vec2(1,1), TP),
	tile(target, TDv),
	T = target(TDv, TP).

% generate a robot
generate_robot((ID, P0), robot(ID, Dv, P)) :-
	vec2_mult(2, P0, P1),
	vec2_add(P1, vec2(1,1), P),
	tileset(robots, Tiles),
	nth0(ID, Tiles, Dv).

% generate obstacles (non-border walls)
generate_obstacles(W, H, Os) :-
	H0 #= H - 1, W0 #= W - 1,
	setof(vec2(X, Y), (range(1, W0, X), range(1, H0, Y), (X /\ 1 #= 0 ; Y /\ 1 #= 0)), WRP0),
	random_permutation(WRP0, WRP),
	length(WRP, MWC),
	random_between(1, MWC, WC),
	first_n(WC, WRP, Os0),
	maplist([I,W]>>(W=wall(_,I)), Os0, Os).

% generate display values for the walls
generate_wall_dvs(board(W, H, Ws0), board(W, H, Ws)) :-
	maplist({Ws0}/[W,R]>>check_neighbouring_walls(W, Ws0, R), Ws0, Ws1),
	maplist(generte_wall_dv, Ws1, Ws).

% check if a vector is at the border
at_border(W, H, vec2(X, Y)) :-
	H0 #= H - 1, W0 #= W - 1,
	( X = 0 ; Y = 0 ; X #= W - 1 ; Y #= H - 1),
	between(0, W0, X),
	between(0, H0, Y).

% returns wall with instead of the display value an array of 4 elements
% indicating wether the neigbour is present
check_neighbouring_walls(wall(_, P), Ws, wall(T, P)) :-
	vec2_add(P, vec2( 0, -1), N0),
	vec2_add(P, vec2( 1,  0), N1),
	vec2_add(P, vec2( 0,  1), N2),
	vec2_add(P, vec2(-1,  0), N3),
	maplist({Ws}/[P,R]>>check_neighbour_wall(P,Ws,R), [N0, N1, N2, N3], T).

% check if a wall exists in a given position
check_neighbour_wall(P, Ws, 1) :- member(wall(_, P), Ws).
check_neighbour_wall(_, _, 0).

% maps wall with neighbour array to wall with symbolic value
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

