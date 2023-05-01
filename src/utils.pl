vec2_add(vec2(X1, Y1), vec2(X2, Y2), vec2(X3, Y3)) :-
	X3 #= X1 + X2,
	Y3 #= Y1 + Y2.

vec_equal(vec2(X1, Y1), vec2(X2, Y2)) :-
	X1 = X2,
	Y1 = Y2.

replace_chars([], _, _, []).
replace_chars([C|Cs], From, To, [NewC|NewCs]) :-
	(nth0(_, From, C) -> NewC = To ; NewC = C),
	replace_chars(Cs, From, To, NewCs).

concat_sublists([], _, []).
concat_sublists([L0|Ls], C, S) :-
	concat_sublists(Ls, C, S0),
	append(L0, [C|S0], S).

replace(_, _, [], []).
replace(E0, E, [E0|T], [E|T2]) :-
	replaceP(E, E0, T, T2).
replace(E0, E, [H|T], [H|T2]) :-
	dif(H,E0),
	replaceP(E0, E, T, T2).

set_element(L0, I, E, L) :-
	length(Prefix, I),
    	append(Prefix, [_|Suffix], L0),
    	append(Prefix, [E|Suffix], L).

set_element(L0, X, Y, E, L) :-
	nth0(Y, L0, R0),
	set_element(R0, X, E, R),
	set_element(L0, Y, R, L).

build_string(L, S) :-
	atomic_list_concat(L, S).

ansi(reset, 	'\033[0m').
ansi(bold, 	'\033[22m').
ansi(blink, 	'\033[25m').
ansi(inverse, 	'\033[27m').
ansi(fg(R,G,B), S) :-
    build_string(['\033[38;2;', R, ';', G, ';', B, 'm'], S).
ansi(bg(R,G,B), S) :-
    build_string(['\033[48;2;', R, ';', G, ';', B, 'm'], S).
