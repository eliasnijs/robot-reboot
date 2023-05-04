vec2(X, Y, vec2(X, Y)).
vec2_add(vec2(X1, Y1), vec2(X2, Y2), vec2(X3, Y3)) :-
	X3 #= X1 + X2,
	Y3 #= Y1 + Y2.
vec2_mult(M, vec2(X, Y), vec2(X3, Y3)) :-
	X3 #= X * M,
	Y3 #= Y * M.

set_element([_|Tail], 0, E, [E|Tail]).
set_element([L0|Ls0], I, E, [L0|Ls1]) :-
    I #> 0, I0 #= I - 1,
    set_element(Ls0, I0, E, Ls1).

build_string(L, S) :-
	atomic_list_concat(L, S).

read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

at_border(W, H, vec2(X, Y)) :-
	( X = 0 ; Y = 0 ; X #= W - 1 ; Y #= H - 1),
	between(0, W, X),
	between(0, H, Y).

neighbours(wall(_, P), Ws, N) :-
	vec2_add(P, vec2( 0, -1), PT),
	vec2_add(P, vec2( 1,  0), PR),
	vec2_add(P, vec2( 0,  1), PB),
	vec2_add(P, vec2(-1,  0), PL),
	maplist({Ws}/[W,R]>>(member(W, Ws) -> R = true ; R = false), [wall(_, PT), wall(_, PR), wall(_, PB), wall(_, PL)], N).
