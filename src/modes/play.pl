play_setup(F, session(Puzzle, 0, [])) :-
        read_file_to_string(F, S, []),
	parse(S, Puzzle).

play_loop(S0) :-
	S0 = session(P0, ID, _),
	display(puzzle, P0, ID),
	play_input(S0, S),
	S = session(P, _, H),
	( P = quit ->
		display(quit),
		format('Your Moves: ~w', [H]),
		read_line_to_string(user_input,_),
		write_w_ansi([cursor_visible],'')
	; P = victory ->
		display(victory),
		format('Your Moves: ~w', [H]),
		read_line_to_string(user_input,_),
		write_w_ansi([cursor_visible],'')
	; play_loop(S)).

play_input(S0, S) :-
	get_input(C),
	play_handle_input(S0, C, S1),
	S1 = session(P1, _, _),
	( P1 = quit ->
		color(bad, FG, BG),
		writeln_w_ansi([FG, BG, bold], 'Are you sure you want to stop playing? (y/n)'),
		get_input(C1),
		(C1 = 'y' ->  S = S1 ; S = S0)
	; P1 = invalid ->
		color(bad, FG, BG),
		writeln_w_ansi([FG, BG, bold], 'invalid input... try again'),
		play_input(S0, S)
	;
		S = S1
	).

play_handle_input(session(P, ID0, H), C, session(P, ID, H)) :-
	P = puzzle(_, Rs, _),
	length(Rs, N),
	( C = 'f' -> ID #= (ID0 + 1) mod N
	; C = 'd' -> ID #= (ID0 - 1) mod N).
play_handle_input(session(P0, ID, H), C, session(P, ID, [Hnew|H])) :-
	( C = 'h' -> Dir = vec2(-1,  0), build_string([ID, 'L'], Hnew)
	; C = 'j' -> Dir = vec2( 0,  1), build_string([ID, 'D'], Hnew)
	; C = 'k' -> Dir = vec2( 0, -1), build_string([ID, 'U'], Hnew)
	; C = 'l' -> Dir = vec2( 1,  0), build_string([ID, 'R'], Hnew)
	),
	move(P0, ID, Dir, P).
play_handle_input(session(_, ID, H), 'q', session(quit, ID, H)).
play_handle_input(session(_, ID, H), _, session(invalid, ID, H)).

move(P0, ID, Dir, P) :-
	P0 = puzzle(B, Rs0, T),
	B = board(_, _, BL),
	T = target(TP),
	nth0(ID, Rs0, robot(_, RDV, RP0)),
	vec2_add(RP0, Dir, RP),
	( RP = TP ->
		P = victory
	; memberchk(robot(_, _, RP), Rs0) ->
		P = P0
	; (get_element_2d(BL, RP, E), E = ' ') ->
		set_element(Rs0, ID, robot(ID, RDV, RP), Rs),
		P1 = puzzle(B, Rs, T),
		move(P1, ID, Dir, P)
	;
		P = P0
	).
