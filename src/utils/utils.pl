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

