get_input(S) :-
	color(good, GFG, GBG),
	color(good_3, G3FG, G3BG),
	write_w_ansi([bold, G3FG, G3BG], ">>>"),
	ansi(GFG, A0),
	ansi(GBG, A1),
	ansi(reset, Ar),
	build_string([A0, A1, ' '], A),
	write(A),
	read_line_to_string(user_input, C0),
	write(Ar),
	atomic_list_concat([C0], S).
