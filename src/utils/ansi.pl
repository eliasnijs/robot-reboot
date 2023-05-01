ansi(reset, 	'\033[0m').
ansi(clear, 	'\033[2J').

ansi(pos(R, C), S) :-
	build_string(['\033[', R, ';', C, 'H'], S).
ansi(up(H), S) :-
	build_string(['\033[', H, 'A'], S).
ansi(column(C), S) :-
	build_string(['\033[', C, 'G'], S).

ansi(bold, 		'\033[1m').
ansi(dim, 		'\033[2m').
ansi(italic, 		'\033[3m').
ansi(underline, 	'\033[4m').
ansi(blink, 		'\033[5m').
ansi(inverse, 		'\033[7m').
ansi(hidden, 		'\033[8m').
ansi(strikethrough, 	'\033[9m').

ansi(cursor_hidden, 	'\033[?25l').
ansi(cursor_visible, 	'\033[?25h').

ansi(fg(R,G,B), S) :-
    build_string(['\033[38;2;', R, ';', G, ';', B, 'm'], S).

ansi(bg(R,G,B), S) :-
    build_string(['\033[48;2;', R, ';', G, ';', B, 'm'], S).
