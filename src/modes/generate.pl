generate_puzzle(specification(RC, W0, H0), P) :-
	W #= W0 * 2 - 1, H #= H0 * 2 - 1,
	% Generate basic structure
	generate_robots(RC, Rs),
	generate_target(T),

	% Generate random positions

	% Solve display values for walls
	findall(wall('#', P), at_border(W, H, P), Ws0),
	maplist([wall(_, P),R]>>neighbours(P, R), Ws0, Ws1),
	maplist(
		{Ws0}/[P,R] >> ( member(wall(_, P), Ws0) -> R = 1 ; R = 0),
		Ws1, Ws)
	writeln(Ws),

	B = board(W, H, Ws),
	% Return result
	writeln(''),
	P = puzzle(B, Rs, T).

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












% Wall drawing utils

generte_wall_dv([0,0,0,0], '━').
generte_wall_dv([0,0,0,1], '━').
generte_wall_dv([0,0,1,0], '┃').
generte_wall_dv([0,0,1,1], '┓').
generte_wall_dv([0,1,0,0], '━').
generte_wall_dv([0,1,0,1], '━').
generte_wall_dv([0,1,1,0], '┏').
generte_wall_dv([0,1,1,1], '┳').
generte_wall_dv([1,0,0,0], '┃').
generte_wall_dv([1,0,0,1], '┛').
generte_wall_dv([1,0,1,0], '┃').
generte_wall_dv([1,0,1,1], '┫').
generte_wall_dv([1,1,0,0], '┗').
generte_wall_dv([1,1,0,1], '┻').
generte_wall_dv([1,1,1,0], '┣').
generte_wall_dv([1,1,1,1], '╋').

