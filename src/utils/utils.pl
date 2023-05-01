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

get_element(L, I, E) :-
	nth0(I, L, E).

get_element_2d(L, vec2(X, Y), E) :-
	nth0(Y, L, R),
	get_element(R, X, E).

set_element(L0, I, E, L) :-
	length(Prefix, I),
    	append(Prefix, [_|Suffix], L0),
    	append(Prefix, [E|Suffix], L).

set_element_2d(L0, vec2(X, Y), E, L) :-
	nth0(Y, L0, R0),
	set_element(R0, X, E, R),
	set_element(L0, Y, R, L).

build_string(L, S) :-
	atomic_list_concat(L, S).

add_ansi(A0, S0, S) :-
	maplist(ansi, A0, A1),
	build_string(A1, A),
	ansi(reset, Ar),
	build_string([A, S0, Ar], S).

writeln_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	writeln(S).

write_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	write(S).
