ansi(reset, 		'\033[0m').
ansi(clear, 		'\033[2J').
ansi(erase_line, 	'\033[2K').

ansi(pos(R, C), S) :-
	build_string(['\033[', R, ';', C, 'H'], S).
ansi(up(H), S) :-
	build_string(['\033[', H, 'A'], S).
ansi(column(C), S) :-
	build_string(['\033[', C, 'G'], S).

ansi(cursor_hidden, 	'\033[?25l').
ansi(cursor_visible, 	'\033[?25h').
ansi(cursor_start_prev, '\033[1F').

ansi(bold, 		'\033[1m').
ansi(dim, 		'\033[2m').
ansi(italic, 		'\033[3m').
ansi(underline, 	'\033[4m').
ansi(blink, 		'\033[5m').
ansi(inverse, 		'\033[7m').
ansi(hidden, 		'\033[8m').
ansi(strikethrough, 	'\033[9m').

ansi(fg(R,G,B), S) :-
    build_string(['\033[38;2;', R, ';', G, ';', B, 'm'], S).

ansi(bg(R,G,B), S) :-
    build_string(['\033[48;2;', R, ';', G, ';', B, 'm'], S).

add_ansi(A0, S0, S) :-
	maplist(ansi, A0, A1),
	build_string(A1, A),
	ansi(reset, Ar),
	build_string([A, S0, Ar], S).

ansi_color(C, S0, S) :-
	color(C, FG, BG),
	add_ansi([FG, BG], S0, S).

writeln_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	writeln(S).

write_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	write(S).

format_w_ansi(A, S0, E) :-
	add_ansi(A, S0, S),
	format(S, E).
