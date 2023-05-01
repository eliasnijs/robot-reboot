get_input(S) :-
	write_w_ansi([bold, bg(40, 200, 220), fg(10, 25, 40)], ">>>"),
	ansi(fg(40, 200, 220), A0),
	ansi(bg(10, 25, 40), A1),
	ansi(reset, Ar),
	build_string([A0, A1, ' '], A),
	write(A),
	read_line_to_string(user_input, C0),
	write(Ar),
	atomic_list_concat([C0], S).
