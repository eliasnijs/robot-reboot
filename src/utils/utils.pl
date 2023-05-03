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

set_element([_|Tail], 0, E, [E|Tail]).
set_element([L0|Ls0], I, E, [L0|Ls1]) :-
    I #> 0, I0 #= I - 1,
    set_element(Ls0, I0, E, Ls1).

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

ansi_color(C, S0, S) :-
	color(C, FG, BG),
	add_ansi([FG, BG], S0, S).

writeln_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	writeln(S).

write_w_ansi(A0, S0) :-
	add_ansi(A0, S0, S),
	write(S).

stringify_move(move(ID, D), S) :-
	( D = vec2(-1,  0) -> build_string([ID, 'L'], S)
	; D = vec2( 0,  1) -> build_string([ID, 'D'], S)
	; D = vec2( 0, -1) -> build_string([ID, 'U'], S)
	; D = vec2( 1,  0) -> build_string([ID, 'R'], S)).
