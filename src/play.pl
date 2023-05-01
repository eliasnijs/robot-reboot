play_setup(F, session(Puzzle, 0, [])) :-
        read_file_to_string(F, S, []),
	parse(S, Puzzle).

play_loop(S0) :-
	S0 = session(P0, _, _),
	display(P0),
	play_input(S0, S),
	( S = quit -> true ; play_loop(S)).

play_input(S0, S) :-
	get_input(C),
	play_handle_input(S0, C, S1),
	( S1 = quit ->
		writeln('Are you sure you want to stop playing? :('),
		writeln('type yes to stop...'),
		get_input(C1),
		(C1 = 'yes' ->  S = quit ; S = S0)
	; S1 = invalid ->
		writeln('invalid input... try again'),
		play_input(S0, S)
	; S = S1).

play_handle_input(session(P, ID0, H), C, session(P, ID, H)) :-
	P = puzzle(_, Rs, _),
	length(Rs, N),
	( C = 'f' -> ID #= (ID0 + 1) mod N
	; C = 'd' -> ID #= (ID0 - 1) mod N),
	!.
play_handle_input(session(P0, ID, H), C, session(P, ID, H)) :-
	P0 = puzzle(B, Rs0, T),
	nth0(ID, Rs0, robot(RobotID, RobotDV, RobotPos0)),
	( C = 'h' -> Dir = vec2(-1,  0)
	; C = 'j' -> Dir = vec2( 0,  1)
	; C = 'k' -> Dir = vec2( 0, -1)
	; C = 'l' -> Dir = vec2( 1,  0)),
	vec2_add(RobotPos0, Dir, RobotPos),
	set_element(Rs0, ID, robot(RobotID, RobotDV, RobotPos), Rs),
	P = puzzle(B, Rs, T),
	!.
play_handle_input(_, 'q', quit) :- !.
play_handle_input(_, _, invalid).
